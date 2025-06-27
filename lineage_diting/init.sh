#!/usr/bin/env bash

cd sinestrea
rm -rf ./common
git clone https://github.com/LineageOS/android_kernel_xiaomi_sm8450 common --depth 1 -b lineage-22.2
