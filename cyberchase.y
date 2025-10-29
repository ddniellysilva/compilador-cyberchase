%{
  #include<stdio.h>
  int variaveis[26];

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
%token TIPO_INT;
%token <real> DIGITO;
%token <integer> VARIAVEL;
%token <string> TEXTO;
%token IGUAL INCREMENTAR DECREMENTAR;

%left '+' '-'   // ordem de precedência
%left '*' '/'   // das operações matemáticas

%type <real> EXPRESSOES;

%%

program: INICIO start FIM;

start: lista_de_comandos start | lista_de_comandos ;

lista_de_comandos:                                                    // FORMATOS DE DECLARAÇÃO E ATRIBUIÇÃO:
    TIPO_INT novas_variaveis ';'                                      // int a, b, c;
  | VARIAVEL IGUAL EXPRESSOES ';'            { variaveis[$1] = $3;  } // a -> 10;
  | VARIAVEL INCREMENTAR DIGITO ';'          { variaveis[$1] += $3; } // a ++ 5;
  | VARIAVEL DECREMENTAR DIGITO ';'          { variaveis[$1] -= $3; } // a -- 5;
  | TIPO_INT VARIAVEL IGUAL EXPRESSOES ';'   { variaveis[$2] = $4;  } // int a -> 10;
  | TIPO_INT VARIAVEL INCREMENTAR DIGITO ';' { variaveis[$2] += $4; } // int a ++ 5;
  | TIPO_INT VARIAVEL DECREMENTAR DIGITO ';' { variaveis[$2] -= $4; } // int a -- 5;

  | ESCREVER '(' opcoes ')' ';' // escrever(<opcoes>);
  | LER '(' VARIAVEL ')' ';' { scanf("%d", &variaveis[$3]); } // ler(variavel);
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
#include "lex.yy.c"

int main(int argc, char *argv[]){
  FILE *arquivo;
  if (argc > 1) {
      arquivo = fopen(argv[1], "r");
      if (!arquivo) {
          printf("Ocorreu um erro ao abrir o arquivo %s\n", argv[1]);
          return 1;
      }
      yyin = arquivo;
      printf("\t ANÁLISE LÉXICA E SINTÁTICA - %s \t\n\n", argv[1]);
  } else {
      printf("=== Analise Sintática (entrada padrao) ===\n");
      printf("Digite o codigo (Ctrl+D para finalizar):\n\n");
  }

  yyparse();

  yylex();

  if (argc > 1) fclose(arquivo);

  printf("\t ANÁLISES CONCLUÍDAS COM SUCESSO \n");
  return 0;
}