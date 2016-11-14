.PHONY: all clean

all:
	lex lex.l
	yacc -d lang.y
	gcc -g -w lex.yy.c y.tab.c -ll 



 clean:
	rm lex.yy.c y.tab.c y.tab.h a.out


