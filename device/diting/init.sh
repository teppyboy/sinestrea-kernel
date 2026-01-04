#!/usr/bin/env bash

echo "Cloning lineage-diting kernel source..."
cd sinestrea
rm -rf ./common
git clone https://github.com/LineageOS/android_kernel_xiaomi_sm8450 common --depth 1 -b lineage-23.1
echo "Kernel source cloned successfully."
