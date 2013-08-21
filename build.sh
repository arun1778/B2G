#!/bin/bash

# We want to figure out if we need to re-run the firmware
# extraction routine.  The first time we run build.sh, we
# store the hash of important files.  On subsequent runs,
# we check if the hash is the same as the previous run.
# If the hashes differ, we use a per-device script to redo
# the firmware extraction
function configure_device() {
    hash_file="$OUT/firmware.hash"

    # Make sure that our assumption that device codenames are unique
    # across vendors is true
    if [ $(ls -d device/*/$DEVICE 2> /dev/null | wc -l) -gt 1 ] ; then
        echo $DEVICE is ambiguous \"$(ls -d device/*/$DEVICE 2> /dev/null)\"
        return 1
    fi

    # Select which blob setup script to use, if any.  We currently
    # assume that $DEVICE maps to the filesystem location, which is true
    # for the devices we support now (oct 2012) that do not require blobs.
    # The emulator uses a $DEVICE of 'emulator' but its device/ directory
    # uses the 'goldfish' name.
    if [ -f device/*/$DEVICE/download-blobs.sh ] ; then
        important_files="device/*/$DEVICE/download-blobs.sh"
        script="cd device/*/$DEVICE && ./download-blobs.sh"
    elif [ -f device/*/$DEVICE/extract-files.sh ] ; then
        important_files="device/*/$DEVICE/extract-files.sh"
        script="cd device/*/$DEVICE && ./extract-files.sh"
    elif [ -f b2g-blobs/*/$DEVICE/download-blobs.sh ] ; then
        important_files="b2g-blobs/*/$DEVICE/download-blobs.sh"
        script="cd b2g-blobs/*/$DEVICE && ./download-blobs.sh"
    else
        important_files=
        script=
    fi

    # If we have files that are important to look at, we need
    # to check if they've changed
    if [ -n "$important_files" ] ; then
        new_hash=$(cat $important_files | openssl sha1)
        if [ -f "$hash_file" ] ; then
            old_hash=$(cat "$hash_file")
        fi
        if [ "$old_hash" != "$new_hash" ] ; then
            echo Blob setup script has changed, re-running &&
            sh -c "$script" &&
            mkdir -p "$(dirname "$hash_file")" &&
            echo "$new_hash" > "$hash_file"
        fi
    else
        rm -f $hash_file
    fi

    return $?
}

. setup.sh &&
if [ -f patches/patch.sh ] ; then
    . patches/patch.sh
fi &&
configure_device &&
time nice -n19 make $MAKE_FLAGS $@

ret=$?
echo -ne \\a
if [ $ret -ne 0 ]; then
	echo
	echo \> Build failed\! \<
	echo
	echo Build with \|./build.sh -j1\| for better messages
	echo If all else fails, use \|rm -rf objdir-gecko\| to clobber gecko and \|rm -rf out\| to clobber everything else.
else
	if echo $DEVICE | grep generic > /dev/null ; then
		echo Run \|./run-emulator.sh\| to start the emulator
		exit 0
	fi
	case "$1" in
	"gecko")
		echo Run \|./flash.sh gecko\| to update gecko
		;;
	*)
		echo Run \|./flash.sh\| to flash all partitions of your device
#aks img -> fls
~/workspace/B2Gxmm6321/B2G/MEX/dwdtools/HexToFls/Linux/HexToFls_E2_Linux --prg ~/workspace/B2Gxmm6321/B2G/MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg --output ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/boot.fls  --tag BOOT_IMG --psi ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/psi_ram.flb --ebl ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/ebl.flb ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/boot.img

~/workspace/B2Gxmm6321/B2G/MEX/dwdtools/HexToFls/Linux/HexToFls_E2_Linux --prg ~/workspace/B2Gxmm6321/B2G/MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg --output ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/system.fls  --tag SYSTEM --psi ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/psi_ram.flb --ebl ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/ebl.flb ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/system.img

~/workspace/B2Gxmm6321/B2G/MEX/dwdtools/HexToFls/Linux/HexToFls_E2_Linux --prg ~/workspace/B2Gxmm6321/B2G/MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg --output ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/userdata.fls  --tag USERDATA --psi ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/psi_ram.flb --ebl ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/ebl.flb ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/userdata.img

~/workspace/B2Gxmm6321/B2G/MEX/dwdtools/HexToFls/Linux/HexToFls_E2_Linux --prg ~/workspace/B2Gxmm6321/B2G/MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg --output ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/cache.fls  --tag CACHE --psi ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/psi_ram.flb --ebl ~/workspace/B2Gxmm6321/B2G/build/debug/android/target/product/xmm6321_svb/ebl.flb ~/workspace/b2g-jb-xmm6321/b2g-xmm6321/out/target/product/xmm6321_svb/cache.img
		;;
	esac
	exit 0
fi

exit $ret
