lex lex.l
yacc -d lang.y
gcc -w lex.yy.c y.tab.c -ll 
 