# Copyright (C) 2013 Intel Mobile Communications GmbH
# Copyright (C) 2012 The Android Open Source Project
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
# Jan 10 2013: To adapt for xmm6321_svb
# Jan 17 2013: Modify gralloc package file name using TARGET_BOARD_PLATFORM.
# Apr 03 2013: Create local copy overlay folder, and provide APN list.
# Apr 26 2013: Workspace contains both AOSP RIL & RPC RIL, if BUILD_RIL_TYPE set to RPC then AOSP RIL will not be built

$(call inherit-product, build/target/product/full.mk)

TARGET_BOARD_PLATFORM := xmm6321

PRODUCT_NAME := xmm6321_svb
PRODUCT_DEVICE := xmm6321_svb
PRODUCT_BRAND := IMC
PRODUCT_MODEL := XMM6321 SVB
#RIL type RPC or AT based
BUILD_RIL_TYPE := RPC

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
    audio.primary.$(TARGET_BOARD_PLATFORM) \
    libauddriver \
    tinyplay \
    tinymix \
    tinycap \
    hwcomposer.default

# IWLWIFI
PRODUCT_COPY_FILES += \
       $(call find-copy-subdir-files,*.ko,$(IWLWIFI_OUT),system/lib/modules/)

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.rc:root/init.rc

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vold.fstab:root/etc/vold.fstab

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

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapsize=32m

# default is nosdcard, S/W button enabled in resource
DEVICE_PACKAGE_OVERLAYS := $(LOCAL_PATH)/overlay
# PRODUCT_CHARACTERISTICS := nosdcard
