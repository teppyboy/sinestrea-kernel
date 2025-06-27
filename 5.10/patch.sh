#!/usr/bin/env bash

cd sinestrea/common
echo "Setting up SukiSU (with susfs)..."
curl -LSs "https://raw.githubusercontent.com/SukiSU-Ultra/SukiSU-Ultra/main/kernel/setup.sh" | bash -s susfs-test

echo "Copying susfs4ksu files..."
cp ../susfs4ksu/kernel_patches/fs/* ./fs/
cp ../susfs4ksu/kernel_patches/include/linux/* ./include/linux/

echo "Patching kernel with susfs..."
patch -p1 --fuzz=3 < ../susfs4ksu/kernel_patches/50_add_susfs_in_gki-android12-5.10.patch

echo "Applying ZRAM patches..."
cp -r ../SukiSU_patch/other/zram/lz4k/include/linux/* ./include/linux/
cp -r ../SukiSU_patch/other/zram/lz4k/lib/* ./lib/
cp -r ../SukiSU_patch/other/zram/lz4k/crypto/* ./crypto/
cp -r ../SukiSU_patch/other/zram/lz4k_oplus ./lib/
patch -p1 -F 3 < ../SukiSU_patch/other/zram/zram_patch/5.10/lz4kd.patch
patch -p1 -F 3 < ../SukiSU_patch/other/zram/zram_patch/5.10/lz4k_oplus.patch

echo "Applying other patches by SukiSU..."
patch -p1 -F 3 < ../SukiSU_patch/hooks/syscall_hooks.patch
patch -p1 -F 3 < ../SukiSU_patch/69_hide_stuff.patch

echo "Remove -dirty from kernel config..."
sed -i 's/-dirty//' ./scripts/setlocalversion

# Enable ZRAM config
echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"
echo "CONFIG_ZSMALLOC=y" >> "$CONFIG_FILE"
echo "CONFIG_ZRAM=y" >> "$CONFIG_FILE"
echo "CONFIG_MODULE_SIG=n" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_LZO=y" >> "$CONFIG_FILE"
echo "CONFIG_ZRAM_DEF_COMP_LZ4KD=y" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_LZ4HC=y" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_LZ4K=y" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_LZ4KD=y" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_842=y" >> "$CONFIG_FILE"
echo "CONFIG_CRYPTO_LZ4K_OPLUS=y" >> "$CONFIG_FILE"
echo "CONFIG_ZRAM_WRITEBACK=y" >> "$CONFIG_FILE"

# Enable BBR config
echo "CONFIG_DEFAULT_BBR=y" >> "$CONFIG_FILE"

# Enable SukiSU config
echo "CONFIG_KSU=y" >> "$CONFIG_FILE"
echo "CONFIG_KPM=y" >> "$CONFIG_FILE"
echo "CONFIG_KSU_SUSFS_SUS_SU=n" >> "$CONFIG_FILE"
echo "CONFIG_KSU_MANUAL_HOOK=y" >> "$CONFIG_FILE"

# Add additional tmpfs config setting
echo "CONFIG_TMPFS_XATTR=y" >> "$CONFIG_FILE"
echo "CONFIG_TMPFS_POSIX_ACL=y" >> "$CONFIG_FILE"

# Add additional config setting
echo "CONFIG_IP_NF_TARGET_TTL=y" >> "$CONFIG_FILE"
echo "CONFIG_IP6_NF_TARGET_HL=y" >> "$CONFIG_FILE"
echo "CONFIG_IP6_NF_MATCH_HL=y" >> "$CONFIG_FILE"

# Add BBR Config
echo "CONFIG_TCP_CONG_ADVANCED=y" >> "$CONFIG_FILE"
echo "CONFIG_TCP_CONG_BBR=y" >> "$CONFIG_FILE"
echo "CONFIG_NET_SCH_FQ=y" >> "$CONFIG_FILE"
echo "CONFIG_TCP_CONG_BIC=n" >> "$CONFIG_FILE"
echo "CONFIG_TCP_CONG_WESTWOOD=n" >> "$CONFIG_FILE"
echo "CONFIG_TCP_CONG_HTCP=n" >> "$CONFIG_FILE"

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

echo "Patching complete. Kernel is ready for build."