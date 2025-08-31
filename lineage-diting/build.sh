#!/usr/bin/env bash

# Optimized environment variables
CFLAGS="-mtune=cortex-x1"
AFLAGS="$CFLAGS -march=armv8.5-a"
COMPAT_FLAGS=""

source scripts/env.sh
cd sinestrea/common
source build.config.common
source build.config.aarch64
source build.config.gki
source build.config.gki.aarch64
source build.config.msm.waipio

if [[ $CLANG_PREBUILT_BIN != *"r416183b"* ]]; then
    echo "Setting recent optimized flags because we're using updated toolchain..."
    CFLAGS="-mtune=cortex-x2"
    AFLAGS="$CFLAGS -march=armv9-a"
fi
if [[ $CLANG_PREBUILT_BIN == *"r563880"* ]]; then
    echo "Adding compat flags for clang-r563880 (LLVM 21)..."
    COMPAT_FLAGS="-Wno-default-const-init-unsafe"
fi

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
rm -rf dist/lineage-diting/Image
cp sinestrea/common/out/arch/arm64/boot/Image dist/lineage-diting/Image
