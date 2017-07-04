################################################################################
#
# excito-installer
#
################################################################################

EXCITO_INSTALLER_VERSION = 2.0
EXCITO_INSTALLER_SITE = $(call github,Excito,installer,$(EXCITO_INSTALLER_VERSION))

define EXCITO_INSTALLER_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/excito
	$(INSTALL) -m 0644 $(@D)/*.py $(TARGET_DIR)/opt/excito
	$(INSTALL) -m 0755 $(@D)/installer $(TARGET_DIR)/opt/excito
	$(INSTALL) -d -m 0755 $(BASE_DIR)/excito/install
	$(INSTALL) -m 0644 $(@D)/install.ini $(BASE_DIR)/excito/install
endef

$(eval $(generic-package))
