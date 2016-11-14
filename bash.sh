lex lex.l
yacc -d lang.y
gcc -g -w lex.yy.c y.tab.c -ll 

 
