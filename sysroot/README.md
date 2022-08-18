# Sysroot

As GCC (and other toolchains) see it, the sysroot is the logical root directory for headers and
libraries.

This subdirectory contains the definitions and scripts to build sysroots for x86_64, armv7 and
aarch64 (aka arm64 and armv8).

## Building the sysroots

Use the `build.sh` script to build the sysroots using Docker. The current restriction is
that the container must run in x86_64. The sysroots for other architectures are built using
cross-compilation from x86_64.

### Using the build script

```shell
./sysroot/build.sh x86_64 ./sysroot base
./sysroot/build.sh armv7 ./sysroot base
./sysroot/build.sh aarch64 ./sysroot base
```

### Updating the Compiler, GLIBC, and Kernel versions

#### Background

The sysroot is based on a toolchain provided by https://toolchains.bootlin.com/.

This sysroot can be readily built from source. All the information required to do so for any platform/release can be found here:

https://toolchains.bootlin.com/downloads/releases/toolchains/

For example, the current x86-64-core-i7 instructions can be found here:

https://toolchains.bootlin.com/downloads/releases/toolchains/x86-64-core-i7/readmes/x86-64-core-i7--musl--bleeding-edge-2021.11-1.txt

The configuration provided references a specific version of gcc, glibc and kernel. These should be matched with the default ARG values found in the [Dockerfile](Dockerfile).

#### Instructions

1. Identify a version of toolchain you wish to update to. Note the GCC, GLIBC and KERNEL versions it is built with.
2. Update the [Dockerfile](Dockerfile) `ARG` lines that declare `GCC_VERSION`, `GLIBC_VERSION` and `KERNEL_VERSION` accordingly.
3. Follow the above instructions to build the sysroot images (x86_64, armv7, aarch64).
4. Upload the new images to a canonical location on Artifactory: 
5. In toolchain/defs.bzl, update _SYSROOTS and _TOOLCHAINS arrays to reference the new artifacts. You may also wish to update _DEFAULT_GCC_VERSION to match the new version built.

### Variants

If you want to build a sysroot containing extra libraries, you can build a variant. E.g. the X11:

```shell
./sysroot/build.sh x86_64 ./sysroot X11
```
