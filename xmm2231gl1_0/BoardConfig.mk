#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := xmm2231

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi

TARGET_ARCH_VARIANT := armv5te

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_PROVIDES_INIT_RC := true

USE_CAMERA_STUB := false

BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
#BOARD_USES_GENERIC_AUDIO := true

#CSR synergy change to include wifi,fm,bt
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_FM := true
BOARD_HAVE_WIFI := true
BOARD_WPA_SUPPLICANT_DRIVER := WEXT
USE_BLUEZ := false

# OpenGL drivers config file path
BOARD_EGL_CFG := device/imc/xmm2231gl1_0/egl.cfg

TARGET_BOOTLOADER_BOARD_NAME := unknown

#to get the BOOTCHART
INIT_BOOTCHART := true
