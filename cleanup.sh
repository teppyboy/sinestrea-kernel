#!/usr/bin/env bash

echo "Cleaning up kernel source..."
cd sinestrea/common
git reset --hard
rm -rf SukiSU-Ultra KernelSU KernelSU-Next
echo "Kernel source cleaned up."
