################################################################################
#
# write-magic
#
################################################################################

WRITE_MAGIC_VERSION = 1.0
WRITE_MAGIC_SITE = $(TOPDIR)/board/excito/b3/write-magic
WRITE_MAGIC_SITE_METHOD = local

define WRITE_MAGIC_BUILD_CMDS
	$(TARGET_CC) -Os -Wall -o $(@D)/write-magic $(@D)/write-magic.c
endef

define WRITE_MAGIC_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/write-magic $(TARGET_DIR)/sbin
endef

$(eval $(generic-package))
