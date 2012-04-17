#
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := mbd_xmm2231

TARGET_CPU_ABI := armeabi
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv6

TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true
TARGET_PROVIDES_INIT_RC := true

TARGET_RECOVERY_UI_LIB := librecovery_ui_xmm2231

USE_CAMERA_STUB := true

BOARD_USES_ALSA_AUDIO := true
BUILD_WITH_ALSA_UTILS := true
#BOARD_USES_GENERIC_AUDIO := true

#CSR synergy change to include wifi, fm, bt
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_FM := true
BOARD_HAVE_WIFI := true
BOARD_WIFI_WAPI := true
#BOARD_WPA_SUPPLICANT_DRIVER := WEXT
USE_BLUEZ := false

# OpenGL drivers config file path
BOARD_EGL_CFG := device/imc/xmm2231ff1_0/egl.cfg

TARGET_BOOTLOADER_BOARD_NAME := unknown

#to get the BOOTCHART
#INIT_BOOTCHART := true

#Recovery settings below

#Include xmm2231 specific UI for recovery (this library is built by variant and defines fx. menu texts & key mappings)
TARGET_RECOVERY_UI_LIB := librecovery_ui_xmm2231_ff

#Include xmm2231 specific code for handle custom edify script entries. Will be linked with updater binary inside ota package.
TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_imc

#Include variant specific release script steps (for OTA generation)
#Either specify full path to extension .py file or path in which "releasetools.py" exist (trailing slash needed)
TARGET_RELEASETOOLS_EXTENSIONS := device/imc/common/ota-extensions/releasetools.py

#DRM support
PEKALL_DRM_SUPPORT := true

#FM Support
BUILD_WITH_PEKALL_FMRADIO := true

BUILD_PEKALL_APP := false

# Build with GCOV support
BUILD_GCOV_SUPPORT := false

# Build all GMS apps
BUILD_GMS_ALL := false

TARGET_BOOTIMAGE_USE_EXT4 := true
TARGET_USERIMAGES_USE_EXT4 := true

# recvoery fstab
recovery_fstab := device/imc/xmm2231ff1_0/recovery.fstab

