################################################################################
#
# debian-archive-keyring
#
################################################################################

DEBIAN_ARCHIVE_KEYRING_VERSION = 2014.3
DEBIAN_ARCHIVE_KEYRING_SOURCE = debian-archive-keyring_$(DEBIAN_ARCHIVE_KEYRING_VERSION).tar.xz
DEBIAN_ARCHIVE_KEYRING_SITE = http://ftp.de.debian.org/debian/pool/main/d/debian-archive-keyring
DEBIAN_ARCHIVE_KEYRING_LICENSE_FILES = debian/copyright
DEBIAN_ARCHIVE_KEYRING_DEPENDENCIES = host-jetring host-gnupg

define DEBIAN_ARCHIVE_KEYRING_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
