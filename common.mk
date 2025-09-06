#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable Virtual A/B OTA
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    lk \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PROPERTY_OVERRIDES += ro.twrp.vendor_boot=true

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# API
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31

# Boot control HAL
PRODUCT_PACKAGES += \
    bootctrl \
    bootctrl.recovery \
    android.hardware.boot@1.2-service \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \

PRODUCT_PACKAGES += \
    libgptutils \
    libz \
    libcutils \

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload \
    update_engine_client \

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \

# Suspend service
TARGET_RECOVERY_DEVICE_MODULES += \
    libSuspendProperties \
    android.system.suspend@1.0 \
    android.system.suspend-service \

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libSuspendProperties.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend@1.0.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend-V1-ndk.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend.control-V1-cpp.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/android.system.suspend.control.internal-cpp.so
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/hw/android.system.suspend-service

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0.vendor \
    android.hardware.keymaster@4.1 \

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint \
    android.hardware.security.secureclock \
    android.hardware.security.sharedsecret \

# Remotely Key provisioner
PRODUCT_PACKAGES += android.hardware.security.rkp-V3-ndk
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/android.hardware.security.rkp-V3-ndk.so
RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/libcppcose_rkp.so

# Keystore2
PRODUCT_PACKAGES += \
    android.system.keystore2 \

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0.vendor \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service \

RECOVERY_LIBRARY_SOURCE_FILES += $(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/android.hardware.gatekeeper-V1-ndk.so

# Mtk plpath utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils \
    mtk_plpath_utils.recovery \

# snapuserd
PRODUCT_PACKAGES += snapuserd
RECOVERY_BINARY_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/snapuserd

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

TARGET_OTA_CERTIFICATE := device/itel/P1102GT/security/releasekey.x509.pem
PRODUCT_EXTRA_RECOVERY_KEYS += device/itel/P1102GT/security/releasekey
