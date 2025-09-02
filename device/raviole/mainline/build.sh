#!/usr/bin/env bash

source scripts/env.sh
cd sinestrea/common
source build.config.constants

export ARCH="arm64" CC="ccache clang" LTO="thin" LLVM=1 LLVM_IAS=1 
export KCFLAGS="$CFLAGS $COMPAT_FLAGS" KAFLAGS="$AFLAGS"
export PATH="$(realpath ../build/build-tools/path/linux-x86):$(realpath ../prebuilts/clang/host/linux-x86/clang-$CLANG_VERSION/bin):$(realpath ./out/android-mainline/common/host_tools):$PATH"
make O=out mrproper
make O=out gki_defconfig
make O=out defconfig
make -j$(nproc --all) O=out Image.lz4 dtbs
# Copying
cd ../..
mkdir -p dist/raviole/mainline/
rm -rf dist/raviole/mainline/Image
