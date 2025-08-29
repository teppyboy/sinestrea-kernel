#!/usr/bin/env bash

cd sinestrea/common
source build.config.common
source build.config.aarch64
source build.config.gki
source build.config.gki.aarch64
source build.config.msm.waipio
export ARCH="arm64"
export CC="ccache clang"
export LTO="thin"
export LLVM=1
export LLVM_IAS=1
export PATH="$(realpath ../build/build-tools/path/linux-x86):$(realpath ../$CLANG_PREBUILT_BIN):$(realpath ../build/build-tools/path/linux-x86):$(realpath ./out/android12-5.10/common/host_tools):$PATH"
make O=out mrproper
make O=out gki_defconfig
make O=out vendor/waipio_GKI.config 
make O=out vendor/xiaomi_GKI.config
make O=out vendor/diting_GKI.config
make O=out vendor/debugfs.config
make -j$(nproc --all) O=out 
# Copying
mkdir -p dist/lineage-diting
cd ../..
cp sinestrea/common/out/arch/arm64/boot/Image dist/lineage-diting/Image
