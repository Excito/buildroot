################################################################################
#
# libdebian-installer
#
################################################################################

LIBDEBIAN_INSTALLER_VERSION = 0.125
LIBDEBIAN_INSTALLER_SOURCE = libdebian-installer_$(LIBDEBIAN_INSTALLER_VERSION).tar.xz
LIBDEBIAN_INSTALLER_SITE = http://http.debian.net/debian/pool/main/libd/libdebian-installer
LIBDEBIAN_INSTALLER_LICENSE_FILE = debian/copyright
LIBDEBIAN_INSTALLER_DEPENDENCIES = check
LIBDEBIAN_INSTALLER_AUTORECONF = YES
LIBDEBIAN_INSTALLER_INSTALL_STAGING = YES

$(eval $(autotools-package))
