#!/bin/sh

echo "Patching kernel for U-Boot kirkwood bug"
(
cd $1
mv zImage zImage.old

echo -n -e \\x11\\x3f\\x3f\\xee > zImage
echo -n -e \\x01\\x35\\xc3\\xe3 >> zImage
echo -n -e \\x11\\x3f\\x2f\\xee >> zImage
echo -n -e \\x00\\x30\\xa0\\xe3 >> zImage
echo -n -e \\x17\\x3f\\x07\\xee >> zImage
cat zImage.old >> zImage
rm zImage.old
)

echo "Generating install.itb"
cp board/excito/b3/install.its $1

(
cd $1
mkimage -f install.its install.itb
)
