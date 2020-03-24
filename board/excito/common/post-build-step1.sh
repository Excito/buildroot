#!/bin/bash

mkdir -p $BASE_DIR/excito
[ -e $BASE_DIR/excito/modules ] && rm -rf $BASE_DIR/excito/modules
mv $TARGET_DIR/lib/modules $BASE_DIR/excito
rm -f $TARGET_DIR/lib/libgcc_s.so $TARGET_DIR/lib/libgcc_s.so.1
rm -rf $TARGET_DIR/etc/{hostname,issue,network,os-release,ld.so.conf}
