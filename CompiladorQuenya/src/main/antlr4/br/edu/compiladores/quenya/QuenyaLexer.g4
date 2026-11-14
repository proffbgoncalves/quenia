/**
 *
 * @author joanafelizardo
 */

lexer grammar QuenyaLexer; 

// 1. palavras reservada ( 5 e 6.1 - 58 tokens oficiais)
HARDWARE           : 'tamna' ;
SETUP              : 'yesta' ;
LOOP               : 'carda' ;
CONST              : 'tanca' ;
FUNCTION           : 'carma' ;
RETURN             : 'entuless' TREMA_E ;

INT_TYPE           : 'n' AGUDO_O 't' TREMA_E ;
BYTE_TYPE          : 'toldo' ;
BOOL_TYPE          : 'naiti' TREMA_E ;
LEVEL_TYPE         : 'tyell' TREMA_E ;
TIME_TYPE          : 'l' AGUDO_U 'm' TREMA_E ;
TEXT_TYPE          : 'queti' TREMA_E ;
OPTIONAL_BYTE_TYPE : 't' AGUDO_E 'ma_tengwa' ;
VOID               : 'alla' ;
FLOAT              : 'lutu' ;

TRUE               : 'nait' TREMA_E ;
FALSE              : 'ui' ;
HIGH               : 'orwa' ;
LOW                : 'undu' ;

IF                 : 'qui' ;
ELSE               : 'hyana' ;
SWITCH             : 'cilm' TREMA_E ;
CASE               : 've' ;
WHILE              : 'yallum' TREMA_E ;
REPEAT             : 'enquet' ;
DO                 : 'car' TREMA_E ;
FOR                : 'ter' ;
BREAK              : 'hauta' ;
CONTINUE           : 'lelya' ;

AND                : 'ar' ;
OR                 : 'hya' ;
NOT                : 'l' AGUDO_A ;

ACTION             : AGUDO_A ;
TO                 : 'ana' ;

DIGITAL_WRITE      : 'tec' ;
ANALOG_WRITE       : 'mahta' ;
DELAY              : 'har' ;
DIGITAL_READ       : 'henta' ;
ANALOG_READ        : 'tyav' ;

SERIAL_PRINT       : 'quet' ;
SERIAL_PRINTLN     : 'quet_metta' ;
SERIAL_WRITE       : 'quet_tengwa' ;
SERIAL_BEGIN       : 't' AGUDO_E 'ma' ;
SERIAL_READ        : 't' AGUDO_E 'ma_henta' ;
MILLIS             : 's' AGUDO_I ;

DIGITAL_PIN        : 'tengw' TREMA_E ;
ANALOG_PIN         : 'ov' AGUDO_E 'a' ;
INPUT              : 'tengw' TREMA_E '_mina' ;
INPUT_PULLUP       : 'tengw' TREMA_E '_mina_amba' ;
OUTPUT             : 'tengw' TREMA_E '_et' ;
ANALOG_INPUT       : 'ov' AGUDO_E 'a_tengw' TREMA_E '_mina' ;
PWM_OUTPUT         : 'falma_tengw' TREMA_E '_et' ;

BIT_AND            : 'ar_tengwa' ;
BIT_OR             : 'hya_tengwa' ;
BIT_XOR            : 'er_tengwa' ;
BIT_NOT            : 'l' AGUDO_A '_tengwa' ;
SHIFT_LEFT         : 'hyarya_tengwa' ;
SHIFT_RIGHT        : 'forya_tengwa' ;

// 2. operadores e delimitadores ( 9, 19 e 20)
EQ     : '==' ;
NEQ    : '!=' ;
LTE    : '<=' ;
GTE    : '>=' ;
ASSIGN : '=' ;
LT     : '<' ;
GT     : '>' ;

PLUS   : '+' ;
MINUS  : '-' ;
MULT   : '*' ;
DIV    : '/' ;
MOD    : '%' ;

LBRACE : '{' ;
RBRACE : '}' ;
LPAREN : '(' ;
RPAREN : ')' ;
LBRACK : '[' ;
RBRACK : ']' ;
SEMI   : ';' ;
COMMA  : ',' ;
COLON  : ':' ;

// 3. literais  válidos ( 5.2 e 6.1.1)
FLOAT_LITERAL
    : ( '0' | [1-9][0-9]* ) '.' [0-9]+ ( [eE] [+-]? [0-9]+ )?
    | ( '0' | [1-9][0-9]* ) [eE] [+-]? [0-9]+
    ;

INT_LITERAL
    : '0b' [01]+
    | '0x' [0-9a-fA-F]+
    | '0'
    | [1-9][0-9]*
    ;

STRING_LITERAL
    : '"' ( '\\' [nrt"\\] | ~["\\\r\n] )* '"'
    ;

// 4. identificadores ( 5.1 - UTF-8 NFC, não começa com '__')
ID
    : ( [\p{L}] | '_' [\p{L}0-9] ) [\p{L}\p{M}0-9_]*
    | '_'
    ;

// 5. espaços e comentarios ( 21)
WS            : [ \t\r\n]+ -> skip ;
COMMENT_LINE  : '//' ~[\r\n]* -> skip ;
COMMENT_BLOCK : '/*' .*? '*/' -> skip ;

// 6. captura de erros ( 26.1 - rejeita candidatos inválidos)
ERR_NUMERO_INVALIDO
    : '0' [bB] [0-9a-zA-Z_]*
    | '0' [xX] [0-9a-zA-Z_]*
    | '0' [0-9]+ ( '.' [0-9.]* )? ( [eE] [+-]? [0-9a-zA-Z_]* )?
    | [0-9]+ '.' [0-9]+ '.' [0-9.]*
    | [0-9]+ '.'
    | '.' [0-9]+
    | [0-9]+ ( '.' [0-9]+ )? [eE] [+-]?
    | [0-9]+ [\p{L}\p{M}_] [\p{L}\p{M}0-9_]*
    ;

ERR_ID_RESERVADO : '__' [\p{L}\p{M}0-9_]* ;
ERR_STRING_ESCAPE       : '"' ( '\\' . | ~["\\\r\n] )* '"' ;
ERR_STRING_NAO_FECHADA  : '"' ( '\\' . | ~["\\\r\n] )* ;
ERR_COMENTARIO_NAO_FECHADO : '/*' ( ~'*' | '*'+ ~[*/] )* '*'* EOF ;
ERR_CARACTERE_INVALIDO  : . ;

// 7. acentuação opcional (com, sem ou decomposta NFD)
fragment AGUDO_A : 'á' | 'a' '\u0301'? ;
fragment AGUDO_E : 'é' | 'e' '\u0301'? ;
fragment AGUDO_I : 'í' | 'i' '\u0301'? ;
fragment AGUDO_O : 'ó' | 'o' '\u0301'? ;
fragment AGUDO_U : 'ú' | 'u' '\u0301'? ;
fragment TREMA_E : 'ë' | 'e' '\u0308'? ;
