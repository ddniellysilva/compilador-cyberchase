all: cyberchase.l cyberchase.y
	flex -i cyberchase.l
	bison cyberchase.y
	gcc cyberchase.tab.c -o cyberchase -lfl
	./cyberchase codigofonte.cyber
clean:
	rm -f cyberchase cyberchase.tab.c lex.yy.c