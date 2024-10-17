#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# Initialize the ROM manifest from the ProjectInfinity-X repository with specific depth and branch
repo init -u https://github.com/ProjectInfinity-X/manifest -b QPR3 --git-lfs --depth=1

# Synchronize the repo using a crave resync script
/opt/crave/resync.sh
/opt/crave/resync.sh

# Remove unneeded or outdated directories for clean-up before the next steps
rm -rf hardware/qcom-caf/sm8150/media
rm -rf vendor/infinity

# Clone device tree repositories for Xiaomi Sunny device and associated kernel
git clone https://github.com/infinity-sunny/device_xiaomi_sunny.git --depth 1 -b fourteen device/xiaomi/sunny
git clone https://github.com/dpenra-sunny/device_xiaomi_sunny-kernel.git --depth 1 -b fourteen device/xiaomi/sunny-kernel

# Clone common device trees for Qualcomm QSSI and common Qualcomm configurations
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b uvite device/qcom/qssi
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fourteen device/qcom/common

# Clone vendor repositories for Xiaomi Sunny device and Qualcomm common/vendor utilities
git clone https://github.com/PixelOS-Devices/vendor_xiaomi_sunny.git --depth 1 -b fourteen vendor/xiaomi/sunny
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fourteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fourteen vendor/qcom/opensource/core-utils

# Clone hardware support for Xiaomi
git clone https://github.com/PixelOS-AOSP/hardware_xiaomi.git --depth 1 -b fourteen hardware/xiaomi

# Clone prebuilt GCC compilers for ARM and AArch64 architecture (used for building the kernel)
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi

# Clone specific packages for device features like DisplayFeatures and KProfiles
git clone https://github.com/cyberknight777/android_packages_apps_DisplayFeatures.git --depth 1 -b master packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles

# Clone source modifications for hardware and vendor trees specific to Qualcomm and Infinity devices
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fourteen hardware/qcom-caf/sm8150/media
git clone https://github.com/infinity-sunny/vendor_infinity.git --depth 1 -b QPR3 vendor/infinity

# Set up the build environment (source environment setup script)
. build/envsetup.sh

# Choose the build configuration (lunch target) for Xiaomi Sunny device
lunch infinity_sunny-user

# Start the build process for the ROM (build the 'bacon' target)
mka bacon
