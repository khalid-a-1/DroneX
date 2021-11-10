%{ int yylex(void); extern int yylineno; %}

%token MAIN
%token LP
%token RP
%token LB
%token RB
%token GREATERTHAN
%token GREATEROREQUAL
%token LESSTHAN
%token LESSOREQUAL
%token EQUAL
%token NOTEQUAL
%token ASSIGNMENT_OP
%token OR
%token AND
%token WHILE
%token FOR
%token ELSEIF
%token IF
%token ELSE
%token COMMENT_LINE
%token COMMENT_MULTI_LINE
%token CONSTANT
%token DOT
%token FUNCTION
%token READALTITUDE
%token READTEMPERATURE
%token READACCELERATION
%token TURNONCAMERA
%token TURNOFFCAMERA
%token TAKEPICTURE
%token READTIMESTAMP
%token CONNECTTOBASE
%token IDENTIFIER
%token NUMBER
%token STRING
%token FLOAT
%token INTEGER
%token BOOLEAN
%token RETURN
%token PRINT
%token INPUT
%token FUNCTION
%token CONNECT
%token DISCONNECT
%token RECEIVE
%token COMMA
%token NOT
%token TO
%token ENDSTMT
%token FUNCTION_START
%token FUNCTION_RETURN
%token FUNCTION_CALL
%token PLUS
%token MINUS
%token MULTIPLICATION
%token DIVISION
%token MODULUS;


%start program

%%

program:	main;

main:		LP RP LB statements RB;

statements:	stmt
		| stmt statements
		;

stmt:		loops
		| cond_stmt
		| comments
		| assign_st ENDSTMT
		| expr ENDSTMT
		| connection_stmt ENDSTMT
		| function_declaration ENDSTMT
		| function_call ENDSTMT
		| function_return ENDSTMT
		| print ENDSTMT
		| ENDSTMT
		;

comments:	 COMMENT_LINE
       		 | COMMENT_MULTI_LINE
       		 ;

assign_st: 	IDENTIFIER ASSIGNMENT_OP const
		  | IDENTIFIER ASSIGNMENT_OP IDENTIFIER
		  | IDENTIFIER ASSIGNMENT_OP expr
		  | IDENTIFIER ASSIGNMENT_OP logic_expr
		  | IDENTIFIER ASSIGNMENT_OP function_call
		  | IDENTIFIER ASSIGNMENT_OP input
		  | IDENTIFIER ASSIGNMENT_OP functions
		;

loops: 		while_loop
		| for_loop
		;

while_loop:	WHILE LP logic_expr RP LB statements RB
		;

for_loop:	FOR LP IDENTIFIER ASSIGNMENT_OP NUMBER TO NUMBER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP NUMBER TO IDENTIFIER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP IDENTIFIER TO NUMBER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP IDENTIFIER TO IDENTIFIER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP IDENTIFIER TO expr ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP expr TO IDENTIFIER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP NUMBER TO expr ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP expr TO NUMBER ENDSTMT RP LB statements RB
          	| FOR LP IDENTIFIER ASSIGNMENT_OP expr TO expr ENDSTMT RP LB statements RB

cond_stmt:	if_stmt;

if_stmt:	  IF LP logic_expr RP LB statements RB ELSE LB statements RB
	        | IF LP logic_expr RP LB statements RB
		;

function_call:    FUNCTION_CALL RP
            	| FUNCTION_CALL multi_params RP
            	;

function_declaration: FUNCTION_START LP RP LB statements RB
                    | FUNCTION_START LP multi_params RP LB statements RB
                    ;

function_return: FUNCTION_RETURN expr
                | FUNCTION_RETURN logic_expr
                | FUNCTION_RETURN const
                | FUNCTION_RETURN IDENTIFIER
                ;

multi_params: IDENTIFIER
            | const
	    | IP
            | IDENTIFIER COMMA multi_params
            | const COMMA multi_params
            ;

print:  PRINT const RP
      | PRINT IDENTIFIER RP
      | PRINT expr RP
      | PRINT logic_expr RP
      ;

input: INPUT RP
      | INPUT STRING RP
      ;

expr: expr_base
    | expr_base op operand
    ;


expr_base: operand op LP expr_base RP
    | operand op operand
    | LP expr_base RP
    | expr_base op operand op operand
    | expr_base op LP expr_base RP
    ;

logic_expr:	 operand comparison_op operand
          	| LP logic_expr RP
          	| logic_expr boolean_op operand comparison_op operand
          	| logic_expr boolean_op LP operand comparison_op operand RP
          	;

functions:	  READALTITUDE
		  | READTEMPERATURE
		  | READACCELERATION
		  | TURNONCAMERA
		  | TURNOFFCAMERA
		  | TAKEPICTURE
		  | READTIMESTAMP
		  | CONNECTTOBASE
		;

operand: IDENTIFIER | const | function_call | functions;

connection_stmt:  receive_IP
		  | IDENTIFIER comparison_op IP CONNECT
		  | IDENTIFIER comparison_op IP DISCONNECT
		;

receive_IP: 	  IDENTIFIER RECEIVE IP;

arithmetic_op: PLUS | MINUS | MULTIPLICATION | DIVISION | MODULUS;

comparison_op: LESSTHAN | GREATERTHAN | LESSOREQUAL | GREATEROREQUAL | EQUAL | NOTEQUAL;

boolean_op: 	AND | OR | NOT;

const:		 NUMBER | STRING | FLOAT | BOOLEAN;

IP: 		  IDENTIFIER DOT IDENTIFIER DOT IDENTIFIER DOT IDENTIFIER;

op: boolean_op | arithmetic_op;

%%
#include "lex.yy.c"
int yyerror(char* s){
  fprintf(stderr, "%s at line %d\n",s, yylineno);
  return 1;
}

int main(){
 return yyparse();
}
