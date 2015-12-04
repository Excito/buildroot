################################################################################
#
# excito-installer
#
################################################################################

EXCITO_INSTALLER_VERSION = eb2aabc
EXCITO_INSTALLER_SITE = $(call github,Excito,installer,$(EXCITO_INSTALLER_VERSION))

define EXCITO_INSTALLER_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/excito
	$(INSTALL) -m 0644 $(@D)/*.py $(TARGET_DIR)/opt/excito
	$(INSTALL) -m 0755 $(@D)/installer $(TARGET_DIR)/opt/excito
endef

$(eval $(generic-package))
