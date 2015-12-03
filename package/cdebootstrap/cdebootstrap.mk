################################################################################
#
# cdebootstrap
#
################################################################################

CDEBOOTSTRAP_VERSION = 0.6.4
CDEBOOTSTRAP_SOURCE = cdebootstrap_$(CDEBOOTSTRAP_VERSION).tar.gz
CDEBOOTSTRAP_SITE = http://ftp.de.debian.org/debian/pool/main/c/cdebootstrap
CDEBOOTSTRAP_LICENSE_FILE = debian/copyright
CDEBOOTSTRAP_DEPENDENCIES = bzip2 xz zlib libdebian-installer host-dpkg-deb

$(eval $(autotools-package))
