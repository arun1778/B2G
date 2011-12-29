# Call overlays before running other builds
BUILD_PEKALL_APP := true
PRODUCT_PACKAGE_OVERLAYS := device/imc/xmm2231ff1_0/overlay

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
    ClockSet


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true \
    persist.sys.language=zh \
    persist.sys.timezone = Asia/Shanghai \
    persist.sys.country=CN 

# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number (currently 1.0)
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version=65536

PRODUCT_NAME   := xmm2231ff1_0
PRODUCT_DEVICE := xmm2231ff1_0
PRODUCT_BRAND  := imc

#BUILD_CMCC_OR_MARKET
BUILD_CMCC_OR_MARKET := china


include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk

PRODUCT_COPY_FILES += \
	frameworks/base/data/sounds/effects/LowBattery.ogg:system/media/audio/ui/LowBattery.ogg
 
BUILD_WITH_PEKALL_FMRADIO := true

#Include Pekall's Makefile
ifeq ($(BUILD_PEKALL_APP), true)
PRODUCT_LOCALES :=ldpi zh_CN en_US
include device/pekall/pekall.mk
endif
