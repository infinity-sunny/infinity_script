#!/bin/bash

# Remove local manifests if they exist
rm -rf .repo/local_manifests/
# Initialize ROM manifest
repo init --depth=1 --no-repo-verify --git-lfs -u https://github.com/ProjectInfinity-X/manifest -b QPR3 -g default,-mips,-darwin,-notdefault
# repo sync
/opt/crave/resync.sh
# remove directory
rm -rf hardware/qcom-caf/sm8150/media
rm -rf vendor/infinity
# cloning DT
# device tree
git clone https://github.com/infinity-sunny/device_xiaomi_sunny.git --depth 1 -b fourteen device/xiaomi/sunny
git clone https://github.com/dpenra-sunny/device_xiaomi_sunny-kernel.git --depth 1 -b fourteen device/xiaomi/sunny-kernel
git clone https://github.com/AOSPA/android_device_qcom_qssi.git --depth 1 -b uvite device/qcom/qssi
git clone https://github.com/yaap/device_qcom_common.git --depth 1 -b fourteen device/qcom/common
# kernel tree
# git clone https://github.com/PixelOS-Devices/kernel_xiaomi_sunny.git --depth 1 -b fourteen kernel/xiaomi/sunny
# vendor tree
git clone https://github.com/PixelOS-Devices/vendor_xiaomi_sunny.git --depth 1 -b fourteen vendor/xiaomi/sunny
git clone https://gitlab.com/yaosp/vendor_qcom_common.git --depth 1 -b fourteen vendor/qcom/common
git clone https://github.com/yaap/vendor_qcom_opensource_core-utils.git --depth 1 -b fourteen vendor/qcom/opensource/core-utils
# hardware tree
git clone https://github.com/PixelOS-AOSP/hardware_xiaomi.git --depth 1 -b fourteen hardware/xiaomi
# prebuilts
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-elf.git --depth 1 -b 14.0.0 prebuilts/gcc/linux-x86/aarch64/aarch64-elf
git clone https://github.com/StatiXOS/android_prebuilts_gcc_linux-x86_arm_arm-eabi.git --depth 1 -b 12.0.0 prebuilts/gcc/linux-x86/arm/arm-eabi
# packages
git clone https://github.com/cyberknight777/android_packages_apps_DisplayFeatures.git --depth 1 -b master packages/apps/DisplayFeatures
git clone https://github.com/KProfiles/android_packages_apps_Kprofiles.git --depth 1 -b main packages/apps/KProfiles
# source mods
git clone https://github.com/yaap/hardware_qcom-caf_sm8150_media.git --depth 1 -b fourteen hardware/qcom-caf/sm8150/media
git clone https://github.com/infinity-sunny/vendor_infinity.git --depth 1 -b QPR3 vendor/infinity
# set build environment
. build/envsetup.sh
# lunch
lunch infinity_sunny-user
# make
mak bacon
