#!/usr/bin/env bash

cd sinestrea/common
echo "Setting up KernelSU-Next..."
curl -LSs "https://raw.githubusercontent.com/pershoot/KernelSU-Next/dev-susfs/kernel/setup.sh" | bash -s dev-susfs

# echo "Setting up Baseband-guard..."
# wget -O- https://github.com/vc-teahouse/Baseband-guard/raw/main/setup.sh | bash

echo "Applying other patches by SukiSU..."
patch -p1 -F 3 < ../SukiSU_patch/69_hide_stuff.patch

echo "Removing -dirty from kernel config..."
sed -i 's/-dirty//' ./scripts/setlocalversion

echo "Removing check_defconfig..."
sed -i 's/check_defconfig//' ./build.config.gki

echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"

# Enable SukiSU config
echo "CONFIG_KSU=y" >> "$CONFIG_FILE"
# echo "CONFIG_KSU_KPROBES_HOOK=n" >> "$CONFIG_FILE"

# Enable baseband-guard
# echo "CONFIG_BBG=y" >> "$CONFIG_FILE"

echo "KernelSU-Next applied successfully."
