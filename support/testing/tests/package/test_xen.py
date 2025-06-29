import os
import pexpect
import infra.basetest


class TestXen(infra.basetest.BRTest):
    # We have a custom kernel config to reduce build time.
    # Our genimage.cfg is inspired from qemu_aarch64_ebbr_defconfig as we boot
    # Xen with UEFI. We run only in the initramfs; this allows to use a single
    # ramdisk image for both the host and the guest.
    # The Xen startup scripts need bash.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_OVERLAY="support/testing/tests/package/test_xen/overlay"
        BR2_ROOTFS_POST_BUILD_SCRIPT="support/testing/tests/package/test_xen/post-build.sh"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/testing/tests/package/test_xen/post-image.sh support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c support/testing/tests/package/test_xen/genimage.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.9"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/package/test_xen/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_XEN=y
        BR2_PACKAGE_XEN_HYPERVISOR=y
        BR2_PACKAGE_XEN_TOOLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_UBOOT=y
        BR2_TARGET_UBOOT_BUILD_SYSTEM_KCONFIG=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION_VALUE="2025.01"
        BR2_TARGET_UBOOT_BOARD_DEFCONFIG="qemu_arm64"
        BR2_TARGET_UBOOT_NEEDS_OPENSSL=y
        BR2_TARGET_UBOOT_NEEDS_GNUTLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        """

    def get_dom_uuid(self) -> str:
        out, rc = self.emulator.run("cat /sys/hypervisor/uuid")
        self.assertEqual(rc, 0, "Failed to get domain UUID")
        return out[0]

    def assertNumVM(self, x: int) -> None:
        out, rc = self.emulator.run("xl vm-list")
        self.assertEqual(rc, 0, "Failed to get VM list")
        num_vm = len(out) - 1
        self.assertEqual(num_vm, x, f"Expected {x} VM(s) but found {num_vm}")

    def test_run(self):
        uboot_bin = os.path.join(self.builddir, "images", "u-boot.bin")
        disk_img = os.path.join(self.builddir, "images", "disk.img")

        # We need to run Qemu with virtualization to run Xen.
        qemu_opts = [
            "-bios", uboot_bin,
            "-cpu", "cortex-a53",
            "-device", "virtio-blk-device,drive=hd0",
            "-drive", f"file={disk_img},if=none,format=raw,id=hd0",
            "-m", "1G",
            "-machine", "virt,gic-version=3,virtualization=on,acpi=off",
            "-smp", "2"
        ]

        # Boot the emulator:
        # Qemu Devicetree -> U-Boot -> Xen UEFI -> Linux
        # We need to boot Xen in UEFI to read xen.cfg; we use U-Boot as our
        # UEFI firmware.
        self.emulator.boot(arch="aarch64", options=qemu_opts)
        self.emulator.login()

        # Verify that we are indeed running under Xen.
        self.assertRunOk("xl info")

        # Check that we are dom0.
        uuid = self.get_dom_uuid()
        dom0_uuid = "00000000-0000-0000-0000-000000000000"
        self.assertEqual(uuid, dom0_uuid, f"Unexpected dom UUID {uuid}")

        # Check that we have one VM running.
        self.assertNumVM(1)

        # Create dom1 with console attached and login.
        self.emulator.qemu.sendline("xl create -c /etc/xen/dom1.cfg")
        self.emulator.login()

        # Check that we are not talking to dom0 anymore.
        uuid = self.get_dom_uuid()
        self.assertNotEqual(uuid, dom0_uuid, "Unexpected dom0 UUID")

        # Detach from dom1's console with CTRL-].
        # dom1 is still running in the background after that.
        self.emulator.qemu.send(chr(0x1d))
        mult = self.emulator.timeout_multiplier
        index = self.emulator.qemu.expect(["#", pexpect.TIMEOUT],
                                          timeout=2 * mult)
        self.assertEqual(index, 0, "Timeout exiting guest")

        # Check that we are talking to dom0 again.
        uuid = self.get_dom_uuid()
        self.assertEqual(uuid, dom0_uuid, f"Unexpected dom UUID {uuid}")

        # Check that we have two VMs running.
        self.assertNumVM(2)
