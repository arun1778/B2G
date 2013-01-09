#
# * =============================================================================
# * Copyright (C) 2013 Intel Mobile Communications GmbH
# * =============================================================================
#
#----------------------------------------------------------------------------
# Jan 10 2013: Add copyright
#
# Product-specific compile-time definitions.
#
# The generic product target doesn't have any hardware-specific pieces.
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

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

#WPA_SUPPLICANT_VERSION := VER_0_8_X
