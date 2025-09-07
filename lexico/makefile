all: badbunny.l
	clear
	flex -i badbunny.l
	gcc lex.yy.c -o badbunny -lfl
	./badbunny