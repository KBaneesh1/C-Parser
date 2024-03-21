%{
    #include <stdio.h>
    #include <stdlib.h>
        int yylex(void);
        int yyerror(const char *msg);
        extern int yylineno;
        extern char *yytext;
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
        // |for_loop     {printf(" valid for loop\n");}
        |do_while_loop stmt  {printf("valid do while loop\n");}
        |
        ;


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
        | T
        ;

T : T '*' R 
  | T '/' R 
  | R 
  ;

R : R RELOP F 
   | R LOGOP F 
   | F

F : '('Expression')' 
  | ID 
  | NUM
  | CHARACTER
  ;
          

if_loop: IF '(' condition ')' next_part_if
       ;

next_part_if : '{'stmt'}' else_part
        | stmt
        ;
else_part : ELSE '{'stmt'}'
          | ELSE if_loop
          | /* Empty */
          ;

condition: Expression
        | Assgn
        ;


while_loop : WHILE '('Expression ')' next_while_part 
        ;

next_while_part : '{'stmt'}'
        | stmt
        ;
// loop_stmt :  '{'stmt'}'
// //            | Assign ';'
//            |
           ;

do_while_loop : DO '{'stmt'}' WHILE '('condition')'
        ;

// for_declr : Type for_assign
//         ;

// for_assign : ID ',' for_assign | ID
//         ;

// for_loop : FOR '('for_declr';'Expression';'incr ')' loop_stmt

/* TO IMPlement , 
 1.Switch case 
2. Short hand notations 
 */
%%
// void noyywrap();

int yyerror(const char *msg) {
    printf("Error:%s, line number:%d, token:%s\n", msg, yylineno, yytext);
    return 0;
}
int main(){

        yyparse();
        return 0;
}
