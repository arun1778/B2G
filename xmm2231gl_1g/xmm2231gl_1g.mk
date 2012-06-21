BUILD_PEKALL_APP := true

#BUILD_TARGET
#Option: openmarket
#Option: china
#Option: cmcc
BUILD_TARGET := openmarket

ifeq ($(BUILD_TARGET), cmcc)
PRODUCT_PACKAGE_OVERLAYS += device/pekall/cmcc/overlay
endif

# Call overlays before running other builds
PRODUCT_PACKAGE_OVERLAYS += device/imc/xmm2231gl1_0/overlay

PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
	AlarmClock \
    AvrcpPlayer \
    csrApps \
    HIDApp \
    PrintFile \
    PushFile \
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
    QuickSearchBox \
    Settings \
    Sync \
    Updater \
    CalendarProvider \
    SyncProvider \
    Stk \
    ClockSet


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true \
    persist.sys.language=en \
    persist.sys.country=US

PRODUCT_NAME   := xmm2231gl_1g
PRODUCT_DEVICE := xmm2231gl_1g
PRODUCT_BRAND  := imc
PRODUCT_LOCALES :=ldpi zh_CN en_US


include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

PRODUCT_COPY_FILES += \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg

BUILD_WITH_PEKALL_FMRADIO := true

#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
include device/pekall/pekall.mk
endif
