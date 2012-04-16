#
# Copyright (C) 2011 Intel Mobile Communications GmbH
#
# Releasetools hook for XMM2231
#
# Here you can add variant specific custom steps to the OTA process
#
# imc.* functions are implemented inside updater/extra_hooks.c

"""Emit commands needed for IMC devices during OTA installation
(installing the radio image)."""

import common
import re

def CheckSufficientSpace(info):
  #Check that we have sufficient space in the SD card to extract the FLS files
  #TODO: Derive FLS file space consumption automatically. Currently hardcoded to 20M.
  info.script.AppendExtra('ifelse(is_mounted("/sdcard")!="/sdcard",mount("vfat","EMMC","/dev/block/sdcard", "/sdcard"), NULL);') 
  info.script.AppendExtra('imc.checksufficientspace("/sdcard/", 20480);')

def CheckSufficientPower(info):
  #Check that we have sufficient power to carry out the update. The function will abort the script if this is not the case.
  info.script.AppendExtra('imc.checksufficientpower();')

def AddFlsFiles(info):
  files = "XMM2231.fls,vlx.fls,linux.fls,initrd.fls,initrd_recovery.fls"
  print "Packaging FLS files: " + files
  for filename in files.split(','):
    path = "RADIO/" + filename
    print "Processing " + path
    filehandle = info.input_zip.read(path)
    common.ZipWriteStr(info.output_zip, filename, filehandle)

  info.script.Print("Extracting FLS files...")
  info.script.ShowProgress(0.2, 10) #Advance progress bar 20% over 10 secs while extracting FLS files.
  #Copy FLS files to SD card

  info.script.AppendExtra('ifelse(is_mounted("/sdcard")!="/sdcard",mount("vfat","EMMC","/dev/block/sdcard", "/sdcard"), NULL);') 

  for filename in files.split(','):
    path = "/sdcard/" + filename
    info.script.AppendExtra('package_extract_file("' + filename + '","' +  path + '");')

  mexfilelist = "/mmc/" + files
  mexfilelist = mexfilelist.replace(",",",/mmc/")
  print "List of files for MEX FOTA update: " + mexfilelist
  info.script.AppendExtra('imc.triggermexfota("/sdcard/mex_fota_cmd", "FLASH:", "' + mexfilelist + '");')
  info.script.SetProgress(1) #Set progress bar to end of FLS extraction

def IFX_test(info):
  print "Installing IMC_test OTA extension"
  info.script.Print("Running IMC_test OTA extension...")

  #Copy our dummy file to OTA package
  dummy_image = info.input_zip.read("RADIO/asound.conf")
  common.ZipWriteStr(info.output_zip, "asound.conf", dummy_image)

  #Add steps to the script that will copy our file somewhere and run our dummy function
  #The mount below uses a generic Edify generator macro (see build/tools/releasetools/edify_generator.py) - it could also have been specified using AppendExtra('mount ...)
  info.script.Mount("ext4","EMMC","/dev/block/hda2", "/data"); 
  info.script.AppendExtra('package_extract_file("asound.conf", "/data/asound.conf");')
  info.script.AppendExtra('imc.testfnc("/data/asound.conf","SomeDummyOption");')
  #File should now be inside userdata partition - lets clean up again, since this is just for demonstrating
  info.script.AppendExtra('delete("/data/asound.conf");')
  #Main script will unmount before resetting, but for sake of example, unmount here
  info.script.AppendExtra('unmount("/data");')


#These steps are called in the beginning of an OTA update
def FullOTA_Assertions(info):
  print "IMC: vendor specific OTA assertion hook for full OTA update"
  CheckSufficientPower(info)
  CheckSufficientSpace(info)

def IncrementalOTA_Assertions(info):
  print "IMC: vendor specific OTA assertion hook for incremental OTA update"
  CheckSufficientPower(info)
  CheckSufficientSpace(info)

#These steps are called in the end of an OTA update
def FullOTA_InstallEnd(info):
  print "IMC: vendor specific OTA end hook for full OTA update"
  AddFlsFiles(info)

def IncrementalOTA_InstallEnd(info):
  print "IMC: vendor specific OTA end hook for incremental OTA update"
  AddFlsFiles(info)

