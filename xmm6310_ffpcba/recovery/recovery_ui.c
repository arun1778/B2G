/*
 * Copyright (C) 2011-2012 Intel Mobile Communications GmbH
 * Copyright (C) 2009 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Nov 02 2012: Add copyright.
 */

#include <unistd.h>
#include <linux/input.h>

#include "recovery_ui.h"
#include "common.h"

char* MENU_HEADERS[] = { "Vol Up/Dn - Home to select.",
                         "",
                         NULL };

char* MENU_ITEMS[] = { "reboot system now",
                       "apply sdcard:update.zip",
                       "wipe data/factory reset",
                       "wipe cache partition",
                       NULL };

void recover_firmware_update_log();

int device_recovery_start() {
    //recover_firmware_update_log();
    //ui_print("VARIANT: Registered IMC updater extensions\n");
    return 0;
}

int device_toggle_display(volatile char* key_pressed, int key_code) {
    // home+end, or alt+L (either alt key)
#if 0
	return (key_pressed[KEY_HOME] && key_code == KEY_END) ||
            ((key_pressed[KEY_LEFTALT] || key_pressed[KEY_RIGHTALT]) &&
             key_code == KEY_L);
#else //XMM2231 case
    return (key_code == KEY_POWER);
#endif
}

int device_reboot_now(volatile char* key_pressed, int key_code) {
    return key_pressed[KEY_MENU] &&   // menu
           key_pressed[KEY_SEND] &&   // green
           key_code == KEY_END;       // red
}

int device_handle_key(int key, int visible) {
  //printf("%s: Keycode: %i (see linux/input.h)\n", __FUNCTION__, key);
    int alt = ui_key_pressed(KEY_LEFTALT) || ui_key_pressed(KEY_RIGHTALT);

    if (key == KEY_BACK && ui_key_pressed(KEY_HOME)) {
        // Wait for the keys to be released, to avoid triggering
        // special boot modes (like coming back into recovery!).
        while (ui_key_pressed(KEY_BACK) ||
               ui_key_pressed(KEY_HOME)) {
            usleep(1000);
        }
        return ITEM_REBOOT;
    } else if (alt && key == KEY_W) {
        return ITEM_WIPE_DATA;
    } else if (alt && key == KEY_S) {
        return ITEM_APPLY_SDCARD;
    } else if (visible) {
        switch (key) {
	    case KEY_4:
            case KEY_DOWN:
            case KEY_VOLUMEDOWN:
                return HIGHLIGHT_DOWN;

            case KEY_1:
	    case KEY_UP:
            case KEY_VOLUMEUP:
                return HIGHLIGHT_UP;

            case KEY_F4:
            case BTN_MOUSE:
            case KEY_ENTER:
	    case KEY_HOME: //XMM2231 home button
                return SELECT_ITEM;
        }
    }

    return NO_ACTION;
}

int device_perform_action(int which) {
    switch(which)
    {
    case ITEM_REBOOT:
      //ui_print("VARIANT: Action reboot\n");
    	break;
    case ITEM_WIPE_DATA:
      //ui_print("VARIANT: Action wipe\n");
    	break;
    case ITEM_APPLY_SDCARD:
      //ui_print("VARIANT: Action apply\n");
    	break;

    }

	return which;
}

int device_wipe_data() {
  //ui_print("VARIANT: device_wipe_data() stub\n");

	return 0;
}
