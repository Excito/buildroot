#!/bin/bash

cp board/excito/b3/{install.its,cache_head_patch} $1

echo "Patching kernel for U-Boot kirkwood bug"

cd $1

cat cache_head_patch zImage > zImage.b3

echo "Generating install.itb"

mkimage -f install.its install.itb

rm install.its cache_head_patch zImage.b3
