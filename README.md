## Excito Buildroot

This is the 2023.02 buildroot source tree with the B3 board modifications to generate an updated rescue/install system.

## Content

The generated image contains network tools, ssh, ftp and telnet server to connect to the system. It will run a dhcp client on any connected wired network.
It also includes the excito installer along with useful diagnostics tools.

## Building

clone this repository and run these commands:

```
make distclean
make excito_b3_step1_defconfig
make
make clean
make excito_b3_step2_defconfig
make
```

The generated files will be available in output/excito/install :
 - `install.itb` and `rootfs.cpio.gz`: rescue system files
 - `install.ini`: default configuration file for excito-installer

## Using

Place the install directory into a fat-formatted usb disk and run the b3 with power button pushed. With default configuration the system will start, configure the network and open ssh, ftp and telnet servers. Login is root with password 'excito' without the quotes.
