#!/usr/bin/env bash

cd sinestrea/common
echo "Setting up SukiSU (with susfs)..."
curl -LSs "https://raw.githubusercontent.com/SukiSU-Ultra/SukiSU-Ultra/main/kernel/setup.sh" | bash -s susfs-test

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
echo "CONFIG_KSU_MANUAL_HOOK=y" >> "$CONFIG_FILE"

echo "SukiSU applied successfully."
