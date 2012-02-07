/*
 * Copyright (C) 2011 Intel Mobile Communications GmbH
 *
 * Example of variant specific function to include inside an OTA update
 * 
 */

#include <stdio.h>
#include <errno.h>
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include "edify/expr.h"

Value* ImcTestFn(const char* name, State* state, int argc, Expr* argv[]) {
    char* dummyfile;
    char* somestring;
    FILE *fp;
    if (ReadArgs(state, argv, 2, &dummyfile, &somestring) < 0) {
        return NULL;
    }

    printf("ImcTestFn() - dummyfile=%s, somestring=%s\n", dummyfile, somestring);

    fp=fopen(dummyfile,"rb");
    if(fp) printf("DummyFile (%s) could be opened (file copy successful)\n", dummyfile);
    else printf("DummyFile (%s) could NOT be opened (file copy failed)", dummyfile);
    close(fp);

    return StringValue(strdup(""));
}

Value* TriggerMexFota(const char* name, State* state, int argc, Expr* argv[]) {
    char* mex_fota_cmd_file;
    char* command;
    char* filenames;
    FILE *fp;
    int len;
    if (ReadArgs(state, argv, 3, &mex_fota_cmd_file, &command, &filenames) < 0) {
        return NULL;
    }

    fp=fopen(mex_fota_cmd_file, "wb");
    if(!fp)
    {
      printf("Could not open %s for writing\n", mex_fota_cmd_file);
      return NULL;
    }
    
    printf("Writing MEX fota command % to %s\n", command, mex_fota_cmd_file);
    len=strlen(command);
    fwrite(command, 1, len, fp);
    printf("Wrote %i bytes to %s\n", len, mex_fota_cmd_file);

    printf("Writing list of MEX fota files to %s: %s\n", mex_fota_cmd_file, filenames);
    len=strlen(filenames);
    fwrite(filenames, 1, len, fp);
    printf("Wrote %i bytes to %s\n", len, mex_fota_cmd_file);
    fclose(fp);

    return StringValue(strdup(""));
}



void Register_librecovery_updater_imc() {
    fprintf(stderr, "installing IMC updater extensions\n");
    RegisterFunction("imc.testfnc", ImcTestFn);
    RegisterFunction("imc.triggermexfota", TriggerMexFota);

}
