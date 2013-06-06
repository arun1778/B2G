# Copyright (C) 2013 Intel Mobile Communications GmbH
# Copyright (C) 2012 The Android Open Source Project
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
#
# Jan 10 2013: To adapt for xmm6321_svb

# This file is executed by build/envsetup.sh, and can use anything
# defined in envsetup.sh.
#
# In particular, you can add lunch options with the add_lunch_combo
# function: add_lunch_combo generic-eng

add_lunch_combo xmm6321_emu-userdebug
add_lunch_combo xmm6321_emu-user
add_lunch_combo xmm6321_emu-eng

function xmm6321_emulator()
{
    emulator -kernel $OUT/kernel -sdcard $OUT/1gigdisk.bin "$@"
}

function xmm6321_emulator_recovery()
{
    emulator -kernel $OUT/kernel -ramdisk $OUT/ramdisk-recovery.img -sdcard $OUT/1gigdisk.bin "$@"
}

function xmm6321_emulator_builddiskimage()
{
    device/imc/xmm6321_emu/ftle2flashV2 device/imc/xmm6321_emu/1GBmodem_sw.prg -id68 $OUT/system.img -id70 $OUT/cache.img -id69 $OUT/userdata.img
    
    mv DATA_AREA.BIN $OUT/1gigdisk.bin

    rm BOOT0.BIN BOOT1.BIN

    parted $OUT/1gigdisk.bin print

    echo Hopefully done!
}