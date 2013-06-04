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
# May 27 2013: Move SVB board specific config from xmm6321_svb.mk to a new file device.mk

$(call inherit-product, build/target/product/full.mk)

TARGET_BOARD_PLATFORM := xmm6321

PRODUCT_NAME := xmm6321_svb
PRODUCT_DEVICE := xmm6321_svb
PRODUCT_BRAND := Android
PRODUCT_MODEL := Full AOSP on XMM6321
PRODUCT_MANUFACTURER := IMC
#PRODUCT_RESTRICT_VENDOR_FILES := true

#RIL type RPC or AT based
BUILD_RIL_TYPE := RPC

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/imc/xmm6321_svb/device.mk)

