## Excito Buildroot

This is the 2015.08 buildroot source tree with the B3 and B2 board modifications to generate an updated rescue/install system. It can also generate an x86 'livecd' for testing purpose.

## Content

For now the generated image contains only network tools, ssh, ftp and telnet server to connect to the system. It will run a dhcp client on any connected wired network.
An updated installer script will kick in shortly.

## Building

clone this repository and run these commands for the B3:

```
make distclean
make excito_b3_step1_defconfig
make
make clean
make excito_b3_step2_defconfig
make
```

for the Bubba|2:
```
make distclean
make excito_bubbatwo_step1_defconfig
make
make clean
make excito_bubbatwo_step2_defconfig
make
```

for x86:
```
make distclean
make excito_x86_defconfig
make
```

The generated file will be available in output/excito :
 - install.itb and rootfs.cpio.gz for the b3
 - 8313E21.itb, install.itb and rootfs.cpio.gz for Bubba|2

For x86, the rootfs.iso9660 ISO file will be available in output/images

## Using

Place the install.itb and rootfs.cpio.gz (add 8313E21.itb for the Bubba|2) files in the install directory of a fat-formatted usb disk and run the b3 (resp. Bubba|2) with power button pushed.
