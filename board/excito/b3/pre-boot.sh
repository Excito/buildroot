#!/bin/bash

mkdir -p $BASE_DIR/excito/lib
rm -rf $TARGET_DIR/{root,home,media,opt,proc,run,tmp}
mv $TARGET_DIR/lib/modules $BASE_DIR/excito/lib
rm -f $TARGET_DIR/lib/libgcc_s.so $TARGET_DIR/lib/libgcc_s.so.1
