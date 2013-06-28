PROJECT_NAME = xmm6321
BOARD_NAME =  board_xmm6321

HIDE = @

ROOT_DIR = ../../../../..

PRODUCT_OUTPUT = $(ROOT_DIR)/images/debug/xmm6321_svb
OUTPUT_DIR     = $(PRODUCT_OUTPUT)/signed
OUTPUT_TEMP    = $(OUTPUT_DIR)/temp

DWDTOOL_DIR = $(ROOT_DIR)/MEX/dwdtools

BOOT_LOADER_DIR = $(DWDTOOL_DIR)/boot/$(PROJECT_NAME)/EMMC_BOOT/$(BOARD_NAME)
MEX_IMAGE_DIR   = $(ROOT_DIR)/images/$(PROJECT_NAME)/$(BOARD_NAME)

FLSSIGN = $(DWDTOOL_DIR)/FlsSign/Linux/FlsSign_E2_Linux
HEX2FLS = $(DWDTOOL_DIR)/HexToFls/Linux/HexToFls_E2_Linux

PRG = $(ROOT_DIR)/MEX/mhw_drv_src/memory_management/mem/scatterfile/XMM6321_REV_1.0/modem_sw.prg

$(OUTPUT_TEMP): $(OUTPUT_DIR)
	$(HIDE)echo "Create output temp dir"
	-$(HIDE)mkdir $(OUTPUT_TEMP)


$(OUTPUT_DIR): 
	$(HIDE)echo "Create output dir"
	-$(HIDE)mkdir $(OUTPUT_DIR)

## PSI_RAM ##

PSI_RAM_HEX         = $(BOOT_LOADER_DIR)/psi_ram.hex
PSI_RAM_XOR         = $(BOOT_LOADER_DIR)/psi_ram.xor_script.txt
PSI_RAM_VER         = $(BOOT_LOADER_DIR)/psi_ram.version.txt
PSI_RAM_SIGN_SCRIPT = ./scripts/psi_ram.signing_script.txt
PSI_RAM_FLS         = $(OUTPUT_TEMP)/psi_ram.fls
PSI_RAM_FLS_SIGNED  = $(OUTPUT_TEMP)/psi_ram_signed.fls

$(PSI_RAM_FLS): $(HEX2FLS) $(PRG) $(PSI_RAM_HEX) $(PSI_RAM_XOR) $(PSI_RAM_VER)
	$(HIDE)echo "Generate PSI_RAM FLS"
	$(HIDE)$(HEX2FLS) $(PSI_RAM_HEX) \
										--prg $(PRG) \
										--tag PSI_RAM \
										-s $(PSI_RAM_XOR) \
										-v $(PSI_RAM_VER) \
										-o $@

$(PSI_RAM_FLS_SIGNED): $(FLSSIGN) $(PSI_RAM_FLS) $(PSI_RAM_SIGN_SCRIPT)
	$(HIDE)echo "Signing PSI_RAM"
	$(HIDE)$(FLSSIGN) $(PSI_RAM_FLS) -s $(PSI_RAM_SIGN_SCRIPT) -o $@

## EBL ##	
	
EBL_HEX          = $(BOOT_LOADER_DIR)/ebl.hex
EBL_VER          = $(BOOT_LOADER_DIR)/ebl.version.txt
EBL_SIGN_SCRIPT  = ./scripts/ebl.signing_script.txt
EBL_FLS          = $(OUTPUT_TEMP)/ebl.fls
EBL_FLS_SIGNED   = $(OUTPUT_TEMP)/ebl_signed.fls

$(EBL_FLS): $(HEX2FLS) $(PRG) $(EBL_HEX) $(EBL_VER) $(PSI_RAM_FLS)
	$(HIDE)echo "Generate EBL FLS"
	$(HIDE)$(HEX2FLS) $(EBL_HEX) \
										--prg $(PRG) \
										--tag EBL \
										-v $(EBL_VER) \
										--psi $(PSI_RAM_FLS) \
										-o $@

$(EBL_FLS_SIGNED): $(FLSSIGN) $(EBL_FLS) $(EBL_SIGN_SCRIPT) $(PSI_RAM_FLS_SIGNED)
	$(HIDE)echo "Signing EBL"
	$(HIDE)$(FLSSIGN) $(EBL_FLS) -s $(EBL_SIGN_SCRIPT) --psi $(PSI_RAM_FLS_SIGNED) -o $@
	
## PSI_FLASH ##
PSI_FLASH_HEX         = $(BOOT_LOADER_DIR)/psi_flash.hex
PSI_FLASH_XOR         = $(BOOT_LOADER_DIR)/psi_flash.xor_script.txt
PSI_FLASH_VER         = $(BOOT_LOADER_DIR)/psi_flash.version.txt
PSI_FLASH_SIGN_SCRIPT = ./scripts/psi_flash.signing_script.txt
PSI_FLASH_FLS         = $(OUTPUT_TEMP)/psi_flash.fls
PSI_FLASH_FLS_SIGNED  = $(OUTPUT_TEMP)/psi_flash_signed.fls

$(PSI_FLASH_FLS): $(HEX2FLS) $(PRG) $(PSI_FLASH_HEX) $(PSI_FLASH_XOR) $(PSI_FLASH_VER) $(EBL_FLS) $(PSI_RAM_FLS)
	$(HIDE)echo "Generate PSI_FLASH FLS"
	$(HIDE)$(HEX2FLS) $(PSI_FLASH_HEX) \
										--prg $(PRG) \
										--tag PSI_FLASH \
										-s $(PSI_FLASH_XOR) \
										-v $(PSI_FLASH_VER) \
										--psi $(PSI_RAM_FLS) \
										--ebl $(EBL_FLS) \
										-o $@

$(PSI_FLASH_FLS_SIGNED): $(FLSSIGN) $(PSI_FLASH_FLS) $(PSI_FLASH_SIGN_SCRIPT) $(EBL_FLS_SIGNED) $(PSI_RAM_FLS_SIGNED)
	$(HIDE)echo "Signing PSI_FLASH"
	$(HIDE)$(FLSSIGN) $(PSI_FLASH_FLS) \
										-s $(PSI_FLASH_SIGN_SCRIPT) \
										--psi $(PSI_RAM_FLS_SIGNED) \
										--ebl $(EBL_FLS_SIGNED) \
										-o $@

## SLB ##
SLB_HEX          = $(BOOT_LOADER_DIR)/slb.hex
SLB_VER          = $(BOOT_LOADER_DIR)/slb.version.txt
SLB_SIGN_SCRIPT  = ./scripts/slb.signing_script.txt
SLB_FLS          = $(OUTPUT_TEMP)/slb.fls
SLB_FLS_SIGNED   = $(OUTPUT_TEMP)/slb_signed.fls

$(SLB_FLS): $(HEX2FLS) $(PRG) $(SLB_HEX) $(SLB_VER) $(PSI_RAM_FLS) $(EBL_FLS)
	$(HIDE)echo "Generate SLB FLS"
	$(HIDE)$(HEX2FLS) $(SLB_HEX) \
										--prg $(PRG) \
										--tag SLB_FLASH \
										-v $(SLB_VER) \
										--psi $(PSI_RAM_FLS) \
										--ebl $(EBL_FLS) \
										-o $@

$(SLB_FLS_SIGNED): $(FLSSIGN) $(SLB_FLS) $(SLB_SIGN_SCRIPT) $(PSI_RAM_FLS_SIGNED) $(EBL_FLS_SIGNED)
	$(HIDE)echo "Signing SLB"
	$(HIDE)$(FLSSIGN) $(SLB_FLS) \
										-s $(SLB_SIGN_SCRIPT) \
										--psi $(PSI_RAM_FLS_SIGNED) \
										--ebl $(EBL_FLS_SIGNED) \
										-o $@

## MEX ##
MEX_FLS = $(MEX_IMAGE_DIR)/XMM6321.fls
MEX_FLS_NOINJ = $(OUTPUT_TEMP)/XMM6321_noinj.fls
MEX_SIGN_SCRIPT = ./scripts/system.signing_script.txt
MEX_FLS_SIGNED_NO_BOOT = $(OUTPUT_TEMP)/XMM6321_signed_no_boot.fls
MEX_FLS_SIGNED = $(OUTPUT_DIR)/XMM6321_signed.fls

$(MEX_FLS_NOINJ): $(FLSSIGN) $(MEX_FLS)
	$(HIDE)echo "remove boot component in MEX"
	$(HIDE)$(FLSSIGN) $(MEX_FLS) -p --removeboot -o $@

$(MEX_FLS_SIGNED_NO_BOOT): $(FLSSIGN) $(MEX_FLS_NOINJ) $(MEX_SIGN_SCRIPT)
	$(HIDE)echo "Signing MEX"
	$(HIDE)$(FLSSIGN) $(MEX_FLS_NOINJ) -s $(MEX_SIGN_SCRIPT) -o $@

$(MEX_FLS_SIGNED): $(FLSSIGN) $(MEX_FLS_SIGNED_NO_BOOT) $(PSI_RAM_FLS_SIGNED) $(EBL_FLS_SIGNED) $(PSI_FLASH_FLS_SIGNED) $(SLB_FLS_SIGNED)
	$(HIDE)echo "Pack MEX with boot component"
	$(HIDE)$(FLSSIGN) $(MEX_FLS_SIGNED_NO_BOOT) \
										--noinjremove \
										--psi $(PSI_RAM_FLS_SIGNED) \
										--ebl $(EBL_FLS_SIGNED) \
										-p $(PSI_FLASH_FLS_SIGNED) \
										-p $(SLB_FLS_SIGNED) \
										-o $@

OTHER_SIGN_SCRIPT = $(MEX_SIGN_SCRIPT)
										
## boot img ##
BOOT_FLS        =  $(PRODUCT_OUTPUT)/boot.fls	
BOOT_FLS_SIGNED =  $(OUTPUT_DIR)/boot_signed.fls
## vlx ##
VLX_FLS        = 	$(PRODUCT_OUTPUT)/vlx.fls
VLX_FLS_SIGNED = 	$(OUTPUT_DIR)/vlx_signed.fls
## cache ##
CACHE_FLS        = $(PRODUCT_OUTPUT)/cache.fls
CACHE_FLS_SIGNED = $(OUTPUT_DIR)/cache_signed.fls
## system ##
SYSTEM_FLS        = $(PRODUCT_OUTPUT)/system.fls
SYSTEM_FLS_SIGNED = $(OUTPUT_DIR)/system_signed.fls
## userdata ##
USERDATA_FLS        = $(PRODUCT_OUTPUT)/userdata.fls
USERDATA_FLS_SIGNED = $(OUTPUT_DIR)/userdata_signed.fls

## sign all other fls ##
FLS_SIGNED_LIST  = $(BOOT_FLS_SIGNED)
FLS_SIGNED_LIST += $(VLX_FLS_SIGNED)
FLS_SIGNED_LIST += $(CACHE_FLS_SIGNED)
FLS_SIGNED_LIST += $(SYSTEM_FLS_SIGNED)
FLS_SIGNED_LIST += $(USERDATA_FLS_SIGNED)

$(FLS_SIGNED_LIST): $(OUTPUT_DIR)/%_signed.fls: $(PRODUCT_OUTPUT)/%.fls $(FLSSIGN) $(OTHER_SIGN_SCRIPT) $(PSI_RAM_FLS_SIGNED) $(EBL_FLS_SIGNED) 
	$(HIDE)$(FLSSIGN) $< \
										-s $(OTHER_SIGN_SCRIPT) \
										--psi $(PSI_RAM_FLS_SIGNED) \
										--ebl $(EBL_FLS_SIGNED) \
										-o $@

fls_sign: $(OUTPUT_TEMP) $(MEX_FLS_SIGNED) $(FLS_SIGNED_LIST)
	$(HIDE)echo "remove temp folder"
	-$(HIDE)rm -rf $(OUTPUT_TEMP)
	$(HIDE)echo "XMM6321 all fls files signed"

clean_sign:
	$(HIDE)echo "clean all signed files"
	-$(HIDE)rm -rf $(OUTPUT_DIR)
	