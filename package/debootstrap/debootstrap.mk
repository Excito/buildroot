################################################################################
#
# debootstrap
#
################################################################################

DEBOOTSTRAP_VERSION = 1.0.67
DEBOOTSTRAP_SOURCE = debootstrap_$(DEBOOTSTRAP_VERSION).tar.gz
DEBOOTSTRAP_SITE = http://ftp.de.debian.org/debian/pool/main/d/debootstrap/
DEBOOTSTRAP_LICENSE_FILE = debian/copyright
DEBOOTSTRAP_DEPENDENCIES = host-fakeroot

define DEBOOTSTRAP_BUILD_CMDS
	chmod 755 $(@D)/MAKEDEV
	$(HOST_DIR)/usr/bin/fakeroot $(MAKE) -C $(@D) devices.tar.gz
	CC="$(TARGET_CC)" $(MAKE) -C $(@D) pkgdetails
endef

define DEBOOTSTRAP_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR=$(TARGET_DIR) -C $(@D) install
endef

$(eval $(generic-package))
