char 			[A-Za-z]
digit				[0-9]
sign    			[+-]
var				{char}({char}|{digit})*
newLine			\n
end_stmt		";"
assignment_op	"="
LB				"{"
RB				"}"
LP				"("
RP				")"
plus				"+"
minus			"-"
multiplication		"*"
division			"/"
modulus			"%"
greaterThan		">"
greaterOrEqual	">="
lessThan			"<"
lessOrEqual		"<="
equal			"=="
notEqual			"!="
or				"||"
and				"&&"
not				"!"
while         		while
for           		for
elseif        		elseif
if            			if
else          		else
true	      			true
false         		false
comment_line      "//"
constant      		const
dot           		"."
integer       		[sign]?{digit}+
float         		[sign]?{digit}+(\.){digit}+
boolean       		{true}|{false}
identifier    		({char}{digit})+|{char}*
main          		main
return        		return
print         		print
function        		"function"
input           		"input"
connect         		"connect"
disconnect      	"disconnect"
receive         		receive
readAltitude    	readAltitude
readTemperature 	readTemperature
readAcceleration 	readAcceleration
turnOnCamera    	turnOnCamera
turnOffCamera   	turnOffCamera
takePicture     	takePicture
readTimestamp   	readTimestamp
connectToBase   	connectToBase
to 				to
comma 			","
string 			\"[^"]*\"

%%
{main} 			return MAIN;
{if} 				return IF;
{elseif} 			return ELSEIF;
{else} 			return ELSE;
{LB} 			return LB;
{RB} 			return RB;
{LP} 			return LP;
{RP} 			return RP;
{comma} 		return COMMA;
{dot} 			return DOT;
{plus} 			return PLUS;
{minus} 			return MINUS;
{multiplication} 	return MULTIPLICATION;
{division} 		return DIVISION;
{modulus} 		return MODULUS;
{greaterThan} 	return GREATERTHAN;
{greaterOrEqual} 	return GREATEROREQUAL;
{lessThan} 		return LESSTHAN;
{lessOrEqual} 	return LESSOREQUAL;
{equal} 			return EQUAL;
{notEqual} 		return NOTEQUAL;
{or} 				return OR;
{and} 			return AND;
{not} 			return NOT;
{while} 			return WHILE;
{for} 			return FOR;
{assignment_op} 	return ASSIGNMENT_OP;
{comment_line} 	return COMMENT_LINE;
{constant} 		return CONSTANT;
{to} 				return TO;
{readAltitude} 	return READALTITUDE;
{readTemperature} return READTEMPERATURE;
{readAcceleration} return READACCELERATION;
{turnOnCamera} 	return TURNONCAMERA;
{turnOffCamera} 	return TURNOFFCAMERA;
{takePicture} 		return TAKEPICTURE;
{readTimestamp} 	return READTIMESTAMP;
{connectToBase} 	return CONNECTTOBASE;
{integer} 			return NUMBER;
{float} 			return FLOAT;
{boolean} 		return BOOLEAN;
{print} 			return PRINT;
{function}{var} 	return FUNCTION_START;
{return} 			return FUNCTION_RETURN;
{var}(\() 			return FUNCTION_CALL;
{input} 			return INPUT;
{connect} 		return CONNECT;
{disconnect} 		return DISCONNECT;
{receive} 		return RECEIVE;
{var} 			return IDENTIFIER;
{string} 			return STRING;
{end_stmt} 		return ENDSTMT;
{newLine} 		;
[\t] 				;
.  				return(yytext[0]);
%%
int yywrap() {return 1;}
