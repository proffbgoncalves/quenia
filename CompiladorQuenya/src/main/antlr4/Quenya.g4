grammar Quenya;

@header {
    package br.edu.compiladores.quenya;
}

// regra apenas para o ANTLR gerar e testar o Lexer na primeira etapa
program : .*? EOF ;

// 1. palavras reservada ( 5 e 6.1 - 58 tokens oficiais)
HARDWARE           : 'tamna' ;
SETUP              : 'yesta' ;
LOOP               : 'carda' ;
CONST              : 'tanca' ;
FUNCTION           : 'carma' ;
RETURN             : 'entulessë' ;

INT_TYPE           : 'nótë' ;
BYTE_TYPE          : 'toldo' ;
BOOL_TYPE          : 'naitië' ;
LEVEL_TYPE         : 'tyellë' ;
TIME_TYPE          : 'lúmë' ;
TEXT_TYPE          : 'quetië' ;
OPTIONAL_BYTE_TYPE : 'téma_tengwa' ;
VOID               : 'alla' ;
FLOAT              : 'lutu' ;

TRUE               : 'naitë' ;
FALSE              : 'ui' ;
HIGH               : 'orwa' ;
LOW                : 'undu' ;

IF                 : 'qui' ;
ELSE               : 'hyana' ;
SWITCH             : 'cilmë' ;
CASE               : 've' ;
WHILE              : 'yallumë' ;
REPEAT             : 'enquet' ;
DO                 : 'carë' ;
FOR                : 'ter' ;
BREAK              : 'hauta' ;
CONTINUE           : 'lelya' ;

AND                : 'ar' ;
OR                 : 'hya' ;
NOT                : 'lá' ;

ACTION             : 'á' ;
TO                 : 'ana' ;

DIGITAL_WRITE      : 'tec' ;
ANALOG_WRITE       : 'mahta' ;
DELAY              : 'har' ;
DIGITAL_READ       : 'henta' ;
ANALOG_READ        : 'tyav' ;

SERIAL_PRINT       : 'quet' ;
SERIAL_PRINTLN     : 'quet_metta' ;
SERIAL_WRITE       : 'quet_tengwa' ;
SERIAL_BEGIN       : 'téma' ;
SERIAL_READ        : 'téma_henta' ;
MILLIS             : 'sí' ;

DIGITAL_PIN        : 'tengwë' ;
ANALOG_PIN         : 'ovéa' ;
INPUT              : 'tengwë_mina' ;
INPUT_PULLUP       : 'tengwë_mina_amba' ;
OUTPUT             : 'tengwë_et' ;
ANALOG_INPUT       : 'ovéa_tengwë_mina' ;
PWM_OUTPUT         : 'falma_tengwë_et' ;

BIT_AND            : 'ar_tengwa' ;
BIT_OR             : 'hya_tengwa' ;
BIT_XOR            : 'er_tengwa' ;
BIT_NOT            : 'lá_tengwa' ;
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

// ============================================================================
// 5. ESPAÇOS E COMENTÁRIOS (Seção 21)
// ============================================================================
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

ERR_ID_RESERVADO        : '__' [\p{L}\p{M}0-9_]* ;
ERR_STRING_ESCAPE       : '"' ( '\\' . | ~["\\\r\n] )* '"' ;
ERR_STRING_NAO_FECHADA  : '"' ( '\\' . | ~["\\\r\n] )* ;
ERR_COMENTARIO_FECHADO  : '/*' .*? EOF ;
ERR_CARACTERE_INVALIDO  : . ;