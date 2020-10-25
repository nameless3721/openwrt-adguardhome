#
# Copyright (C) 2019-2020 honwen <https://github.com/honwen>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=AdGuardHome
PKG_VERSION:=0.104.0-beta3
PKG_RELEASE:=20201026
PKG_MAINTAINER:=AdguardTeam

# OpenWrt ARCH: arm, aarch64, i386, x86_64, mips, mipsel
# Golang ARCH: armv[5-7], armv8, 386, amd64, mips, mipsle
PKG_ARCH:=$(ARCH)
ifeq ($(ARCH),mips)
	PKG_ARCH:=mips-softfloat
endif
ifeq ($(ARCH),mipsel)
	PKG_ARCH:=mipsle-softfloat
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
	PKG_ARCH:=arm64
endif

PKG_SOURCE:=AdGuardHome_linux_$(PKG_ARCH).tar.gz
PKG_SOURCE_URL:=https://github.com/AdguardTeam/AdGuardHome/releases/download/v$(PKG_VERSION)/
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=net
	CATEGORY:=Network
	TITLE:=Network-wide ads & trackers blocking DNS server
	DEPENDS:=+kmod-tun +htop +bind-dig +nano +luci-app-openclash +luci-app-wireguard +luci-app-smartdns +luci-app-adguardhome +openssh-sftp-server +luci-app-ttyd +luci-app-vnstat +luci-app-netdata
	URL:=https://github.com/AdguardTeam/AdGuardHome
endef

define Package/$(PKG_NAME)/description
Network-wide ads & trackers blocking DNS server
endef

define Build/Prepare
    tar -zxvf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR)
	mv $(DL_DIR)/$(PKG_SOURCE) $(DL_DIR)/AdGuardHome_linux_$(PKG_ARCH)_$(PKG_VERSION)_$(PKG_RELEASE).tar.gz
endef

define Build/Compile
	echo "$(PKG_NAME) Compile Skiped!"
endef

define Package/AdGuardHome/install
	$(INSTALL_DIR) $(1)/etc/adg
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/AdGuardHome/AdGuardHome $(1)/etc/adg
endef

$(eval $(call BuildPackage,AdGuardHome))
