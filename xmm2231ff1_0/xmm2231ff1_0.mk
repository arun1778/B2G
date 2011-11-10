PRODUCT_PACKAGES := \
    AccountAndSyncSettings \
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
    Stk


$(call inherit-product, build/target/product/generic.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.enable-record=true

PRODUCT_NAME   := xmm2231ff1_0
PRODUCT_DEVICE := xmm2231ff1_0
PRODUCT_BRAND  := imc

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk


