all: badbunny.l
	@echo "* Iniciando o processo de compilação *"
	flex -i badbunny.l
	gcc lex.yy.c -o badbunny -lfl
	./badbunny main.bb
	@echo "* Fim do processo de compilação *"