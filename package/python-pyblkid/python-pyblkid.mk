################################################################################
#
# python-pyblkid
#
################################################################################

PYTHON_PYBLKID_VERSION = 96e88963217e1beabcbad6dfeff878750766b2b6
PYTHON_PYBLKID_SITE = $(call github,digitie,pyblkid,$(PYTHON_PYBLKID_VERSION))
PYTHON_PYBLKID_LICENSE = GPL-v2
PYTHON_PYBLKID_LICENSE_FILES = LICENSE
PYTHON_PYBLKID_SETUP_TYPE = distutils
PYTHON_PYBLKID_DEPENDENCIES = util-linux

$(eval $(python-package))
