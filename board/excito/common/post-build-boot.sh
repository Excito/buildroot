#!/bin/bash

mkdir -p $BASE_DIR/excito
mv $TARGET_DIR/lib/modules $BASE_DIR/excito
rm -f $TARGET_DIR/lib/libgcc_s.so $TARGET_DIR/lib/libgcc_s.so.1
rm -rf $TARGET_DIR/etc/{hostname,hosts,issue,network,os-release,ld.so.conf}
