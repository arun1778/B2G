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
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml           \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml
