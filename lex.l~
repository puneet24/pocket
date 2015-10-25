%{
#include<stdio.h>
#include<stdlib.h>
#include "y.tab.h"
%}

%%
[ \t\n] {;}
(\".*\") {yylval.sval = yytextreturn STRING_LIT;}
('.') {yylval.cval = yytext[1]; return CHAR_LIT;}
; {return SEMICOLON;}
, {return COMMA;}
int {return INT;}
char {return CHAR;}
string {return STRING;}
if {return IF;}
while {return WHILE;}
else {return ELSE;}
- {return MINUS;}
\+ {return PLUS;}
\* {return STAR;}
\/ {;return DIV;}
(>=) {return GTE;}
(==) {return ET;}
(<=) {return LTE;}
(>) {return GT;}
(<) {return LT;}
(=) {return EQUAL;}
[a-zA-Z_][a-zA-Z]* {return VAR;}
[0-9]+ {yylaval.ival = atoi(yytext); return NUMBER;}
. { ;  }
%%


int yywrap(void) {
	return 1;
}
