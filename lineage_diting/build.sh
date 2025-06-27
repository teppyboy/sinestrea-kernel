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
export PATH="$(realpath ../build/build-tools/path/linux-x86):$(realpath ../$CLANG_PREBUILT_BIN):$(realpath ../build/build-tools/path/linux-x86):$(realpath ./out/android12-5.10/common/host_tools):$PATH"
make O=out LLVM=1 LLVM_IAS=1 mrproper
make O=out LLVM=1 LLVM_IAS=1 gki_defconfig
make O=out LLVM=1 LLVM_IAS=1 vendor/waipio_GKI.config 
make O=out LLVM=1 LLVM_IAS=1 vendor/xiaomi_GKI.config
make O=out LLVM=1 LLVM_IAS=1 vendor/diting_GKI.config
make O=out LLVM=1 LLVM_IAS=1 vendor/debugfs.config
make -j$(nproc --all) O=out LLVM=1 LLVM_IAS=1