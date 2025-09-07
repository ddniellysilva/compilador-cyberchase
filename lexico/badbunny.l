%{
	//definições,funções... (código C)
%}

/*expressões regulares (definições regulares(GALS))*/

NUM [0-9]+
LETRA [A-Za-z]+
SIMB [-+*/=]
IGNORE [ \n\t]

%%

	/*tokens*/

"FIM" {
	printf("Fim do programa\n");
	}

"INICIO" {
	printf("Início do programa\n");
	}

{NUM} {
	printf("Número: %s\n",yytext);
	}
	
{SIMB} {
	printf("Operação: %s\n",yytext);
	}

{LETRA}({LETRA}|{NUM})* {
	printf("Variável: %s\n",yytext);
	}
	
{IGNORE} {
	//printf("Caractere ignorado\n");
	}
%%

/*definições*/

int main(){
	yyin=fopen("main.bb","r"); //abre o código fonte
	yylex();	//chama o analizador léxico
	fclose(yyin); //fecha o código fonte
return 0;
}