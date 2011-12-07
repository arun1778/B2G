# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
