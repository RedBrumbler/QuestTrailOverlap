# Copyright (C) 2009 The Android Open Source Project
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


LOCAL_PATH := $(call my-dir)
TARGET_ARCH_ABI := $(APP_ABI)

rwildcard=$(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2))

# Build the modloader shared library
include $(CLEAR_VARS)
LOCAL_MODULE := modloader
LOCAL_EXPORT_C_INCLUDES := extern/modloader
LOCAL_SRC_FILES := extern/libmodloader.so
include $(PREBUILT_SHARED_LIBRARY)

# Creating prebuilt for dependency: beatsaber-hook - version: 0.4.7
include $(CLEAR_VARS)
LOCAL_MODULE := beatsaber-hook
LOCAL_EXPORT_C_INCLUDES := extern/beatsaber-hook
LOCAL_SRC_FILES := extern/libbeatsaber-hook_0_4_7.so
include $(PREBUILT_SHARED_LIBRARY)
# Creating prebuilt for dependency: bs-utils - version: 0.3.0
include $(CLEAR_VARS)
LOCAL_MODULE := bs-utils
LOCAL_EXPORT_C_INCLUDES := extern/bs-utils
LOCAL_SRC_FILES := extern/libbs-utils_0_3_0.so
include $(PREBUILT_SHARED_LIBRARY)

# If you would like to use more shared libraries (such as custom UI, utils, or more) add them here, following the format above.
# In addition, ensure that you add them to the shared library build below.

include $(CLEAR_VARS)
LOCAL_MODULE := trailoverlap
LOCAL_SRC_FILES += $(call rwildcard,src/,*.cpp)
LOCAL_SRC_FILES += $(call rwildcard,extern/beatsaber-hook/src/inline-hook,*.cpp)
LOCAL_SRC_FILES += $(call rwildcard,extern/beatsaber-hook/src/inline-hook,*.c)
LOCAL_SHARED_LIBRARIES += modloader
LOCAL_SHARED_LIBRARIES += beatsaber-hook
LOCAL_SHARED_LIBRARIES += bs-utils
LOCAL_LDLIBS += -llog
LOCAL_CFLAGS += -I'd:/il2cpp/libil2cpp' -DID='"Trail Overlap"' -DVERSION='"1.0.0"' -I'./shared' -I'./extern'
LOCAL_CPPFLAGS += -std=c++2a
LOCAL_C_INCLUDES += ./include ./src
include $(BUILD_SHARED_LIBRARY)