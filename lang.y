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
char *generate_code_for_op(char*,int);
char *generate_expression_code(nodeType*,int);
char *generate_code_while(char*,char*);
char *generate_code_if(char*,char*,char*);
SYM_TAB *start_sym = NULL;
int labelcount = 1, outcount = 1;
%}

%union {
	union constant val;
	char code[1000];
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
%type <code> program statement statement_list block declarative optional

%token INT CHAR STRING SEMICOLON COMMA IF ELSE WHILE

%%
program: statement_list SEMICOLON {/*display_symbol_table();*/ strcpy($$,$1); printf("%s\n",$$); exit(0);}
	    ;
	    
statement_list: statement statement_list { strcpy($$,$1); strcat($$,$2); }
			 |	{ strcpy($$,""); }
			 ;
			 
statement: declarative SEMICOLON { strcpy($$,""); }
		 |expression SEMICOLON { /*display($1);*/ strcpy($$,generate_expression_code($1,-1)); }
		 |block { strcpy($$,$1); }
		 ;

block: WHILE expression '{' statement_list '}'  { char h[1000] = ""; strcpy(h, generate_expression_code($2,-1)); strcpy($$,generate_code_while(h,$4)); }
			 | IF expression '{' statement_list '}' optional  { char h[1000] = ""; strcpy(h, generate_expression_code($2,-1)); strcpy($$,generate_code_if(h,$4,$6)); /*printf("****\n%s",$$)*/ }
			 ;

optional: ELSE '{' statement_list '}' { strcpy($$,$3); }
					|	{ strcpy($$,""); }
					;
		 
declarative: INT VAR {make_entry(1,$2); }
		   |CHAR VAR		 { make_entry(2,$2); }
		   |STRING VAR	 { make_entry(3,$2); }
		   ;
		  
expression: expression EQUAL expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3);}
						|expression GTE expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3); }
						|expression GT expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3); }
						|expression LTE expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3); }
						|expression LT expression { $$ = make_node(2,0,$2); $$ = add_node($$,$1,$3); }
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

char *generate_code_if(char *s1,char *s2,char *s3){
	char str[1000] = "";
	char temp[1000] = "";
	strcpy(str,s1);
	if(strlen(s3) == 0){
		sprintf(temp,"BEQZ $t0,O%d\n",outcount);
		strcat(str,temp);
		strcat(str,s2);
		sprintf(temp,"O%d:\n",outcount);
		strcat(str,temp);
		outcount++;
	}
	else{
		sprintf(temp,"BEQZ $t0,O%d\n",outcount);
		strcat(str,temp);
		strcat(str,s2);
		sprintf(temp,"JMP O%d\n",outcount+1);
		strcat(str,temp);
		sprintf(temp,"O%d:\n",outcount);
		strcat(str,temp);
		strcat(str,s3);
		sprintf(temp,"O%d:\n",outcount+1);
		strcat(str,temp);
		outcount += 2;
	}
	return str;
}

char *generate_code_while(char *s1,char *s2){
	char str[1000] = "";
	char temp[1000] = "";
	sprintf(str,"L%d:\n",labelcount);
	strcat(str,s1);
	sprintf(temp,"BEQZ $t0,O%d\n",outcount);
	strcat(str,temp);
	strcat(str,s2);
	sprintf(temp,"jmp L%d\n",labelcount);
	strcat(str,temp);
	sprintf(temp,"O%d:\n",outcount);
	strcat(str,temp);
	labelcount++;
	outcount++;
	return str;
}

char *generate_code_for_op(char *str,int no){
	char temp[1000];
	if(strcmp(str,"+") == 0){
		sprintf(temp,"ADD $t%d,$t%d\n",no+1,no+2);
	}
	if(strcmp(str,"-") == 0){
		sprintf(temp,"SUB $t%d,$t%d\n",no+1,no+2);
	}
	if(strcmp(str,"*") == 0){
		sprintf(temp,"MUL $t%d,$t%d\n",no+1,no+2);
	}
	if(strcmp(str,"/") == 0){
		sprintf(temp,"DIV $t%d,$t%d\n",no+1,no+2);
	}
	return temp;
}

char *generate_expression_code(nodeType *root,int no){
	char str[1000];
	if(root->typo == 2 && strcmp(root->val.sname,"=") == 0){
		strcpy(str,generate_expression_code(root->right,no));
		
		char temp[1000];
		strcpy(temp,"MOVE ");
		strcat(temp,root->left->sym_ptr->symbol_name);
		strcat(temp,",$t0\n");
		strcat(str,temp);
		return str;
	}
	else{
		if(root->typo == 2){
			strcpy(str,generate_expression_code(root->left,no));
			strcat(str,generate_expression_code(root->right,no+1));
			strcat(str,generate_code_for_op(root->val.sname,no));
			return str;
		}
		else if(root->typo == 0){
			switch(root->datatype){
				case 1:	sprintf(str,"MOVE $t%d,%d\n",no+1,root->val.ival);
								break;
				case 2:	sprintf(str,"MOVE $t%d,%c\n",no+1,root->val.cval);
								break;
				case 3:	sprintf(str,"MOVE $t%d,%s\n",no+1,root->val.sval);
								break;
			}
			return str;
		}
		else{
			sprintf(str,"MOVE $t%d,%s\n",no+1,root->sym_ptr->symbol_name);
			return str;
		}
	}
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

