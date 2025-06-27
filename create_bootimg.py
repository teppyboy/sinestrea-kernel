#!/usr/bin/env python3

import subprocess
import shutil
import sys

def main():
    if len(sys.argv) != 3 and len(sys.argv) != 4:
        print("Usage: python create_bootimg.py <boot_image> <kernel_image> <output>")
        sys.exit(1)
    BASE_BOOT_IMG = sys.argv[1]
    KERNEL_IMAGE = sys.argv[2]
    OUTPUT = sys.argv[3] if len(sys.argv) > 3 else "boot.img"
    print("Unpacking boot image...")
    boot_img_raw_info = subprocess.check_output(f"./mkbootimg/unpack_bootimg.py --boot_img {BASE_BOOT_IMG} --out tmp_boot", shell=True).decode()
    mkbootimg_args = [
        "./mkbootimg/mkbootimg.py",
        "--kernel", KERNEL_IMAGE,
        "--ramdisk", "tmp_boot/ramdisk",
    ]
    for line in boot_img_raw_info.splitlines():
        if line.startswith("os version:"):
            os_version = line.split(":")[1].strip()
            print(f"OS Version: {os_version}")
            mkbootimg_args.extend(["--os_version", os_version])
        elif line.startswith("os patch level:"):
            os_patch_level = line.split(":")[1].strip()
            print(f"OS Patch Level: {os_patch_level}")
            mkbootimg_args.extend(["--os_patch_level", os_patch_level])
        elif line.startswith("boot image header version:"):
            boot_image_header_version = line.split(":")[1].strip()
            print(f"Boot Image Header Version: {boot_image_header_version}")
            mkbootimg_args.extend(["--header_version", boot_image_header_version])
        elif line.startswith("command line args:"):
            command_line_args = line.split(":")[1].strip()
            if command_line_args != "":
                print(f"Command Line Args: {command_line_args}")
                mkbootimg_args.extend(["--cmdline", command_line_args])
    mkbootimg_args.extend(["--out", OUTPUT])
    print("Creating new boot.img with the provided kernel image...")
    print("Args:", " ".join(mkbootimg_args))
    subprocess.run(mkbootimg_args, check=True)
    print("Boot image created successfully: boot.img")
    # Clean up temporary files
    shutil.rmtree("tmp_boot", ignore_errors=True)
    print("Temporary files cleaned up.")

if __name__ == "__main__":
    main()
