BUILD_PEKALL_APP := false
#BUILD_TARGET
#Option: openmarket
#Option: china
#Option: cmcc
BUILD_TARGET := openmarket
TARGET_BOARD_PLATFORM := mbd_xmm2231
ifeq ($(BUILD_TARGET), cmcc)
PRODUCT_PACKAGE_OVERLAYS += device/pekall/cmcc/overlay
endif

# Call overlays before running other builds
PRODUCT_PACKAGE_OVERLAYS += device/imc/xmm2231ff1_0/overlay

PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
	AlarmClock \
    ApiDemos \
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
    alsa.default


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true \
    persist.sys.language=en \
    persist.sys.country=US

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number (currently 1.0)
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version=65536

PRODUCT_NAME   := xmm2231ff1_0
PRODUCT_DEVICE := xmm2231ff1_0
PRODUCT_BRAND  := imc
PRODUCT_LOCALES :=mdpi

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

PRODUCT_COPY_FILES += \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg
 
BUILD_WITH_PEKALL_FMRADIO := true

#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
include device/pekall/pekall.mk
endif
