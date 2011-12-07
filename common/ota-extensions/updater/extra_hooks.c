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

void Register_librecovery_updater_imc() {
    fprintf(stderr, "installing IMC updater extensions\n");
    RegisterFunction("imc.testfnc", ImcTestFn);

}
