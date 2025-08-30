#!/usr/bin/env bash

# Optimized environment variables
AFLAGS="-mtune=cortex-x2 -march=armv9-a+sve2"
CFLAGS="-O3 -msve-vector-bits=scalable $AFLAGS"
COMPAT_FLAGS="-Wno-default-const-init-unsafe"

source scripts/env.sh
cd sinestrea/common
source build.config.common
source build.config.aarch64
source build.config.gki
source build.config.gki.aarch64
source build.config.msm.waipio
export ARCH="arm64" CC="ccache clang" LTO="thin" LLVM=1 LLVM_IAS=1 
export KCFLAGS="$CFLAGS $COMPAT_FLAGS" KAFLAGS="$AFLAGS"
export PATH="$(realpath ../build/build-tools/path/linux-x86):$(realpath ../$CLANG_PREBUILT_BIN):$(realpath ../build/build-tools/path/linux-x86):$(realpath ./out/android12-5.10/common/host_tools):$PATH"
make O=out mrproper
make O=out gki_defconfig
make O=out vendor/waipio_GKI.config 
make O=out vendor/xiaomi_GKI.config
make O=out vendor/diting_GKI.config
make -j$(nproc --all) O=out 
# Copying
cd ../..
mkdir -p dist/lineage-diting
cp sinestrea/common/out/arch/arm64/boot/Image dist/lineage-diting/Image
