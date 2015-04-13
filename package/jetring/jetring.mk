################################################################################
#
# jetring
#
################################################################################

JETRING_VERSION = 0.20
JETRING_SITE = http://ftp.de.debian.org/debian/pool/main/j/jetring/
JETRING_SOURCE = jetring_$(JETRING_VERSION).tar.gz
JETRING_DEPENDENCIES = host-gnupg
JETRING_LICENSE_FILES = debian/copyright

define HOST_JETRING_INSTALL_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
