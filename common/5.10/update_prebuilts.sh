#!/usr/bin/env bash

CLANG_VERSION="clang-r450784d"

cd sinestrea/
echo "Updating prebuilt toolchain to android13-release..."
mkdir -p prebuilts-master/clang/host/linux-x86/$CLANG_VERSION
curl -L \
  "https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/android13-release/$CLANG_VERSION.tar.gz" \
  | tar -xz -C prebuilts-master/clang/host/linux-x86/$CLANG_VERSION
echo "Editing CLANG_PREBUILT_BIN in build config..."
sed -i -e "s/clang-r416183b/$CLANG_VERSION/g" ./common/build.config.common
echo "Toolchain update complete."
