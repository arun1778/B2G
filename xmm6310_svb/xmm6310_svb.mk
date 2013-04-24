# Copyright (C) 2011 - 2012 Intel Mobile Communications GmbH
# Notes:
# May 30 2012: Bootanimation support
# Jun 07 2012: Add partial GMS package into FFRD build
# Jun 25 2012: [XMM2231_V2:CTS]: Implement MK file modifications in order to pass PackageSignatureTest of CtsSecurityTestCases.
# Nov 02 2012: Modify for xmm6310_svb
# Apr 26 2013: Workspace contains both AOSP RIL & RPC RIL, if BUILD_RIL_TYPE set to RPC then AOSP RIL will not be built

#RIL type RPC or AT based
BUILD_RIL_TYPE := RPC

BUILD_PEKALL_APP := true
#BUILD_TARGET
#Option: openmarket
#Option: china
#Option: cmcc
BUILD_TARGET := openmarket
TARGET_BOARD_PLATFORM := xmm6310
ifeq ($(BUILD_TARGET), cmcc)
PRODUCT_PACKAGE_OVERLAYS += device/pekall/cmcc/overlay
endif

#
# Path for the Intel keys and certificates
#
RELEASE_KEY_PATH := device/imc/common/security

# Call overlays before running other builds
PRODUCT_PACKAGE_OVERLAYS += device/imc/xmm6310_svb/overlay

PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
	AlarmClock \
    ApiDemos \
    AvrcpPlayer \
    csrApps \
    HIDApp \
    PrintFile \
    PushFile \
    DeskClock \
    AlarmProvider \
    Bluetooth \
    Calculator \
    Calendar \
    Camera \
    CertInstaller \
    DrmProvider \
    Email \
    Gallery \
    LatinIME \
    PinyinIME \
    Launcher2 \
    Mms \
    Music \
    Provision \
    Protips \
    QuickSearchBox \
    Settings \
    Sync \
    Updater \
    CalendarProvider \
    SyncProvider \
    Stk \
    ClockSet \
    copybit.$(TARGET_BOARD_PLATFORM) \
    overlay.$(TARGET_BOARD_PLATFORM) \
    lights.$(TARGET_BOARD_PLATFORM) \
    gralloc.$(TARGET_BOARD_PLATFORM) \
    libstagefrighthw \
    libcamera \
    sensors.$(TARGET_BOARD_PLATFORM) \
    alsa.default \
    chargeonly \
    gps.$(TARGET_BOARD_PLATFORM)

ifeq ($(DELIVERY),'YES')
PRODUCT_PACKAGES += libstagefright
endif


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true \
    ro.config.ringtone=SitarVsSitar.ogg \
    persist.sys.language=en \
    persist.sys.country=US \
    windowsmgr.max_events_per_sec=240

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number (currently 1.0)
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version=65536

PRODUCT_NAME   := xmm6310_svb
PRODUCT_DEVICE := xmm6310_svb
PRODUCT_BRAND  := imc
PRODUCT_LOCALES :=ldpi zh_CN en_US

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

#include English TTS lang for CTS
include external/svox/pico/lang/PicoLangDefaultInSystem.mk

PRODUCT_COPY_FILES += \
	device/imc/xmm6310_svb/quickbootanim.zip:system/media/quickbootanim.zip \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg

BUILD_WITH_PEKALL_FMRADIO := true

#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
include device/pekall/pekall.mk
endif

#include GMS package
BUILD_GMS_ALL := false
#include external/gms/google/products/gms.mk
