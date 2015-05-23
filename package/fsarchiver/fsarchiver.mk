################################################################################
#
# fsarchiver
#
################################################################################

FSARCHIVER_VERSION = 0.6.19
FSARCHIVER_SOURCE = fsarchiver-$(FSARCHIVER_VERSION).tar.gz
FSARCHIVER_SITE =  http://downloads.sourceforge.net/project/fsarchiver/fsarchiver-src/$(FSARCHIVER_VERSION)
FSARCHIVER_LICENSE_FILE = COPYING
FSARCHIVER_DEPENDENCIES = zlib bzip2 libgcrypt util-linux e2fsprogs xz
FSARCHIVER_CONF_OPTS = --disable-lzo

$(eval $(autotools-package))
