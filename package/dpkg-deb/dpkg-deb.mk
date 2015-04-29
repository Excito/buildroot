################################################################################
#
# dpkg-deb
#
################################################################################

DPKG_DEB_VERSION = 1.17.25
DPKG_DEB_SOURCE = dpkg_$(DPKG_DEB_VERSION).tar.xz
DPKG_DEB_SITE = http://http.debian.net/debian/pool/main/d/dpkg
DPKG_DEB = GPL-2+
DPKG_DEB_LICENSE_FILES = COPYING
HOST_DPKG_DEB_DEPENDENCIES = host-zlib
HOST_DPKG_DEB_CONF_OPTS = --disable-dselect --disable-start-stop-daemon --disable-update-alternatives --enable-static --disable-shared

define HOST_DPKG_DEB_BUILD_CMDS
	make -C $(@D)/lib/compat
	make -C $(@D)/lib/dpkg
	make -C $(@D)/dpkg-deb
endef

define HOST_DPKG_DEB_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dpkg-deb/dpkg-deb $(HOST_DIR)/usr/bin/dpkg-deb
endef

$(eval $(host-autotools-package))
