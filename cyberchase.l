%{

    /* aqui importa funções básicas de entrada e saída, 
    alocação e manipulação de strings */

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    /* o Lex usa yyin como o arquivo de entrada 
    (onde está o código-fonte que o compilador vai ler) */

    extern FILE *yyin;

    int line = 1;

%}

%x COMMENT

    /* ANALISADOR LÉXICO - AP1-N1 */

    /* expressões regulares */

DIGITO      [0-9]+\.?[0-9]*
VARIAVEL    [A-Za-z_]+
TEXTO       \".*\"
ESPACOS     [ \n\t\r]

%%
{ESPACOS}+  { }
\n          { line++; }

    /* marcadores de início e fim do programa */

"inicio"    { return INICIO; }
"fim"       { return FIM;    } 

    /* formas de comentários da linguagem */

%.*             { /* comentário de linha */ }
"<%"             { BEGIN(COMMENT); } 
<COMMENT>"%>"   { BEGIN(INITIAL); } 
<COMMENT>\n     { line++;         }
<COMMENT>.      { /* ignora dentro do comentário */ }

    /* operadores lógicos */

">="        { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"<="        { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"=="        { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"!="        { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"or"        { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"and"       { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
">"         { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"<"         { printf("OPERADOR_LOGICO:                  %s\n", yytext); }
"!"         { printf("OPERADOR_LOGICO:                  %s\n", yytext); }

    /* operadores de atribuição */

"->"        { return IGUAL;       }
"++"        { return INCREMENTAR; }
"--"        { return DECREMENTAR; }

    /* operadores aritméticos */

"+"         { return '+'; }
"*"         { return '*'; }
"-"         { return '-'; }
"/"         { return '/'; }

    /* operadores de leitura e escrita */

"ler"        { return LER;      }
"escrever"   { return ESCREVER; }

    /* estruturas condicionais */

"se"      { printf("PALAVRA_RESERVADA_CONDICIONAL:    %s\n", yytext); }
"senao"   { printf("PALAVRA_RESERVADA_CONDICIONAL:    %s\n", yytext); } 
"caso"    { printf("PALAVRA_RESERVADA_CONDICIONAL:    %s\n", yytext); } 
"escolha" { printf("PALAVRA_RESERVADA_CONDICIONAL:    %s\n", yytext); } 

    /* estruturas de repetição */

"para"       { printf("PALAVRA_RESERVADA_REPETIÇÃO:      %s\n", yytext); }
"enquanto"   { printf("PALAVRA_RESERVADA_REPETIÇÃO:      %s\n", yytext); }
"faca"       { printf("PALAVRA_RESERVADA_REPETIÇÃO:      %s\n", yytext); }

    /* delimitadores */

"("         { return '('; }
")"         { return ')'; }
"{"         { return '{'; }
"}"         { return '}'; }
"["         { return '['; }
"]"         { return ']'; }

    /* palavras reservadas */

"retorne"    { printf("RETURN:                           %s\n", yytext); }
"int"        { return TIPO_INT;                                          }
"float"      { return TIPO_FLOAT;                                        }
"char"       { printf("TIPO_CHAR:                        %s\n", yytext); }
"string"     { printf("TIPO_STRING:                      %s\n", yytext); }
"bool"       { printf("TIPO_BOOLEAN:                     %s\n", yytext); }
"verdadeiro" { printf("TRUE_BOOLEAN:                     %s\n", yytext); }
"falso"      { printf("FALSE_BOOLEAN:                    %s\n", yytext); }

    /* caracteres especiais */

","         { return ',';  }
";"         { return ';';  }
"\""        { printf("CARACTERE_ESPECIAL:               %s\n", yytext); }
"'"         { printf("CARACTERE_ESPECIAL:               %s\n", yytext); }

    /* identificadores */

{VARIAVEL}({VARIAVEL}|{DIGITO})* {
                                    // reconhece nomes de variáveis
                                    yylval.integer = *yytext - 'a';
                                    return VARIAVEL;
                                 }
{DIGITO}                         {
                                    // reconhece números reais
                                    yylval.real = atof(yytext);
                                    return DIGITO;
                                 }
{TEXTO}                           {
                                    // copia o texto entre aspas para o valor do token TEXTO.
                                    strcpy(yylval.string, yytext);
                                    return TEXTO;
                                 }

    /* erro léxico */
    
.           { printf("ERRO: Caractere não reconhecido '%s' na linha %d\n", yytext, line); }
%%