################################################################################
#
# debian-archive-keyring
#
################################################################################

DEBIAN_ARCHIVE_KEYRING_VERSION = 2023.2
DEBIAN_ARCHIVE_KEYRING_SOURCE = debian-archive-keyring_$(DEBIAN_ARCHIVE_KEYRING_VERSION).tar.xz
DEBIAN_ARCHIVE_KEYRING_SITE = http://http.debian.net/debian/pool/main/d/debian-archive-keyring
DEBIAN_ARCHIVE_KEYRING_LICENSE_FILES = debian/copyright
DEBIAN_ARCHIVE_KEYRING_DEPENDENCIES = host-jetring

define DEBIAN_ARCHIVE_KEYRING_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE1) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
