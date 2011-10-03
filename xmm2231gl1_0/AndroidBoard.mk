LOCAL_PATH := $(call my-dir)

#
# keyboard layouts
#
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/vkp.kl:system/usr/keylayout/vkp.kl
# keyboard maps
#
include $(CLEAR_VARS)
LOCAL_SRC_FILES := vkp.kcm
include $(BUILD_KEY_CHAR_MAP)

#
# keyboard layouts
#
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/logitech.kl:system/usr/keylayout/logitech.kl
include $(CLEAR_VARS)
LOCAL_SRC_FILES := logitech.kcm
include $(BUILD_KEY_CHAR_MAP)

#
# keyboard layouts
#
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/csrbluedev.kl:system/usr/keylayout/csrbluedev.kl
include $(CLEAR_VARS)
LOCAL_SRC_FILES := csrbluedev.kcm
include $(BUILD_KEY_CHAR_MAP)

#
# keyboard layouts
#
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/microsoft.kl:system/usr/keylayout/microsoft.kl
include $(CLEAR_VARS)
LOCAL_SRC_FILES := microsoft.kcm
include $(BUILD_KEY_CHAR_MAP)

# board specific init.rc, asound.conf, setHandset.sh and apns-conf.xml
#
ifeq ($(SYSTEM_PARTITION_PERM),RW)
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init_rw.rc:root/init.rc 
else
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.rc:root/init.rc
endif

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/asound.conf:system/etc/asound.conf \
	$(LOCAL_PATH)/apns-conf.xml:system/etc/apns-conf.xml \
	$(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab

# media configuration xml file

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# camera configuration xml file

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml                         \
	frameworks/base/data/etc/android.hardware.touchscreen.xml:system/etc/permissions/android.hardware.touchscreen.xml           \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/LauncherPro-0.8.5.apk:system/app/LauncherPro-0.8.5.apk

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/AndExplorer.apk:system/app/AndExplorer.apk

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/busybox:system/bin/busybox

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/video/sports_mpg4_qvga_15fps_160kbps_amr_8kHz_hinted.3gp:system/media/video/sports_mpg4_qvga_15fps_160kbps_amr_8kHz_hinted.3gp
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/audio/BrookBentonItsJustAMatterOfTime.wav:system/media/audio/BrookBentonItsJustAMatterOfTime.wav

