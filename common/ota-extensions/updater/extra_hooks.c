/*
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (C) 2011 Intel Mobile Communications GmbH
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
 * Notes - Intel Mobile Communications:
 * Variant specific updater binary functions to include inside an OTA update
 * Most logic in init_sys_paths() copied from services/jni/com_android_server_BatteryService.cpp
 */

#include <stdio.h>
#include <errno.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <unistd.h>
#include <dirent.h>
#include <limits.h>
#include <sys/statfs.h>
#include "edify/expr.h"


#define BATTERY_CAPACITY_REQUIRED_FOR_UPDATE 50

/*

  The part below has been mainly copied from com_android_server_BatteryService.cpp to make sure we have the exact
  same interface as the "real" Android battery management. It encapsulates the interface towards the
  /sys/class/power_supply interface and should be kept in sync with com_android_server_BatteryService.cpp.

  Going forward they may be a real HAL layer for power supplies (Dianne Hackborn suggested this in a
  post on the web). In case this component is ever used on a platform where such a layer is present,
  this component should be reworked to utilize the HAL layer instead.

*/


#define POWER_SUPPLY_PATH "/sys/class/power_supply"

static struct
{
  char* acOnlinePath;
  char* usbOnlinePath;
  char* usbWakeupPath;
  char* batteryStatusPath;
  char* batteryHealthPath;
  char* batteryPresentPath;
  char* batteryCapacityPath;
  char* batteryVoltagePath;
  char* batteryTemperaturePath;
  char* batteryTechnologyPath;
} gPaths;

static int readFromFile(const char* path, char* buf, size_t size)
{
  if(!path)
    return -1;
  int fd = open(path, O_RDONLY, 0);
  if(fd == -1)
  {
    printf("Could not open '%s'", path);
    return -1;
  }

  size_t count = read(fd, buf, size);
  if(count > 0)
  {
    count = (count < size) ? count : size - 1;
    while(count > 0 && buf[count - 1] == '\n') count--;
    buf[count] = '\0';
  }
  else
  {
    buf[0] = '\0';
  }

  close(fd);
  return count;
}

void init_sys_paths(void)
{
  char    path[PATH_MAX];
  struct dirent* entry;

  DIR* dir = opendir(POWER_SUPPLY_PATH);
  if(dir == NULL)
  {
    printf("Could not open %s\n", POWER_SUPPLY_PATH);
    return;
  }
  while((entry = readdir(dir)))
  {
    const char* name = entry->d_name;

    // ignore "." and ".."
    if(name[0] == '.' && (name[1] == 0 || (name[1] == '.' && name[2] == 0)))
    {
      continue;
    }

    char buf[20];
    // Look for "type" file in each subdirectory
    snprintf(path, sizeof(path), "%s/%s/type", POWER_SUPPLY_PATH, name);
    int length = readFromFile(path, buf, sizeof(buf));
    if(length > 0)
    {
      if(buf[length - 1] == '\n')
        buf[length - 1] = 0;

      if(strcmp(buf, "Mains") == 0)
      {
        snprintf(path, sizeof(path), "%s/%s/online", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.acOnlinePath = strdup(path);
      }
      else if(strcmp(buf, "USB") == 0)
      {
        snprintf(path, sizeof(path), "%s/%s/online", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.usbOnlinePath = strdup(path);

        snprintf(path, sizeof(path), "%s/%s/power/wakeup", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.usbWakeupPath = strdup(path);
      }
      else if(strcmp(buf, "Battery") == 0)
      {
        snprintf(path, sizeof(path), "%s/%s/status", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.batteryStatusPath = strdup(path);
        snprintf(path, sizeof(path), "%s/%s/health", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.batteryHealthPath = strdup(path);
        snprintf(path, sizeof(path), "%s/%s/present", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.batteryPresentPath = strdup(path);
        snprintf(path, sizeof(path), "%s/%s/capacity", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.batteryCapacityPath = strdup(path);

        snprintf(path, sizeof(path), "%s/%s/voltage_now", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
        {
          gPaths.batteryVoltagePath = strdup(path);
          // voltage_now is in microvolts, not millivolts
          //                    gVoltageDivisor = 1000;
        }
        else
        {
          snprintf(path, sizeof(path), "%s/%s/batt_vol", POWER_SUPPLY_PATH, name);
          if(access(path, R_OK) == 0)
            gPaths.batteryVoltagePath = strdup(path);
        }

        snprintf(path, sizeof(path), "%s/%s/temp", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
        {
          gPaths.batteryTemperaturePath = strdup(path);
        }
        else
        {
          snprintf(path, sizeof(path), "%s/%s/batt_temp", POWER_SUPPLY_PATH, name);
          if(access(path, R_OK) == 0)
            gPaths.batteryTemperaturePath = strdup(path);
        }

        snprintf(path, sizeof(path), "%s/%s/technology", POWER_SUPPLY_PATH, name);
        if(access(path, R_OK) == 0)
          gPaths.batteryTechnologyPath = strdup(path);
      }
    }
  }
  closedir(dir);

  if(!gPaths.acOnlinePath)
    printf("acOnlinePath not found\n");
  if(!gPaths.usbOnlinePath)
    printf("usbOnlinePath not found\n");
  if(!gPaths.usbWakeupPath)
    printf("usbWakeupPath not found\n");
  if(!gPaths.batteryStatusPath)
    printf("batteryStatusPath not found\n");
  if(!gPaths.batteryHealthPath)
    printf("batteryHealthPath not found\n");
  if(!gPaths.batteryPresentPath)
    printf("batteryPresentPath not found\n");
  if(!gPaths.batteryCapacityPath)
    printf("batteryCapacityPath not found\n");
  if(!gPaths.batteryVoltagePath)
    printf("batteryVoltagePath not found\n");
  if(!gPaths.batteryTemperaturePath)
    printf("batteryTemperaturePath not found\n");
  if(!gPaths.batteryTechnologyPath)
    printf("batteryTechnologyPath not found\n");

  return;
}

Value* CheckSufficientSpace(const char* name, State* state, int argc, Expr* argv[])
{
  char* path;
  char* required_space;
  char* end;
  int required_kbytes = 0;
  int available_kbytes = 0;
  char *result = NULL;
  if(ReadArgs(state, argv, 2, &path, &required_space) < 0)
  {
    goto done;
  }

  if(strlen(path) == 0)
  {
    ErrorAbort(state, "Path argument to CheckSufficientSpace() can't be empty");
    goto done;
  }

  if(strlen(required_space) == 0)
  {
    ErrorAbort(state, "Required space argument to CheckSufficientSpace() can't be empty");
    goto done;
  }

  required_kbytes = strtoul(required_space, &end, 10);
  if(required_space[0] == '\0' || *end != '\0')
  {
    fprintf(stderr, "[%s] is not an int\n", required_space);
    goto done;
  }

  struct statfs fiData;
  if(statfs(path, &fiData))
  {
    ErrorAbort(state, "Failed to statfs path %s", path);
    goto done;
  }
  else
  {
    available_kbytes = (fiData.f_bsize * fiData.f_bfree) >> 10; //Calculate bytes and change into kilobytes
    printf("Available kilobytes in %s: %i\n", path, available_kbytes);
  }

  printf("Required kilobytes in %s: %i\n", path, required_kbytes);

  if(available_kbytes < required_kbytes)
  {
    printf("Insufficient free space detected - aborting\n");
    ErrorAbort(state, "Insufficient space in %s. %i kB required, only %i kB available.\n", path, required_kbytes, available_kbytes);
  }
  else
  {
    printf("Sufficient free space detected\n");
    result = strdup("");
  }

done:
  if(path) free(path);
  if(required_space) free(required_space);
  return StringValue(result);
}

Value* CheckSufficientPower(const char* name, State* state, int argc, Expr* argv[])
{
  const int SIZE = 128;
  char buf[SIZE];
  int count;
  int capacity = 0;
  int update_possible = 0;
  char *result = NULL;

  int fd;

  printf("Checking power supply situation\n");

  init_sys_paths();

  if(gPaths.batteryCapacityPath)
  {
    fd = open(gPaths.batteryCapacityPath, O_RDONLY, 0);
    if(fd == -1)
    {
      printf("Could not open battery capacity sysfs file...\n");
    }
    else
    {
      count = read(fd, buf, SIZE);
      if(count > 0)
      {
        capacity = atoi(buf);
        printf("Battery capacity read: %i\n", capacity);
      }
      else
      {
        printf("Battery capacity could not be read\n");
      }
    }
    close(fd);
  }
  if(capacity > BATTERY_CAPACITY_REQUIRED_FOR_UPDATE)
  {
    update_possible = 1;
  }
  else
  {
    printf("Battery capacity insufficient - checking if we have a power supply connected\n");
    /* Check if we have another power source */

    if(gPaths.acOnlinePath)
    {
      fd = open(gPaths.acOnlinePath, O_RDONLY, 0);
      if(fd == -1)
      {
        printf("Could not open ac supply sysfs file...\n");
      }
      else
      {
        count = read(fd, buf, SIZE);
        if(count > 0)
        {
          if(buf[0] == '1')
          {
            printf("AC supply present\n");
            update_possible = 1;
          }
          else
          {
            printf("AC supply not present\n");
          }
        }
        else
        {
          printf("AC supply sysfs file could not be read\n");
        }
      }
      close(fd);
    }

    if(gPaths.usbOnlinePath)
    {
      fd = open(gPaths.usbOnlinePath, O_RDONLY, 0);
      if(fd == -1)
      {
        printf("Could not open usb supply sysfs file...\n");
      }
      else
      {
        count = read(fd, buf, SIZE);
        if(count > 0)
        {
          if(buf[0] == '1')
          {
            printf("USB supply present\n");
            update_possible = 1;
          }
          else
          {
            printf("USB supply not present\n");
          }
        }
        else
        {
          printf("USB supply sysfs file could not be read\n");
        }
      }
      close(fd);
    }
  }

  if(!update_possible)
  {
    ErrorAbort(state, "Insufficient power. Charge battery or connect power source.");
  }
  else
  {
    result = strdup("");
    printf("Power is sufficient for update\n");
  }

done:
  return StringValue(result);
}

Value* TriggerMexFota(const char* name, State* state, int argc, Expr* argv[])
{
  char* mex_fota_cmd_file;
  char* command;
  char* filenames;
  FILE *fp;
  unsigned int len;
  char *result = NULL;
  if(ReadArgs(state, argv, 3, &mex_fota_cmd_file, &command, &filenames) < 0)
  {
    goto done;
  }

  fp = fopen(mex_fota_cmd_file, "wb");
  if(!fp)
  {
    ErrorAbort(state, "Could not open %s for writing\n", mex_fota_cmd_file);
    goto done;
  }

  printf("Writing MEX fota command %s to %s\n", command, mex_fota_cmd_file);
  len = strlen(command);
  if(len != fwrite(command, 1, len, fp))
  {
    ErrorAbort(state, "Error writing to %s\n", mex_fota_cmd_file);
    goto done;
  }
  printf("Wrote %i bytes to %s\n", len, mex_fota_cmd_file);

  printf("Writing list of MEX fota files to %s: %s\n", mex_fota_cmd_file, filenames);
  len = strlen(filenames);
  if(len != fwrite(filenames, 1, len, fp))
  {
    ErrorAbort(state, "Error writing to %s\n", mex_fota_cmd_file);
    goto done;
  }
  printf("Wrote %i bytes to %s\n", len, mex_fota_cmd_file);
  fclose(fp);
  result = strdup("");

done:
  if(mex_fota_cmd_file) free(mex_fota_cmd_file);
  if(command) free(command);
  if(filenames) free(filenames);

  return StringValue(result);
}

Value* ImcTestFn(const char* name, State* state, int argc, Expr* argv[])
{
  char* dummyfile;
  char* somestring;
  FILE *fp;
  if(ReadArgs(state, argv, 2, &dummyfile, &somestring) < 0)
  {
    return NULL;
  }

  printf("ImcTestFn() - dummyfile=%s, somestring=%s\n", dummyfile, somestring);

  fp = fopen(dummyfile, "rb");
  if(fp) printf("DummyFile (%s) could be opened (file copy successful)\n", dummyfile);
  else printf("DummyFile (%s) could NOT be opened (file copy failed)", dummyfile);
  fclose(fp);

  return StringValue(strdup(""));
}


void Register_librecovery_updater_imc()
{
  fprintf(stderr, "installing IMC updater extensions\n");
  RegisterFunction("imc.testfnc", ImcTestFn);
  RegisterFunction("imc.triggermexfota", TriggerMexFota);
  RegisterFunction("imc.checksufficientpower", CheckSufficientPower);
  RegisterFunction("imc.checksufficientspace", CheckSufficientSpace);

}
