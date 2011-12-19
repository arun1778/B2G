# Call overlays before running other builds
BUILD_PEKALL_APP := true
PRODUCT_PACKAGE_OVERLAYS := device/imc/xmm2231gl1_0/overlay

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
    persist.sys.language=zh \
    persist.sys.timezone = Asia/Shanghai \
    persist.sys.country=CN 

PRODUCT_NAME   := xmm2231gl_1g
PRODUCT_DEVICE := xmm2231gl_1g
PRODUCT_BRAND  := imc
PRODUCT_LOCALES :=ldpi zh_CN en_US

#BUILD_CMCC_OR_MARKET
BUILD_CMCC_OR_MARKET := open


include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

PRODUCT_COPY_FILES += \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg

BUILD_WITH_PEKALL_FMRADIO := true
 
#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
include device/pekall/pekall.mk
endif
