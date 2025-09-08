% Programa de teste para a linguagem BadBunny

<%
Este é um teste completo para o analisador léxico.
Inclui todas as palavras-chave, operadores e literais definidos.
O objetivo é garantir que cada token seja reconhecido corretamente.
%>

se (verdadeiro) {
    int numero_inteiro -> 42;
    float numero_decimal -> 3.1415;
    string minha_string -> "Olá, Mundo!";
    char meu_caractere -> 'B';
    bool status_ativo -> verdadeiro;

    escreva("Iniciando a análise...\n");
    escreva(minha_string, " Linha 12.");
} senao {
    escreva("O programa não deve entrar aqui.");
}
retorne 0;

% Teste de operadores
int a -> 10;
int b -> 5;

escreva("Operações aritméticas:");
int soma -> a + b;
int subtracao -> a - b;
int multiplicacao -> a * b;
float divisao -> a / b;

escreva("Operações de atribuição:");
a += 5;
b -= 2;

se (a > b e soma == 15) {
escreva("Operadores lógicos funcionam!");
}

% Teste de loop 'enquanto'
int contador -> 0;
enquanto (contador < 5) {
    escreva("Contador: ", contador);
    contador -> contador + 1;
}

faca {
    leia(variavel_leitura);
} enquanto (variavel_leitura != 10);

% Teste de estruturas aninhadas
se (10 >= 10) {
    se (20 != 15) {
    escreva("Tudo ok!");
    }
}

% Teste de escolha
int opcao_menu -> 2;
escolha (opcao_menu) {
    opcao 1:
    escreva("Opção 1 selecionada.");
    opcao 2:
    escreva("Opção 2 selecionada.");
}