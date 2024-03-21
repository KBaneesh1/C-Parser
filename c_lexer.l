%{
    //C dec1
    #include<stdio.h>
    #include "y.tab.h"
    int yylineno;
%}
digit [0-9]+
opFraction "."{digit} 
opExponent [eE][+-]?{digit}
number {digit}{opFraction}?{opExponent}?


%%

main return MAIN;
int return INT;
float return FLOAT;
char return CHAR;
double return DOUBLE;
if return IF;
else return ELSE;
while return WHILE;
for return FOR;
do return DO;
swtich return SWITCH;
case return CASE;
break return BREAK;
default return DEFAULT;


[a-zA-Z_][a-zA-Z0-9_]* return ID;

{number} return NUM;
"<="|"=="|">="|"!="|">"|"<" return RELOP;
"||"|"&&" return LOGOP;
"++"|"--" return INC_DEC;
"+="|"-="|"*="|"/=" return SHN;
"#include"[ ]<[a-zA-Z_][A-Za-z0-9_]*\.h> return HEADER;
"//".*    ;
[ \t]+   ;
\n   ;    { ++yylineno; }
'.'  return CHARACTER;
"/*"[^*]*(\*[^/]*)*"*/"  ;
.  {return *yytext;}

%%

int yywrap() {
    return 1;
}


