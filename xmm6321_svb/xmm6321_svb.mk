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

$(call inherit-product, build/target/product/full.mk)

TARGET_BOARD_PLATFORM := xmm6321

PRODUCT_NAME := xmm6321_svb
PRODUCT_DEVICE := xmm6321_svb
PRODUCT_BRAND := IMC
PRODUCT_MODEL := XMM6321 SVB

# Screen size is "normal", density is "mdpi"
PRODUCT_AAPT_CONFIG := normal mdpi

PRODUCT_PACKAGES += \
    gralloc.$(TARGET_BOARD_PLATFORM) \
    hwcomposer.default

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/init.rc:root/init.rc

PRODUCT_COPY_FILES += \
        $(LOCAL_PATH)/vkp.kl:system/usr/keylayout/vkp.kl

PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=5m \
    dalvik.vm.heapsize=32m

# default is nosdcard, S/W button enabled in resource
DEVICE_PACKAGE_OVERLAYS := device/generic/armv7-a-neon/overlay
PRODUCT_CHARACTERISTICS := nosdcard
