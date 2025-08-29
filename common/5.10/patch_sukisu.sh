#!/usr/bin/env bash

cd sinestrea/common
echo "Setting up SukiSU (with susfs)..."
curl -LSs "https://raw.githubusercontent.com/SukiSU-Ultra/SukiSU-Ultra/main/kernel/setup.sh" | bash -s susfs-test

echo "Copying susfs4ksu files..."
cp ../susfs4ksu/kernel_patches/fs/* ./fs/
cp ../susfs4ksu/kernel_patches/include/linux/* ./include/linux/

echo "Patching kernel with susfs..."
patch -p1 --fuzz=3 < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android12-5.10.patch

echo "Applying other patches by SukiSU..."
patch -p1 -F 3 < ../SukiSU_patch/hooks/syscall_hooks.patch
patch -p1 -F 3 < ../SukiSU_patch/69_hide_stuff.patch

echo "Remove -dirty from kernel config..."
sed -i 's/-dirty//' ./scripts/setlocalversion

echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"

# Enable SukiSU config
echo "CONFIG_KSU=y" >> "$CONFIG_FILE"
echo "CONFIG_KPROBES=y" >> "$CONFIG_FILE"
echo "CONFIG_KPM=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_SU=n" >> "$CONFIG_FILE"
echo "CONFIG_KSU_MANUAL_HOOK=y" >> "$CONFIG_FILE"

# Add SUSFS configuration settings
echo "CONFIG_KSU_SUSFS=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_HAS_MAGIC_MOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_PATH=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_MOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_AUTO_ADD_SUS_KSU_DEFAULT_MOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_AUTO_ADD_SUS_BIND_MOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_KSTAT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_OVERLAYFS=n" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_TRY_UMOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_AUTO_ADD_TRY_UMOUNT_FOR_BIND_MOUNT=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SPOOF_UNAME=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_ENABLE_LOG=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_HIDE_KSU_SUSFS_SYMBOLS=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SPOOF_CMDLINE_OR_BOOTCONFIG=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_OPEN_REDIRECT=y" >> "$CONFIG_FILE"

echo "Patching complete."