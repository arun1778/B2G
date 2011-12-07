LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
# librecovery_update_ifx is a set of edify extension functions for
# doing device specific OTA steps

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := extra_hooks.c
#LOCAL_STATIC_LIBRARIES += libmtdutils
LOCAL_C_INCLUDES += bootable/recovery
LOCAL_MODULE := librecovery_updater_imc
include $(BUILD_STATIC_LIBRARY)

