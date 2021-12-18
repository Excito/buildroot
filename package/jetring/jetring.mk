################################################################################
#
# jetring
#
################################################################################

JETRING_VERSION = 0.30
JETRING_SITE = http://http.debian.net/debian/pool/main/j/jetring
JETRING_SOURCE = jetring_$(JETRING_VERSION).tar.xz
JETRING_DEPENDENCIES = host-gnupg2
JETRING_LICENSE_FILES = debian/copyright

define HOST_JETRING_INSTALL_CMDS
	$(MAKE) -C $(@D) DESTDIR=$(HOST_DIR) install
endef

$(eval $(host-generic-package))
