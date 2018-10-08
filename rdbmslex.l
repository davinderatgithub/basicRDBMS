%{
#include <stdlib.h>
#include "ytab.h"

%}
%s Select
%%

Select			{
					yylval.stringval = (char *)malloc(yyleng*sizeof(char));
					yylval.stringval = yytext;
					return TOK_SELECT;
				}

From 			{
					//printf("From %s\n", yytext);
					yylval.stringval = (char *)malloc(yyleng*sizeof(char));
					yylval.stringval = yytext;
					return TOK_FROM;
				}

[A-Za-z0-9]+	{
					//printf("string %s\n", yytext);
					yylval.stringval = (char *)malloc(yyleng*sizeof(char));
					yylval.stringval = yytext;		
					return OBJ;
				}

","				return TOK_COMMA;

; 			return TOK_SEMICOLON;

[ \t\n]			;
.		yyerror("invalid character");

%%

int yywrap(void) {
	return 1;
}