# Copyright (C) 2011 Intel Mobile Communications GmbH
#
# Releasetools hook example for XMM2231
#
# Here you can add variant specific custom steps to the OTA process
#
# imc.testfnc is implemented inside updater/extra_hooks.c

"""Emit commands needed for IMC devices during OTA installation
(installing the radio image)."""

import common
import re


#IFX
#These steps are called in the beginning of an OTA update
def FullOTA_Assertions(info):
  print "IMC: vendor specific OTA assertion hook for full OTA update"


def IncrementalOTA_Assertions(info):
  print "IMC: vendor specific OTA assertion hook for incremental OTA update"

def IFX_test(info):
  print "Installing IMC_test OTA extension"
  info.script.Print("Running IMC_test OTA extension...")

  #Copy our dummy file to OTA package
  dummy_image = info.input_zip.read("RADIO/asound.conf")
  common.ZipWriteStr(info.output_zip, "asound.conf", dummy_image)

  #Add steps to the script that will copy our file somewhere and run our dummy function
  #The mount below uses a generic Edify generator macro (see build/tools/releasetools/edify_generator.py) - it could also have been specified using AppendExtra('mount ...)
  info.script.Mount("ext3","/dev/block/hda2", "/data"); 
  info.script.AppendExtra('package_extract_file("asound.conf", "/data/asound.conf");')
  info.script.AppendExtra('imc.testfnc("/data/asound.conf","SomeDummyOption");')
  #File should now be inside userdata partition - lets clean up again, since this is just for demonstrating
  info.script.AppendExtra('delete("/data/asound.conf");')
  #Main script will unmount before resetting, but for sake of example, unmount here
  info.script.AppendExtra('unmount("/data");')

#IFX
#These steps are called in the beginning of an OTA update
def FullOTA_InstallEnd(info):
  print "IMC: vendor specific OTA end hook for full OTA update"
  IFX_test(info)

def IncrementalOTA_InstallEnd(info):
  print "IMC: vendor specific OTA end hook for incremental OTA update"
