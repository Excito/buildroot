################################################################################
#
# fsarchiver
#
################################################################################

FSARCHIVER_VERSION = 0.8.8
FSARCHIVER_SOURCE = fsarchiver-$(FSARCHIVER_VERSION).tar.gz
FSARCHIVER_SITE = $(call github,fdupoux,fsarchiver,$(FSARCHIVER_VERSION))
FSARCHIVER_LICENSE_FILE = COPYING
FSARCHIVER_DEPENDENCIES = attr zlib bzip2 libgcrypt util-linux e2fsprogs xz lzo lz4 zstd
FSARCHIVER_AUTORECONF = YES

$(eval $(autotools-package))
