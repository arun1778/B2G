#!/bin/bash

#aks img -> fls
MEX_HEXTOFLS=../MEX/dwdtools/HexToFls/Linux/HexToFls_E2_Linux
MEX_PRG_FILE=../MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg
MEX_NAND_BOOT_DIR=../MEX/dwdtools/boot/xmm6321/EMMC_BOOT/board_xmm6321
B2G_BUILD_OUT=out/target/product/xmm6321_svb

PSI_RAM_FLB=${B2G_BUILD_OUT}/psi_ram.flb
EBL_FLB=${B2G_BUILD_OUT}/ebl.flb
SYSTEM_FLS=${B2G_BUILD_OUT}/system.fls
USERDATA_FLS=${B2G_BUILD_OUT}/userdata.fls
CACHE_FLS=${B2G_BUILD_OUT}/cache.fls
BOOT_FLS=${B2G_BUILD_OUT}/boot.fls

	${MEX_HEXTOFLS} --prg $MEX_PRG_FILE --output $PSI_RAM_FLB \
	                -s $MEX_NAND_BOOT_DIR/psi_ram.xor_script.txt \
		            --tag PSI_RAM $MEX_NAND_BOOT_DIR/psi_ram.hex

	${MEX_HEXTOFLS} --prg $MEX_PRG_FILE --output $EBL_FLB \
	                --psi $PSI_RAM_FLB \
	                --tag EBL $MEX_NAND_BOOT_DIR/ebl.hex

	${MEX_HEXTOFLS}          \
		--prg $MEX_PRG_FILE  \
		--output $SYSTEM_FLS \
		--tag SYSTEM         \
	        --psi $PSI_RAM_FLB   \
		--ebl $EBL_FLB       \
		$B2G_BUILD_OUT/system.img

	${MEX_HEXTOFLS}          \
	        --prg $MEX_PRG_FILE    \
		--output $USERDATA_FLS \
		--tag USERDATA         \
		--psi $PSI_RAM_FLB     \
		--ebl $EBL_FLB         \
		$B2G_BUILD_OUT/userdata.img

	${MEX_HEXTOFLS}                 \
	    --prg $MEX_PRG_FILE         \
            --output $CACHE_FLS     \
            --tag CACHE             \
            --psi $PSI_RAM_FLB      \
            --ebl $EBL_FLB          \
            $B2G_BUILD_OUT/cache.img

	${MEX_HEXTOFLS}                 \
       	   --prg $MEX_PRG_FILE      \
           --output $BOOT_FLS       \
           --tag BOOT_IMG           \
              --psi $PSI_RAM_FLB    \
           --ebl $EBL_FLB           \
                 ${B2G_BUILD_OUT}/boot.img
