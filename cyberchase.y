%{
  #include<stdio.h>
  float variaveis[26];

  int yylex(); // função do analisador léxico que envia os tokens pra cá
  void yyerror (char *s){
    printf ("ERROR: %s\n",s);
  }
%}

%union {
  // define o tipo de dado que os tokens podem carregar
  int integer;
  char string[100];
  float real;
}

%token INICIO FIM;
%token LER ESCREVER;
%token TIPO_INT TIPO_FLOAT;
%token <real> DIGITO;
%token <integer> VARIAVEL;
%token <string> TEXTO;
%token IGUAL INCREMENTAR DECREMENTAR;

%type <real> EXPRESSOES;

%left '+' '-'   // ordem de precedência
%left '*' '/'   // das operações matemáticas

%%

program: INICIO start FIM;

start: lista_de_comandos start | lista_de_comandos ;

tipo:             // regra de tipo para deixar o código mais legível e limpo 
    TIPO_INT      // obs.: como ajustar para o compilador diferenciar tipos?
  | TIPO_FLOAT
;

lista_de_comandos:                                                 // FORMATOS DE DECLARAÇÃO E ATRIBUIÇÃO:
    tipo novas_variaveis ';'                                       // int a, b, c;
  | VARIAVEL IGUAL EXPRESSOES ';'        { variaveis[$1] = $3;  }  // a -> 10;
  | VARIAVEL INCREMENTAR DIGITO ';'      { variaveis[$1] += $3; }  // a ++ 5;
  | VARIAVEL DECREMENTAR DIGITO ';'      { variaveis[$1] -= $3; }  // a -- 5;
  | tipo VARIAVEL IGUAL EXPRESSOES ';'   { variaveis[$2] = $4;  }  // int a -> 10;
  | tipo VARIAVEL INCREMENTAR DIGITO ';' { variaveis[$2] += $4; }  // int a ++ 5;
  | tipo VARIAVEL DECREMENTAR DIGITO ';' { variaveis[$2] -= $4; }  // int a -- 5;

  | ESCREVER '(' opcoes ')' ';' // escrever(<opcoes>);
  | LER '(' VARIAVEL ')' ';' { scanf("%f", &variaveis[$3]); } // ler(variavel);
  ;

opcoes:
    opcoes ',' EXPRESSOES  { printf("%.2f\n", $3); } 
  | EXPRESSOES             { printf("%.2f\n", $1); }
  | opcoes ',' TEXTO       { printf("%s\n", $3);   }
  | TEXTO                  { printf("%s\n", $1);   }
  ;

novas_variaveis:
    VARIAVEL               
  | novas_variaveis ',' VARIAVEL
  ;

EXPRESSOES: EXPRESSOES '+' EXPRESSOES {$$ = $1 + $3;}
          | EXPRESSOES '*' EXPRESSOES {$$ = $1 * $3;}
          | EXPRESSOES '-' EXPRESSOES {$$ = $1 - $3;}
          | EXPRESSOES '/' EXPRESSOES {$$ = $1 / $3;}
          | '(' EXPRESSOES ')'        {$$ = $2;}
          | DIGITO                    {$$ = $1;}
          | VARIAVEL                  {$$ = variaveis[$1];}
          ;
%%
#include <stdio.h>
#include "lex.yy.c"

// função auxiliar para abrir o arquivo
FILE* abrir_arquivo(const char *nome_arquivo) {
    FILE *arquivo = fopen(nome_arquivo, "r");
    if (!arquivo) {
        fprintf(stderr, "Erro ao abrir o arquivo: %s\n", nome_arquivo);
        return NULL;
    }
    return arquivo;
}

int main(int argc, char *argv[]) {
    FILE *arquivo = NULL;

    if (argc > 1) {
        // se o usuário passou o nome do arquivo como argumento
        arquivo = abrir_arquivo(argv[1]);
        if (!arquivo) return 1;

        yyin = arquivo; // define o arquivo de entrada do Flex
        printf("\n🔍 INICIANDO ANÁLISE LÉXICA E SINTÁTICA: %s\n\n", argv[1]);
    } else {
        // caso o usuário digite o código direto no terminal
        printf("ANÁLISE SINTÁTICA \n");
        printf("DIGITE SEU CÓDIGO: \n");
        
        yyin = stdin; // lê da entrada padrão
    }

    // inicia o processo de análise
    if (yyparse() == 0) {
        printf("\n ANÁLISE CONCLUÍDA COM SUCESSO \n");
    } else {
        printf("\n OCORREU UM ERRO DURANTE A ANÁLISE \n");
    }

    // fecha o arquivo, se houver
    if (arquivo) fclose(arquivo);

    return 0;
}