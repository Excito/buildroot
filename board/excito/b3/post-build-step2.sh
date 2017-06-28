#!/bin/bash

echo Copying kernel modules to target ...
cp -r $BASE_DIR/excito/modules $TARGET_DIR/lib

echo Removing S40network ...
rm -f $TARGET_DIR/etc/init.d/S40network
