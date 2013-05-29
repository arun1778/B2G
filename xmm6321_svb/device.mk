# Copyright (C) 2013 Intel Mobile Communications GmbH
# Copyright (C) 2011 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# May 27, 2013: This file includes all definitions that apply to XMM6321 SVB devices

# Screen size is "normal", density is "mdpi"
PRODUCT_AAPT_CONFIG := normal mdpi

ifeq ($(BUILD_MODE),release)
LOCAL_KERNEL := device/imc/xmm6321_svb/vmlinux-release
else
LOCAL_KERNEL := device/imc/xmm6321_svb/vmlinux-debug
endif

PRODUCT_COPY_FILES += \
        $(LOCAL_KERNEL):kernel

PRODUCT_PACKAGES += \
    gralloc.$(TARGET_BOARD_PLATFORM) \
    hwcomposer.$(TARGET_BOARD_PLATFORM) \
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    libauddriver \
    tinyplay \
    tinymix \
    tinycap \
    bdt \
    bt_vendor_test \
    bt_vendor.conf \
    iwlwifi-7999-6.ucode \
    hwcomposer.default

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck \
    setup_fs

# IWLWIFI
PRODUCT_COPY_FILES += \
       $(call find-copy-subdir-files,*.ko,$(IWLWIFI_OUT),system/lib/modules/)

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.rc:root/init.rc

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.xmm6321.usb.rc:root/init.xmm6321.usb.rc

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vold.fstab:root/etc/vold.fstab

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/fstab.xmm6321_svb:root/fstab.xmm6321_svb

# Key Character Map and Key Layout
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vkp.kl:system/usr/keylayout/vkp.kl
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vkp.kl:system/usr/keylayout/xgold-keypad.kl
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vkp.kl:system/usr/keychars/vkp.kcm
PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vkp.kl:system/usr/keychars/xgold-keypad.kcm

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/apns-conf.xml:system/etc/apns-conf.xml

# The egl.cfg will enable the GPU HW rendering
PRODUCT_COPY_FILES += \
	hardware/intel/gpu/arm/mali/egl.cfg:system/lib/egl/egl.cfg

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
	frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml


PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapsize=32m

# default is nosdcard, S/W button enabled in resource
DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay
# PRODUCT_CHARACTERISTICS := nosdcard
