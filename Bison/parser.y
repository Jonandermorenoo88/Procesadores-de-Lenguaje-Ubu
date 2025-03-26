%{
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYDEBUG 1
extern int yydebug;


void yyerror(const char *s); // Declaración de yyerror
int yylex();
int labelCounter = 0;
%}

%union {
  int num;       // Para valores numéricos
  char *id;      // Para identificadores y cadenas
}

%token PROGRAM TOKENBEGIN END MOVE ADD SUBTRACT MULTIPLY DIVIDE DISPLAY ACCEPT WHILE VARYING FROM TO BY IF THEN GIVING ELSE IS NOT GREATER LESS EQUAL THAN DO PUNTO
%token <num> NUM
%token <id> ID
%token <id> CAD

%type <num> expr mult val booleanExpr
%type <id> literal io

%left '+' '-'
%left '*' '/'

%left IS
%left GREATER LESS EQUAL
%left THAN

%%
program:
    {printf("1\n");}
    PROGRAM {printf("2\n");} ID {printf("3\n");} PUNTO {printf("4\n");} TOKENBEGIN {printf("5\n");} stmts {printf("6\n");} END {
    }
;

stmts:
    stmt
    |stmts stmt
;

stmt:
    io PUNTO 
    | loop PUNTO
    | cond PUNTO
    | assig PUNTO
;

io:
    DISPLAY literal ',' {                  
    }
    | ACCEPT ID {            
    }
;

literal:
    ID {       
    }
    | NUM {          
    }
    | CAD {         
    }
;

loop:
    WHILE booleanExpr DO stmts END {
    }
    | VARYING ID TO atomic DO stmts END {
    }
    | VARYING ID  FROM atomic TO atomic BY atomic DO stmts END{
    }
;

cond:
    IF booleanExpr THEN stmts END{
    }
    |IF booleanExpr THEN stmts ELSE stmts END {
    }
;

atomic:
    ID
    | NUM
    | CAD
;

assig:
    MOVE expr TO ID {
    }
    | ADD expr TO ID {
    }
    | SUBTRACT expr FROM ID {
    }
    | MULTIPLY expr BY expr GIVING ID {
    }
    | DIVIDE expr BY expr GIVING ID {
    }
;


expr:
    mult '+' expr {
    }
    | mult '-' expr {
    }
    | mult {
    }
;

mult:
    val '*' mult {
    }
    | val '/' mult {
    }
    | val {
    }
;

val:
    ID {
    }
    | NUM {
    }
    | '(' expr ')' {
    }
;


booleanExpr:
    expr IS GREATER THAN expr {
    }
    | expr IS LESS THAN expr {
    }
    | expr IS EQUAL TO expr {
    }
    | expr IS NOT GREATER THAN expr {
    }
    | expr IS NOT LESS THAN expr {
    }
    | expr IS NOT EQUAL TO expr {
    }
    | expr IS GREATER THAN expr IS LESS THAN expr {
    }
;


%%
int main(int argc, char **argv) {
    if (argc > 1) {
        extern FILE *yyin;
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            fprintf(stderr, "Error al abrir el archivo %s\n", argv[1]);
            return 1;
        }
        yyparse(); 
        fclose(yyin);
    } else {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }
    return 0;
}

void yyerror(const char *s) {
    extern int yylineno;
    fprintf(stderr, "Error de sintaxis en la línea %d: %s\n", yylineno, s);
}
