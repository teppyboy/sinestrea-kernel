#!/usr/bin/env bash

cd sinestrea/common
echo "Setting up KernelSU..."
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main

# echo "Setting up Baseband-guard..."
# wget -O- https://github.com/vc-teahouse/Baseband-guard/raw/main/setup.sh | bash

echo "Applying other patches by SukiSU (yes)..."
patch -p1 -F 3 < ../SukiSU_patch/69_hide_stuff.patch

echo "Remove -dirty from kernel config..."
sed -i 's/-dirty//' ./scripts/setlocalversion

echo "Removing check_defconfig..."
sed -i 's/check_defconfig//' ./build.config.gki

echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"

# Enable KernelSU config
echo "CONFIG_KSU=y" >> "$CONFIG_FILE"

# Enable baseband-guard
# echo "CONFIG_BBG=y" >> "$CONFIG_FILE"

echo "KernelSU applied successfully."
