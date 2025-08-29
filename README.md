# Sinestrea

> An optimized kernel with various features for Android

## Features

+ SukiSU-Ultra bleeding edge version.
+ Integration with SusFS 
+ ZRAM & other patches (like https://github.com/ShirkNeko/GKI_KernelSU_SUSFS)
+ Optimized for specific devices.
+ ... and more in the future :wink:

## Building

Set up dependencies, on Ubuntu you would use the helper script to install them faster:

```bash
./scripts/ubuntu/install_deps.sh
```

To build 5.10 kernel for `LineageOS/diting`:

```bash
./general/init.sh
./common/5.10/init.sh
./lineage-diting/init.sh
./common/5.10/patch_sukisu.sh
./lineage-diting/build.sh
./lineage-diting/patch_kpm.sh
# For now, manually copy Image to AK3 zip here 
./lineage-diting/create_bootimg.sh
# boot.img should be in ./dist/lineage-diting/boot.img
```

## FAQ

#### Where is the kernel source?

Sinestrea is a series of bash scripts which apply patches to the existing kernel source tree. To get the kernel source, just look at `init.sh` script for the device you want and after running patch scripts, the source tree should be identical to what I have.

## License

[MIT](./LICENSE), other components (SukiSU, Linux, etc.) belongs to their owner with their licenses.
