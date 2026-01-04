#!/usr/bin/env bash

cd sinestrea/common
echo "Adding configuration settings..."
CONFIG_FILE="./arch/arm64/configs/gki_defconfig"

# Add Debug logging configuration settings
echo "CONFIG_VT=y" >> "$CONFIG_FILE"
echo "CONFIG_VT_CONSOLE=y" >> "$CONFIG_FILE"
echo "CONFIG_FRAMEBUFFER_CONSOLE=y" >> "$CONFIG_FILE"
echo "CONFIG_DRM_FBDEV_EMULATION=y" >> "$CONFIG_FILE"
echo "CONFIG_DRM_SIMPLEDRM=y" >> "$CONFIG_FILE"
echo "CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TTAKEOVER=n" >> "$CONFIG_FILE"
echo "CONFIG_LOGO=n" >> "$CONFIG_FILE"
echo "Debug logging settings applied successfully."
