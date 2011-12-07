PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
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
    Stk


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true

PRODUCT_NAME   := xmm2231gl_1g
PRODUCT_DEVICE := xmm2231gl_1g
PRODUCT_BRAND  := imc

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk
