%{
#include<stdio.h>
#include<stdlib.h>
#include "prototypes.h"
int yylex(void);
void yyerror(char *);
void display_symbol_table();
void make_entry(int,union constant);
nodeType* make_node(int,int,union constant);
nodeType* add_node(nodeType*,nodeType*,nodeType*);
void displaynode(nodeType*);
void display(nodeType*);
SYM_TAB *start_sym = NULL;
%}

%union {
	union constant val;
	nodeType *nptr;
};

%token <val> VAR
%token <val> NUMBER
%token <val> CHAR_LIT
%token <val> STRING_LIT 
%token <val> EQUAL
%token <val> GT
%token <val> LT
%token <val> LTE
%token <val> GTE
%token <val> ET
%token <val> PLUS
%token <val> MINUS
%token <val> STAR
%token <val> DIV

%type <nptr> const expression

%token INT CHAR STRING SEMICOLON COMMA IF ELSE WHILE

%%
program: statement_list SEMICOLON {display_symbol_table();}
	    ;
	    
statement_list: statement statement_list {}
			 |
			 ;
			 
statement: declarative SEMICOLON {}
		 |expression SEMICOLON { display($1); }
		 |block SEMICOLON
		 ;
		 
declarative: INT VAR { make_entry(1,$2); display_symbol_table();}
		   |CHAR VAR		 { make_entry(2,$2); }
		   |STRING VAR	 { make_entry(3,$2); }
		   ;
		  
expression: expression EQUAL expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3);}
		  			|expression PLUS expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3); }
		  			|expression MINUS expression { $$ = make_node(2,0,$2);$$ = add_node($$,$1,$3); }
		  			|expression STAR expression { $$ = make_node(2,0,$2);$$ = add_node($$,$1,$3); }
		  			|expression DIV expression { $$ = make_node(2,0,$2);$$ = add_node($$,$1,$3); }
		  			|VAR 				{ $$ = make_node(1,0,$1); $$ = add_node($$,NULL,NULL);}
		  			|const            { $$ = add_node($1,NULL,NULL); }
		  			;

const: NUMBER { $$ = make_node(0,1,$1); }
      |CHAR_LIT { $$ = make_node(0,2,$1);}
      |STRING_LIT { $$ = make_node(0,3,$1);}
      ;
%%

void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

void displaynode(nodeType *root){
	printf("\ntype :- %d\n ",root->typo);
	if(root->typo == 0){
		if(root->datatype == 1)
			printf("value = %d\n",root->val.ival);
		if(root->datatype == 2)
			printf("value = %c\n",root->val.cval);
		if(root->datatype == 3)
			printf("value = %s\n",root->val.sval);
	}
	else if(root->typo == 1){
		printf("variable name :- %s",root->sym_ptr->symbol_name);
	}
	else{
		printf("operator = %s\n",root->val.sname);
	}
}

void display(nodeType *root)
{
	if(root->left != NULL)
		display(root->left);
	displaynode(root);
	if(root->right != NULL)
		display(root->right);
}

nodeType* add_node(nodeType *mid,nodeType *l,nodeType *r){
	mid->left = l;
	mid->right = r;
	return mid;
}

nodeType* make_node(int task,int type,union constant value){
	nodeType *ptr;
	ptr = (nodeType*)malloc(sizeof(nodeType));
	ptr->left = NULL;
	ptr->right = NULL;
	ptr->typo = task;
	if(task == 1){
		SYM_TAB *temp = start_sym,*last;
		for(;temp!=NULL;temp = temp->next){
			if(strcmp(temp->symbol_name,value.sname) == 0){
				ptr->sym_ptr = temp;
				return ptr;
			}
		}
		printf("\nUndefined Symbol...\n");
		exit(0);
	}
	else if(task==0){
		ptr->val = value;
		ptr->datatype = type;
	}
	else{
		ptr->val = value;
	}
	return ptr;

}

void make_entry(int type,union constant obj){
	SYM_TAB *temp,*last;
	for(temp = start_sym;temp!=NULL;temp = temp->next){
		last = temp;
		if(strcmp(temp->symbol_name,obj.sname) == 0){
			printf("\nRecladaration Error...");
			exit(0);
		}
	}

	temp = (SYM_TAB*)malloc(sizeof(SYM_TAB));
	temp->datatype = type;
	temp->next = NULL;
	temp->symbol_name = (char*)malloc(sizeof(sizeof(char)*(strlen(obj.sname)+1)));
	strcpy(temp->symbol_name,obj.sname);
	if(start_sym == NULL)
		start_sym = temp;
	else
		last->next = temp;
}

void display_symbol_table(){
	SYM_TAB *temp;
	for(temp = start_sym;temp!=NULL;temp = temp->next){
		printf("%d %s\n",temp->datatype,temp->symbol_name);
	}
}

int main(void) {
	yyparse();
	return 0;
}

