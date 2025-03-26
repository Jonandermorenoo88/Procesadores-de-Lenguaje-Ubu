%{
#include "y.tab.h"
#include <string.h>
%}

%option noyywrap

%%
"ADD"             { return ADD; }
"SUBTRACT"        { return SUBTRACT; }
"MULTIPLY"        { return MULTIPLY; }
"DIVIDE"          { return DIVIDE; }
"GREATER"         { return GREATER; }
"LESS"            { return LESS; }
"EQUAL"           { return EQUAL; }
"PROGRAM"         { return PROGRAM; }
"BEGIN"           { return TOKENBEGIN; }
"END"             { return END; }
"DISPLAY"         { return DISPLAY; }
"ACCEPT"          { return ACCEPT; }
"WHILE"           { return WHILE; }
"VARYING"         { return VARYING; }
"FROM"            { return FROM; }
"TO"              { return TO; }
"BY"              { return BY; }
"IF"              { return IF; }
"THEN"            { return THEN; }
"ELSE"            { return ELSE; }
"IS"              { return IS; }
"GIVING"          { return GIVING; }
"NOT"             { return NOT; }
"DO"              { return DO; }
"."               { return PUNTO; } 

[ \t]*\*>[^\r\n]*        ;
[ \t]*\*[^\r\n]*        ;
"*>".*              ; 
[ \t\n\r]+          ;
(\"[A-Za-z ]*\"|\'[A-Za-z ]*\')  { yylval.id = strdup(yytext); return CAD; }
[A-Za-z]([A-Za-z0-9-])*  { yylval.id = strdup(yytext); return ID; }
[0-9]+            { yylval.num = atoi(yytext); return NUM; }
%%

