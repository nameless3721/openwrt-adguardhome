#
# Copyright (C) 2019-2020 honwen <https://github.com/honwen>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=clash
PKG_VERSION:=1.6.0
PKG_RELEASE:=20210411
PKG_MAINTAINER:=Dreamacro

# OpenWrt ARCH: arm, aarch64, i386, x86_64, mips, mipsel
# Golang ARCH: armv[5-7], armv8, 386, amd64, mips, mipsle
PKG_ARCH:=$(ARCH)
ifeq ($(ARCH),mips)
	PKG_ARCH:=mips-softfloat
endif
ifeq ($(ARCH),mipsel)
	PKG_ARCH:=mipsle-hardfloat
endif
ifeq ($(ARCH),i386)
	PKG_ARCH:=386
endif
ifeq ($(ARCH),x86_64)
	PKG_ARCH:=amd64
endif
ifeq ($(ARCH),arm)
	PKG_ARCH:=armv6
	ifneq ($(BOARD),bcm53xx)
		PKG_ARCH:=armv7
	endif
	ifeq ($(BOARD),kirkwood)
		PKG_ARCH:=armv5
	endif
endif
ifeq ($(ARCH),aarch64)
	PKG_ARCH:=armv8
endif

PKG_SOURCE:=clash-linux-$(PKG_ARCH)-v$(PKG_VERSION).gz
PKG_SOURCE_URL:=https://github.com/Dreamacro/clash/releases/download/v$(PKG_VERSION)/
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/clash
	SECTION:=net
	CATEGORY:=Network
	TITLE:=A rule-based tunnel in Go.
	URL:=https://github.com/Dreamacro
endef

define Package/clash/description
	A rule-based tunnel in Go.
endef

define Build/Prepare
	gzip -d $(DL_DIR)/$(PKG_SOURCE) 
	mv -f $(DL_DIR)/clash-linux-$(PKG_ARCH)-v$(PKG_VERSION) $(PKG_BUILD_DIR)/clash
endef

define Build/Compile
	echo "$(PKG_NAME) Compile Skiped!"
endef

define Package/clash/install
	$(INSTALL_DIR) $(1)/etc/openclash/core
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/clash $(1)/etc/openclash/core
endef

$(eval $(call BuildPackage,clash))
