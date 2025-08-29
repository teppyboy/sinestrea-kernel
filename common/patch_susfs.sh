#!/usr/bin/env bash

### THIS SCRIPT IS CALLED AUTOMATICALLY, DO NOT RUN THIS SCRIPT UNLESS INSTRUCTED TO DO SO ###

echo "Copying susfs4ksu files..."
cp ../susfs4ksu/kernel_patches/fs/* ./fs/
cp ../susfs4ksu/kernel_patches/include/linux/* ./include/linux/
echo "Copy complete."

echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"

# Add SUSFS configuration settings
echo "CONFIG_KSU_SUSFS=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_SU=n" >> "$CONFIG_FILE"
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
echo "SusFS settings applied successfully."
