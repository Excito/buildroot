## Excito Buildroot

This is the 2015.02 buildroot source tree with the B3 and B2 board modifications to generate an updated rescue/install system.

## Content

For now the generated image contains only network tools and a ssh server to connect remotely to connect to the system.

## Building

clone this repository and run these commands :

```
make excito_b3_defconfig
make
```

The generated install.itb file will be available in output/images

## Using

Place the install.itb file in the install directory of a fat-formatted usb disk and run the b3 with power button pushed.
