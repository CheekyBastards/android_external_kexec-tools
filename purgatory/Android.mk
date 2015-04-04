# Purgatory (an uncomfortable intermediate state)
#            In this case the code that runs between kernels
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

PURGATORY_SRCS = \
	purgatory.c \
	printf.c \
	string.c

ARCH_FLAGS :=


LOCAL_CFLAGS := $(ARCH_FLAGS) \
	-I$(LOCAL_PATH)/include  -I$(LOCAL_PATH)/../util_lib/include \
	-pipe -fno-strict-aliasing -Wall -Wstrict-prototypes \
	-fno-zero-initialized-in-bss \
	-Os -fno-builtin -ffreestanding

LOCAL_SRC_FILES := \
	$(PURGATORY_SRCS) \
	$(ARCH_SRCS)

LOCAL_MODULE := purgatory
LOCAL_ARM_MODE := arm
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_OUT_INTERMEDIATES)
LOCAL_MODULE_TAGS := eng
LOCAL_STATIC_LIBRARIES := libsha-kexec

#
# sha256.c needs to be compiled without optimization, else
# purgatory fails to execute on ia64.
#
include $(CLEAR_VARS)

LOCAL_CFLAGS := -O0 -pipe -fno-strict-aliasing -Wall -Wstrict-prototypes \
				-I$(LOCAL_PATH)/../util_lib/include

LOCAL_SRC_FILES := ../util_lib/sha256.c

LOCAL_MODULE:= libsha-kexec
LOCAL_MODULE_TAGS := eng
#LOCAL_REQUIRED_MODULES := libc_bionic

include $(BUILD_STATIC_LIBRARY)
