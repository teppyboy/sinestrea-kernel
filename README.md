# Sinestrea

> An optimized kernel with various features for Android

## Features

+ SukiSU-Ultra bleeding edge version.
+ Integration with SusFS 
+ ZRAM & other patches (like https://github.com/ShirkNeko/GKI_KernelSU_SUSFS)
+ Optimization for specific devices.
+ ... and more in the future :wink:

## Building

0. Set up dependencies, on Ubuntu you would use the helper script to install them faster:

```bash
./scripts/ubuntu/install_deps.sh
./general/init.sh
```

1. Build the kernel

+ To build 5.10 kernel for `LineageOS/diting`:

```bash
./common/5.10/init.sh
./device/diting/init.sh
./common/patch_sukisu.sh
./common/5.10/patch_susfs.sh
./common/5,10/update_prebuilts.sh
./device/diting/build.sh
./device/diting/patch_kpm.sh
# For now, manually copy Image from ./dist/diting/Image to AK3 zip 
./device/lineage-diting/create_bootimg.sh
# boot.img should be in ./dist/diting/boot.img
```

+ To build mainline kernel for `raviole` (WIP):

```bash
./device/raviole/mainline/init.sh
./device/raviole/mainline/build.sh
# For now, manually copy Image from ./dist/lineage-diting/Image to AK3 zip 
./device/raviole/mainline/create_bootimg.sh
```

### Cleaning

In case you want to clean your tree (because of a failed patch or whatever), you have two options:

1. Execute `./general/cleanup.sh` to clean up the kernel sources directory.
2. Remove `sinestrea` directory to start from scratch.

## FAQ

#### Where is the kernel source?

Sinestrea is a series of bash scripts which apply patches to the existing kernel source tree. To get the kernel source, just look at `init.sh` script for the device you want and after running patch scripts, the source tree should be identical to what I have.

## License

[MIT](./LICENSE), other components (SukiSU, Linux, etc.) belongs to their owner with their licenses.
