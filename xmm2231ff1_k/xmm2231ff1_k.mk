# Copyright (C) 2011 - 2012 Intel Mobile Communications GmbH
# Notes:
# May 30 2012: Bootanimation support
# Jun 07 2012: Add partial GMS package into FFRD build
# Jun 25 2012: [XMM2231_V2:CTS]: Implement MK file modifications in order to pass PackageSignatureTest of CtsSecurityTestCases.
# Jul 09 2012: Enable full GMS build by default for DELIVERY!=YES
# Aug 01 2012: Fix OTA generation script failure
# Aug 17 2012: Remove ApiDemos package

BUILD_PEKALL_APP := true
#BUILD_TARGET
#Option: openmarket
#Option: china
#Option: cmcc
BUILD_TARGET := openmarket
TARGET_BOARD_PLATFORM := mbd_xmm2231
ifeq ($(BUILD_TARGET), cmcc)
PRODUCT_PACKAGE_OVERLAYS += device/pekall/cmcc/overlay
endif

#
# Path for the Intel keys and certificates
#
RELEASE_KEY_PATH := device/imc/common/security

# Call overlays before running other builds
PRODUCT_PACKAGE_OVERLAYS += device/imc/xmm2231ff1_k/overlay

PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
	AlarmClock \
    AvrcpPlayer \
    csrApps \
    HIDApp \
    PrintFile \
    PushFile \
    RFTest \
    SynergyFM \
    CarHome \
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

ifneq '$(DELIVERY)' 'YES'
# Configure GMS build for 2231
BUILD_GMS_NO_VIDEO_CHAT := true # no front camera support available
#  Following var need to be set for flash image generation part of android build
#  to pass. Make sure the variable settings coincide with int team Android build 
#  script.
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 167772160 #160M for passing android make image
BOARD_FLASH_BLOCK_SIZE := 4096

#include GMS package
$(call inherit-product, external/gms/google/products/gms.mk)

# Configure client id for GMS on Android
# Allow bypassing of setup wizard
PRODUCT_PROPERTY_OVERRIDES += \
	ro.com.google.clientidbase=android-imc \
	ro.setupwizard.mode=OPTIONAL

endif

PRODUCT_NAME   := xmm2231ff1_k
PRODUCT_DEVICE := xmm2231ff1_k
PRODUCT_BRAND  := imc
PRODUCT_LOCALES :=ldpi zh_CN en_US

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

#include English TTS lang for CTS
include external/svox/pico/lang/PicoLangDefaultInSystem.mk

PRODUCT_COPY_FILES += \
	device/imc/xmm2231ff1_k/quickbootanim.zip:system/media/quickbootanim.zip \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg
 
BUILD_WITH_PEKALL_FMRADIO := true

#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
include device/pekall/pekall.mk
endif
