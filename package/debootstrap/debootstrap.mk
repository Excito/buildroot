################################################################################
#
# debootstrap
#
################################################################################

DEBOOTSTRAP_VERSION = 1.0.89
DEBOOTSTRAP_SOURCE = debootstrap_$(DEBOOTSTRAP_VERSION).tar.gz
DEBOOTSTRAP_SITE = http://http.debian.net/debian/pool/main/d/debootstrap
DEBOOTSTRAP_LICENSE_FILE = debian/copyright

define DEBOOTSTRAP_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
