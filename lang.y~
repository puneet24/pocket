%{
#include<stdio.h>
#include<stdlib.h>

int yylex(void);
void yyerror(char *);
%}

%union {
	int iValue;
	char sIndex;
	nodeType *nPtr;
};

%token INT CHAR STRING EQUAL GT LT LTE GTE ET SEMICOLON COMMA IF ELSE WHILE MINUS PLUS STAR DIV VAR NUMBER STRING_LIT CHAR_LIT

%%
program: statement_list SEMICOLON {printf("puneet");}
	    ;
	    
statement_list: statement statement_list {printf("hello");}
			 |
			 ;
			 
statement: declarative SEMICOLON {printf("kok");}
		 |expression SEMICOLON {printf("olol");}
		 ;
		 
declarative: INT VAR {printf("lol");}
		   |CHAR VAR
		   |STRING VAR
		   ;
		  
expression: id
		  |VAR EQUAL expression
		  |expression PLUS expression
		  |expression MINUS expression
		  |expression STAR expression
		  |expression DIV expression
		  ;
		  
id: VAR	
    |NUMBER
    |CHAR_LIT
    |STRING_LIT
    ;
%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}

