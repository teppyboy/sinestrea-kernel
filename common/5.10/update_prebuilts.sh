#!/usr/bin/env bash

echo "Updating prebuilt toolchain to main-kernel..."
cd sinestrea/prebuilts-master/clang/host/linux-x86
git fetch aosp main-kernel --depth 1
git checkout FETCH_HEAD
cd ../../..
echo "Editing CLANG_PREBUILT_BIN in build config..."
sed -i -e 's/clang-r416183b/clang-r574158/g' ./common/build.config.common
echo "Toolchain update complete."
