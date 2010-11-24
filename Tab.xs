#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

typedef struct tcvst_obj {
        int fd;
        FILE* fp;
} *Text__CVS__Tab;





MODULE = Text::CVS::Tab		PACKAGE = Text::CVS::Tab		PREFIX = tcvst_
PROTOTYPES: DISABLE

# SVt_PVGV  Glob (possible a file handle)


# constructor
# Text::CVS::Tab
int
tcvst_new(class, filename)
    char* class
    char* filename
    PREINIT:
        PERL_UNUSED_VAR(class);
    CODE:
        {
            Text__CVS__Tab obj;            
            obj = malloc(sizeof(struct tcvst_obj));
            
            FILE *f = fopen(filename, "r");
            if(f==NULL) XSRETURN_UNDEF;
            //setlinebuf(f);
            //char* buf;
            //setvbuf(f, buf, _IOLBF, 0);
            printf("i am open\n");

            char buffer[2000];
            fgets(buffer, 2000, f);
            printf("sfsdf %s\n",buffer);
            
            fgets(buffer, 2000, f);
            printf("sfsdf %s\n",buffer);
            
            fgets(buffer, 2000, f);
            printf("sfsdf %s\n",buffer);
            
   char ch;         
while((ch=fgetc(f)) != EOF)
      printf("%c", ch);

            
            //RETVAL = obj;
            RETVAL = 1;
        }
    OUTPUT:
        RETVAL










void
tcvst_DESTROY(Text::CVS::Tab obj)
    CODE:
        {
            free(obj);
            obj = NULL;
        }