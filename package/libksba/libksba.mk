################################################################################
#
# libksba
#
################################################################################

LIBKSBA_VERSION = 1.6.3
LIBKSBA_SOURCE = libksba-$(LIBKSBA_VERSION).tar.bz2
LIBKSBA_SITE = https://gnupg.org/ftp/gcrypt/libksba
LIBKSBA_LICENSE = LGPL-3.0+ or GPL-2.0+ (library, headers), GPL-3.0+ (manual, tests, build system)
LIBKSBA_LICENSE_FILES = AUTHORS COPYING COPYING.GPLv2 COPYING.GPLv3 COPYING.LGPLv3
LIBKSBA_CPE_ID_VENDOR = libksba_project
LIBKSBA_INSTALL_STAGING = YES
LIBKSBA_DEPENDENCIES = libgpg-error
HOST_LIBKSBA_DEPENDENCIES = host-libgpg-error
LIBKSBA_CONF_OPTS = --with-gpg-error-prefix=$(STAGING_DIR)/usr

$(eval $(autotools-package))
$(eval $(host-autotools-package))
