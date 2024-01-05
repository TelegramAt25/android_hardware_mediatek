LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Default to the latest AIDL version
TARGET_POWERHAL_AIDL_VERSION ?= 2

LOCAL_MODULE := android.hardware.power-service-mediatek
LOCAL_VENDOR_MODULE := true
LOCAL_MULTILIB := 64
LOCAL_VINTF_FRAGMENTS := power-mtk-v$(TARGET_POWERHAL_AIDL_VERSION).xml
LOCAL_SRC_FILES := Power.cpp

LOCAL_SHARED_LIBRARIES := \
    libbase \
    libbinder_ndk \
    android.hardware.power-V$(TARGET_POWERHAL_AIDL_VERSION)-ndk

LOCAL_CFLAGS += -DPOWERHAL_AIDL_VERSION=$(TARGET_POWERHAL_AIDL_VERSION)

ifneq ($(TARGET_TAP_TO_WAKE_NODE),)
    LOCAL_CFLAGS += -DTAP_TO_WAKE_NODE=\"$(TARGET_TAP_TO_WAKE_NODE)\"
endif

ifneq ($(TARGET_POWERHAL_MODE_EXT),)
    LOCAL_CFLAGS += -DMODE_EXT
    LOCAL_SRC_FILES += ../../../../$(TARGET_POWERHAL_MODE_EXT)
endif

include $(BUILD_SHARED_LIBRARY)
