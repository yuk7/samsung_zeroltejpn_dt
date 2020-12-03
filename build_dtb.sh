#!/bin/bash

export ARCH=arm64
export TOOLCHAIN=~/tools/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/
export CROSS_COMPILE=${TOOLCHAIN}/bin/aarch64-linux-gnu-
export CPP=${CROSS_COMPILE}cpp
export DTC=dtc
export DTBTOOL=./dtbTool

export SRC=$(pwd)/android_kernel_samsung_exynos7420
export SRC_DTS=${SRC}/arch/$ARCH/boot/dts
export SRC_INC=${SRC}/include
export OUT=$(pwd)


DTSFILES="exynos7420-zerolte_jpn_00 exynos7420-zerolte_jpn_01 exynos7420-zerolte_jpn_02
            exynos7420-zerolte_jpn_03 exynos7420-zerolte_jpn_04 exynos7420-zerolte_jpn_05 exynos7420-zerolte_jpn_06"

for DTS in $DTSFILES; do
	${CPP} -undef -x assembler-with-cpp -nostdinc -I "${SRC_INC}" "${SRC_DTS}/${DTS}.dts" > "${OUT}/${DTS}.dts"
	${DTC} -i "${SRC_DTS}" -O dtb -o "${DTS}.dtb" "${DTS}.dts"
done

${DTBTOOL} -o "${OUT}/zeroltejpn-dtb.img" -d "${OUT}/" -s 2048