#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

typedef struct tcvst_obj {
        FILE* f;
        AV* fields;
} *Text__CVS__Tab;

void
chomp(char *s) {
	s += strlen(s) - 1;
	if (*s == '\n') *s = '\0';
}

char*
get_line(Text__CVS__Tab obj) {
	char line[BUFSIZ];
	if(fgets(line,sizeof(line),obj->f) == NULL || !line || !*line) return NULL;
	chomp(line);
	return strlen(line) ? line : get_line(obj);
}

void
read_fields(Text__CVS__Tab obj) {
	char* line = get_line(obj);
	if(line != NULL) {
		char delims[] = "\t";
		char* result = NULL;
		unsigned int j = 0;

		obj->fields = newAV();

		result = strtok(line,delims);
		while( result != NULL ) {
			av_store(obj->fields,j++,newSVpvn(result,strlen(result)));
			result = strtok( NULL, delims );
		};
	};
}

SV*
pase_line(Text__CVS__Tab obj) {
	HV* ret;

	char* line = get_line(obj);
	if(line == NULL) return newSV(0);

	char delims[] = "\t";
	char* result = NULL;
	unsigned int j = 0;

	ret = newHV();

	result = strtok(line,delims);
	while( result != NULL ) {
		SV **curr = av_fetch(obj->fields,j++,0);
		char* key = "";
		if (curr != NULL) key = SvPV_nolen(*curr);
		hv_store( ret, key, strlen(key), newSVpvn(result,strlen(result)), 0);
	    result = strtok( NULL, delims );
	};

	return newRV_noinc((SV*)ret);
}


MODULE = Text::CVS::Tab		PACKAGE = Text::CVS::Tab		PREFIX = tcvst_
PROTOTYPES: DISABLE

# constructor
Text::CVS::Tab
tcvst_parse(class, filename)
    char* class
    char* filename
    PREINIT:
        PERL_UNUSED_VAR(class);
    CODE:
        {
            Text__CVS__Tab obj;            
            obj = malloc(sizeof(struct tcvst_obj));
            
            FILE *f = fopen(filename, "r");
            if(f==NULL) {
            	free(obj);
            	XSRETURN_UNDEF;
            } else {
            	obj->f = f;
            };

            read_fields(obj);

            RETVAL = obj;
        }
    OUTPUT:
        RETVAL

# get next hashref
SV*
tcvst_next(Text::CVS::Tab obj)
    CODE:
        {
            RETVAL = pase_line(obj);
        }
    OUTPUT:
        RETVAL

# show fields as array_ref
SV*
tcvst_fields(Text::CVS::Tab obj)
    CODE:
        {
            RETVAL = obj->fields ? newRV_inc((SV*)obj->fields) : newSV(0);
        }
    OUTPUT:
        RETVAL

void
tcvst_DESTROY(Text::CVS::Tab obj)
    CODE:
        {
        	if(obj->f) fclose(obj->f);
            free(obj);
            obj = NULL;
        }
