#!/bin/sh

for f in bubbatwo.dts reloc_shim_itb.S 8313E21.its; do
  cp board/excito/bubbatwo/$f $1
done

cd $1

echo "Compiling bubbatwo.dts"
dtc -I dts -O dtb -o bubbatwo.dtb bubbatwo.dts

echo "Preparing vmlinux.bin"
powerpc-linux-objcopy -O binary vmlinux vmlinux.bin

echo "Compiling reloc_shim_itb.S"
powerpc-linux-as -mregnames -me300 -o reloc_shim_itb.o reloc_shim_itb.S
powerpc-linux-objcopy -O binary reloc_shim_itb.o reloc_shim_itb.bin

echo "Generating 8313E21.itb"

mkimage -f 8313E21.its 8313E21.itb

rm vmlinux.bin bubbatwo.dts bubbatwo.dtb reloc_shim_itb.S reloc_shim_itb.o reloc_shim_itb.bin 8313E21.its
