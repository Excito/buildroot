#!/bin/sh

cp board/excito/bubbatwo/{{8313E21,install}.{its,dts},reloc_shim_itb.S} $1

cd $1

echo "Preparing vmlinux.bin"
powerpc-linux-objcopy -O binary vmlinux vmlinux.bin

echo "Compiling reloc_shim_itb.S"
powerpc-linux-as -mregnames -me300 -o reloc_shim_itb.o reloc_shim_itb.S
powerpc-linux-objcopy -O binary reloc_shim_itb.o reloc_shim_itb.bin

echo "Compiling 8313E21.dts"
dtc -I dts -O dtb -o 8313E21.dtb 8313E21.dts
echo "Compiling install.dts"
dtc -I dts -O dtb -o install.dtb install.dts

echo "Generating 8313E21.itb"
mkimage -f 8313E21.its 8313E21.itb
echo "Generating install.itb"
mkimage -f install.its install.itb

mkdir -p $BASE_DIR/excito/install

mv 8313E21.itb $BASE_DIR/excito/install
mv install.itb $BASE_DIR/excito/install

rm {{8313E21,install}.{its,dts},reloc_shim_itb.S}
