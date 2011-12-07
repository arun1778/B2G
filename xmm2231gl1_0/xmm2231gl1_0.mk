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
    media.stagefright.enable-record=true \
    ro.xmm2231-ota=true


# The OpenGL ES API level that is natively supported by this device.
# This is a 16.16 fixed point number (currently 1.0)
PRODUCT_PROPERTY_OVERRIDES += ro.opengles.version=65536

PRODUCT_NAME   := xmm2231gl1_0
PRODUCT_DEVICE := xmm2231gl1_0
PRODUCT_BRAND  := imc

include frameworks/base/data/sounds/OriginalAudio.mk
include device/common/gps/gps_as_supl.mk


