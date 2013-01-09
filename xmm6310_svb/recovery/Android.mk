# Copyright (C) 2011-2013 Intel Mobile Communications GmbH
# Copyright (C) 2008 The Android Open Source Project
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
# Nov 02 2012: Modify for xmm6310_svb
# Jan 08 2013: Add condition check on TARGET_PRODUCT

ifneq (,$(findstring $(TARGET_PRODUCT),xmm6310_svb))

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := eng

LOCAL_C_INCLUDES += bootable/recovery
LOCAL_SRC_FILES := recovery_ui.c

# should match TARGET_RECOVERY_UI_LIB should be set in BoardConfig.mk
LOCAL_MODULE := librecovery_ui_xmm6310_svb

include $(BUILD_STATIC_LIBRARY)

endif
