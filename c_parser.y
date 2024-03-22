%{
    #include<stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include<ctype.h>
    
    extern int yylineno;
    extern char *yytext;
    int yyerrstatus =0;
    void yyerror(const char *s);
    int yylex();
    int yywrap();
%}


%token INT CHAR FLOAT DOUBLE NUM ID IF ELSE  WHILE FOR RELOP LOGOP DO
%token SWITCH CASE BREAK DEFAULT INC_DEC SHN HEADER INCLUDE MAIN CHARACTER

%%

Start : Prog  {printf("valid everything\n");}


Prog : HEADER Prog
    |Main_func Prog
    |Declr ';' Prog
    |Assgn ';' Prog
    |
    ;

Main_func : Type MAIN '('Multi_func_declr')' '{'stmt'}'


Multi_func_declr : Type ID next
                |
                ;
next : multi_arr ',' Multi_func_declr 
        | ',' Multi_func_declr 
        ;

// seq_stmts: stmt seq_stmts
//         |stmt
        // ;
    stmt: Assgn ';' stmt  {printf("valid assignment\n");}
        |Declr ';' stmt   {printf("valid declaration\n");}
        |if_loop stmt     {printf("valid if else \n");}
        |while_loop stmt  {printf("valid while loopt\n");}
        |for_loop     {printf(" valid for loop\n");}
        |do_while_loop stmt  {printf("valid do while loop\n");}
        |switch_case stmt   {printf("valid switch case\n");}
        |
        ;

    one_line : Assgn ';'
             | Declr ';'
             | if_loop
             | while_loop
             | for_loop

Declr : Type ListVar
      ;
      
ListVar :  common_case ',' ListVar | common_case
        ;

Type : INT | FLOAT | DOUBLE | CHAR
     ;

common_case : Assgn | Arr_declr | Array_init | ID
        ;

Arr_declr : ID multi_arr 
        ;

Array_init : ID multi_arr '=' '{'Multi_expr'}'
        ;

multi_arr : '['inisde_arr ']' multi_arr | '[' inisde_arr']'
        ;

inisde_arr : NUM 
        | ID
        |
        ;

Assgn : Assign | Array_assign 
      ;
        
Assign : ID '=' Expression
        ;

Array_assign : ID multi_arr '=' Expression
        ;

Multi_expr : Expression ',' Multi_expr | Expression
        ;


Expression : Expression '+' T 
        | Expression '-' T 
        | Expression SHN T 
        | ID INC_DEC
        | T
        ;

T : T '*' R 
  | T '/' R 
  | R 
  ;

R: R RELOP F 
   | R LOGOP F
   | F
   ;

F : '('Expression')' 
  | ID 
  | NUM
  | CHARACTER
  ;



if_loop: IF '(' condition ')' if_stmt
       ;

if_stmt : '{'stmt'}' else_part
        | one_line else_part
        ;
else_part : ELSE loop_stmt
          | 
          ;

condition: Expression
        | Assgn
        ;


while_loop : WHILE '('Expression')' loop_stmt 
        ;

loop_stmt : '{'stmt'}'
        | one_line
        ;


do_while_loop : DO '{'stmt'}' WHILE '('condition')'
        ;

for_loop : FOR '('stmt';'Expression';'stmt')' loop_stmt

switch_case : SWITCH '('Expression')' '{'cases'}'
            ;

cases :  CASE Expression ':' next_case BREAK ';' cases
      |  DEFAULT ':' next_case BREAK ';'
      |
      ;

next_case : '{'stmt'}'
        | one_line
        ;

/* TO IMPlement , 
1. Short hand notations 
 */
%%
// void noyywrap();

void yyerror(const char* msg) {
    static int panic_count = 0; 
    fprintf(stderr, "Error: %s, line number: %d, token: %s\n", msg, yylineno, yytext);
//     if(panic_count>5)
// //     return;

    while (1) {
        int token = yylex();
        if (token == ';' || token == '}' || token == ')') {
            yyerrok; 
            panic_count++;
            yyparse(); 
            break;
        }
        else if(token == 0)
        {
            return;
        }
    }
}
int main(){

        yyparse();
        return 0;
}
