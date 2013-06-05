#
# * =============================================================================
# * Copyright (C) 2013 Intel Mobile Communications GmbH
# * =============================================================================
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
#----------------------------------------------------------------------------
# Jan 10 2013: Add copyright
# Jun 05 2013: To use OPENGL renderer
#
# Product-specific compile-time definitions.
#
# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := false
TARGET_NO_RECOVERY := true

TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := false
ARCH_ARM_HAVE_TLS_REGISTER := true

SMALLER_FONT_FOOTPRINT := true
MINIMAL_FONT_FOOTPRINT := true
# Some framework code requires this to enable BT
BOARD_HAVE_BLUETOOTH := false

TARGET_BOARD_PLATFORM := xmm6321

TARGET_PROVIDES_INIT_RC := true

USE_OPENGL_RENDERER := true
#BOARD_KERNEL_CMDLINE := mem=770M@0x83C00000
BOARD_KERNEL_BASE := 0x80000000
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x3088000 --ramdisk_offset 0x3B00000 --pagesize 4096

# This enables the wpa wireless driver
BOARD_WPA_SUPPLICANT_DRIVER ?= NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB ?= private_lib_driver_cmd
WPA_SUPPLICANT_VERSION := VER_0_8_X_WCS


BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true

#BOARD_SYSTEMIMAGE_PARTITION_SIZE := 209715200
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 419430400
BOARD_CACHEIMAGE_PARTITION_SIZE := 10485760
BOARD_USERDATAIMAGE_PARTITION_SIZE := 209715200

BOARD_FLASH_BLOCK_SIZE := 4096 

TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

# Enable the optimized DEX
WITH_DEXPREOPT=true
