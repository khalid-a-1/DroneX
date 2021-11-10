parser: y.tab.c lex.yy.c
	gcc -o parser y.tab.c
y.tab.c: droneX.yacc lex.yy.c
	yacc droneX.yacc
lex.yy.c: droneX.lex
	lex droneX.lex
clean:
	rm -f lex.yy.c y.tab.c out
