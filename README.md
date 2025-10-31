<h1 align="center">Cyberchase | Compilador</h1>

<img align='center' src="https://www.90sdvds.com/images/Cyberchase.png" alt="Cyberchase">


<p align="center">Projeto da disciplina de Compiladores (2025.2) do Bacharelado em Ciência da Computação do IFCE</p>

## 💾 Sobre o projeto:

Inspirado no desenho "Cyberchase: a corrida do espaço", o Cyberchase Compilador é um compilador simples desenvolvido como parte da disciplina de Compiladores. Até o momento, ele implementa um analisador léxico e sintático para a linguagem customizada Cyberchase.

O compilador processa um código-fonte (.cyber), realiza a análise e, em seguida, executa os comandos, incluindo leitura de entrada e impressão de resultados.

## 🗃️ Estrutura do projeto:

```
.
├── .gitignore             # arquivos ignorados pelo git (arquivos gerados)
├── cyberchase.l           # definição das regras léxicas (tokens)
├── cyberchase.y           # definição da gramática e ações semânticas
├── codigofonte.cyber      # exemplo de código-fonte na linguagem Cyberchase
└── makefile               # script para automatizar a compilação
```

### Analisador léxico - ```cyberchase.l```:

O arquivo ```cyberchase.l``` é um código de analisador léxico escrito em Lex (ou Flex) — uma ferramenta que lê o código-fonte da sua linguagem e o divide em tokens, ou seja, pedaços significativos como palavras reservadas, operadores, variáveis, números etc.

O Lex trabalha em três partes principais, separadas por %%:

1. Declarações e código C inicial;
2. Regras léxicas;
3. Código auxiliar (C).

| Categoria                    | Símbolo / Palavra                        | Descrição / Função                       | Token / Ação                                 |
| ---------------------------- | ---------------------------------------- | ---------------------------------------- | -------------------------------------------- |
| **Marcadores de Programa**   | `inicio` / `fim`                         | Início e fim do código                   | `INICIO`, `FIM`                              |
| **Comentário**               | `% ...`                                  | Comentário de linha                      | Ignorado                                     |
|                              | `<% ... %>`                              | Comentário de bloco                      | Ignorado                                     |
| **Operadores Lógicos**       | `>`, `<`, `>=`, `<=`, `==`, `!=`         | Comparações entre valores                | `OPERADOR_LOGICO`                            |
|                              | `and`, `or`, `!`                         | Operadores lógicos booleanos             | `OPERADOR_LOGICO`                            |
| **Operadores Aritméticos**   | `+`, `-`, `*`, `/`                       | Soma, subtração, multiplicação e divisão | `'+'`, `'-'`, `'*'`, `'/'`                   |
| **Operadores de Atribuição** | `->`                                     | Atribuição de valor a variável           | `IGUAL`                                      |
|                              | `++`, `--`                               | Incremento e decremento                  | `INCREMENTAR`, `DECREMENTAR`                 |
| **Entrada / Saída**          | `ler`, `escrever`                        | Leitura e escrita de variáveis           | `LER`, `ESCREVER`                            |
| **Estruturas Condicionais**  | `se`, `senao`, `caso`, `escolha`         | Estruturas de decisão                    | Impressão de `PALAVRA_RESERVADA_CONDICIONAL` |
| **Estruturas de Repetição**  | `para`, `enquanto`, `faca`               | Estruturas de loop                       | Impressão de `PALAVRA_RESERVADA_REPETIÇÃO`   |
| **Tipos de Dados**           | `int`, `float`, `char`, `string`, `bool` | Declaração de tipos                      | `TIPO_INT`, `TIPO_FLOAT`, etc.               |
| **Booleanos**                | `verdadeiro`, `falso`                    | Constantes booleanas                     | `TRUE_BOOLEAN`, `FALSE_BOOLEAN`              |
| **Delimitadores**            | `(`, `)`, `{`, `}`, `[`, `]`             | Agrupamento e escopo                     | Retorna o próprio símbolo                    |
| **Separadores**              | `,`, `;`                                 | Lista de variáveis / fim de instrução    | Retorna o próprio símbolo                    |
| **Caracteres Especiais**     | `'`, `"`                                 | Aspas simples e duplas                   | Apenas impressos                             |
| **Identificadores**          | `[A-Za-z_]+`                             | Nome de variável                         | `VARIAVEL`                                   |
| **Números**                  | `[0-9]+\.?[0-9]*`                        | Números inteiros ou reais                | `DIGITO`                                     |
| **Texto**                    | `"..."`                                  | Cadeia de caracteres                     | `TEXTO`                                      |
| **Erro Léxico**              | Qualquer outro símbolo                   | Caractere inválido                       | Mensagem de erro                             |

### Analisador sintático - ```cyberchase.y```:

O Yacc/Bison é o “parceiro” do Lex/Flex. Enquanto o Lex reconhece as palavras (tokens) do código-fonte, o Yacc organiza essas palavras em estruturas gramaticais, ou seja, verifica se a sequência faz sentido — como se fosse a parte de gramática e lógica da linguagem. Dessa forma:

* O Lex identifica tokens (ex: TIPO_INT, VARIAVEL, IGUAL, DIGITO);
* O Yacc usa esses tokens para entender as regras de como o programa deve ser estruturado.

## 💽 Requisitos para execução (Windows):

* WSL;
* Compilador C;
* Flex;
* Bison;

## 💻 Instalação e execução (Windows):

1. Clone este repositório ```git clone https://github.com/ddniellysilva/compilador-cyberchase.git``` ou faça o download dos arquivos;
2. Abra o projeto na IDE de sua preferência;
3. No terminal, ative o WSL com o comando ```wsl```;
4. Compile o projeto com o comando ```make all```.