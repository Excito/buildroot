## Excito Buildroot

This is the 2015.05 buildroot source tree with the B3 and B2 board modifications to generate an updated rescue/install system. It can also generate an x86 'livecd' for testing purpose.

## Content

For now the generated image contains only network tools, ssh, ftp and telnet server to connect to the system. It will run a dhcp client on any connected wired network.

## Building

clone this repository and run these commands for the b3:

```
make excito_b3_defconfig
make
```

for the b2:
```
make excito_bubbatwo_defconfig
make
```

for x86:
```
make excito_x86_defconfig
make
```

The generated file will be available in output/images :
 - install.itb for the b3
 - 8313E21.itb for bubbatwo
 - rootfs.iso9660 for x86

## Using

Place the install.itb (resp. 8313E21.itb) file in the install directory of a fat-formatted usb disk and run the b3 (resp. Bubba|2) with power button pushed.
