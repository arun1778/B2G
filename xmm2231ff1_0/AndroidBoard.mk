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

# charge only mode bootscript
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/init.chargeonly.rc:root/init.chargeonly.rc 

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/asound.conf:system/etc/asound.conf \
	$(LOCAL_PATH)/apns-conf.xml:system/etc/apns-conf.xml \
	$(LOCAL_PATH)/vold.fstab:system/etc/vold.fstab

# media configuration xml file

PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media_profiles.xml:system/etc/media_profiles.xml

# camera configuration xml file

PRODUCT_COPY_FILES += \
	frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml                         \
	frameworks/base/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml                         \
	frameworks/base/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml                         \
	frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml                         \
	frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml                         \
	frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml                         \
	frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml                         \
	frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml           \
	frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

#Include custom file into OTA zipfile RADIO directory (filename makes no sense for now - just an example)
#Included file could be referenced from variant specific releasetools.py
#BEWARE! There can be NO whitespace after the comma in the below clause
$(call add-radio-file,asound.conf)

include bootable/recovery/ImcRecoveryRamdisk.mk
