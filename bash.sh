lex lex.l
yacc -d lang.y
gcc lex.yy.c y.tab.c -ll
