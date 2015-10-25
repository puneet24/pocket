%{
#include<stdio.h>
#include<stdlib.h>
#include "prototypes.h"
#include "y.tab.h"
%}

%%
[ \t\n] {;}
(\".*\") {strcpy(yylval.val.sval,yytext); return STRING_LIT;}
('.') {yylval.val.cval = yytext[1]; return CHAR_LIT;}
; {return SEMICOLON;}
, {return COMMA;}
int {return INT;}
char { return CHAR;}
string {return STRING;}
if {return IF;}
while {return WHILE;}
else {return ELSE;}
- {strcpy(yylval.val.sname,yytext);return MINUS;}
\+ {strcpy(yylval.val.sname,yytext);return PLUS;}
\* {strcpy(yylval.val.sname,yytext);return STAR;}
\/ {strcpy(yylval.val.sname,yytext);return DIV;}
(>=) {strcpy(yylval.val.sname,yytext);return GTE;}
(==) {strcpy(yylval.val.sname,yytext);return ET;}
(<=) {strcpy(yylval.val.sname,yytext);return LTE;}
(>) {strcpy(yylval.val.sname,yytext);return GT;}
(<) {strcpy(yylval.val.sname,yytext);return LT;}
(=) {strcpy(yylval.val.sname,yytext);return EQUAL;}
[a-zA-Z_][a-zA-Z]* {strcpy(yylval.val.sname,yytext);return VAR;}
[0-9]+ {yylval.val.ival = atoi(yytext); return NUMBER;}
. { return *yytext;  }
%%


int yywrap(void) {
	return 1;
}
