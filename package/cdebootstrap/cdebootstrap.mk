################################################################################
#
# cdebootstrap
#
################################################################################

CDEBOOTSTRAP_VERSION = 0.7.7
CDEBOOTSTRAP_SOURCE = cdebootstrap_$(CDEBOOTSTRAP_VERSION).tar.xz
CDEBOOTSTRAP_SITE = http://http.debian.net/debian/pool/main/c/cdebootstrap
CDEBOOTSTRAP_LICENSE_FILE = debian/copyright
CDEBOOTSTRAP_DEPENDENCIES = bzip2 libcurl xz zlib debian-archive-keyring libdebian-installer
CDEBOOTSTRAP_AUTORECONF = YES
CDEBOOTSTRAP_CONF_OPTS = --with-frontend=standalone

$(eval $(autotools-package))
