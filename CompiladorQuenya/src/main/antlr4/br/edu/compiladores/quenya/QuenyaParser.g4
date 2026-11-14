/**
 *
 * @author pedro
 */

parser grammar QuenyaParser;

options {tokenVocab=QuenyaLexer;}

programa
 : HARDWARE LBRACE declaracaoRecurso* RBRACE
 declaracaoGlobal*
 declaracaoFuncao*
 SETUP bloco
 LOOP bloco
 EOF
 ;
declaracaoRecurso
 : tipoRecurso ID ASSIGN referenciaPino (COLON expressao)? SEMI
 ;
tipoRecurso
 : OUTPUT
 | INPUT
 | INPUT_PULLUP
 | ANALOG_INPUT
 | PWM_OUTPUT
 ;
referenciaPino
 : DIGITAL_PIN LPAREN INT_LITERAL RPAREN
 | ANALOG_PIN LPAREN INT_LITERAL RPAREN
 ;
declaracaoGlobal
 : CONST tipo ID ASSIGN expressao SEMI
 | tipo ID (ASSIGN expressao)? SEMI
 ;
declaracaoLocal
 : CONST? tipo ID ASSIGN expressao SEMI
 ;
declaracaoFuncao
 : FUNCTION tipoRetorno ID LPAREN listaParametros? RPAREN bloco
 ;
tipoRetorno
 : tipo
 | VOID
 ;
listaParametros
 : parametro (COMMA parametro)*
 ;
parametro
 : tipo ID
 ;
tipo
 : tipoEscalar
 | tipoVetor
 ;
tipoEscalar
 : (INT_TYPE | BYTE_TYPE) largura?
 | BOOL_TYPE
 | LEVEL_TYPE
 | TIME_TYPE (LT MILLIS GT)?
 | TEXT_TYPE
 | OPTIONAL_BYTE_TYPE
 | FLOAT
 ;
largura
 : LT INT_LITERAL GT
 ;
tipoVetor
 : LBRACK tipoEscalar SEMI INT_LITERAL RBRACK
 ;
bloco
 : LBRACE comando* RBRACE
 ;
comando
 : declaracaoLocal
 | atribuicao SEMI
 | ACTION corpoAcao SEMI
 | SERIAL_BEGIN expressao SEMI
 | IF expressao bloco (ELSE bloco)?
 | IF SERIAL_READ TO ID bloco (ELSE bloco)?
 | SWITCH expressao LBRACE casoSelecao+ (ELSE bloco)? RBRACE
 | WHILE expressao bloco
 | DO bloco WHILE expressao SEMI
 | FOR LPAREN inicioFor? SEMI expressao? SEMI atualizacaoFor? RPAREN bloco
 | REPEAT expressao bloco
 | BREAK SEMI
 | CONTINUE SEMI
 | RETURN expressao? SEMI
 ;
atribuicao
 : ID ASSIGN expressao
 | ID LBRACK expressao RBRACK ASSIGN expressao
 ;
corpoAcao
 : (SERIAL_PRINT | SERIAL_PRINTLN | SERIAL_WRITE) expressao
 | DIGITAL_WRITE expressao TO ID
 | ANALOG_WRITE ID expressao
 | DELAY expressao
 | ID LPAREN listaArgumentos? RPAREN
 ;
casoSelecao
 : CASE expressao bloco
 ;
inicioFor
 : tipo ID ASSIGN expressao
 | atribuicao
 | ACTION corpoAcao
 ;
atualizacaoFor
 : atribuicao
 | ACTION corpoAcao
 ;
expressao
 : expressaoOu
 ;
expressaoOu
 : expressaoE (OR expressaoE)*
 ;
expressaoE
 : expressaoRelacional (AND expressaoRelacional)*
 ;
expressaoRelacional
 : expressaoAditiva (operadorRelacional expressaoAditiva)?
 ;
operadorRelacional
 : LT
 | LTE
 | GT
 | GTE
 | EQ
 | NEQ
 ;
expressaoAditiva
 : expressaoMultiplicativa ((PLUS | MINUS) expressaoMultiplicativa)*
 ;
expressaoMultiplicativa
 : expressaoUnaria ((MULT | DIV | MOD) expressaoUnaria)*
 ;
expressaoUnaria
 : (NOT | MINUS) expressaoUnaria
 | expressaoPrimaria
 ;
expressaoPrimaria
 : INT_LITERAL
 | FLOAT_LITERAL
 | STRING_LITERAL
 | (TRUE | FALSE)
 | (HIGH | LOW)
 | MILLIS
 | ID
 | ID LPAREN listaArgumentos? RPAREN
 | ID LBRACK expressao RBRACK
 | LPAREN expressao RPAREN
 | LBRACK listaArgumentos? RBRACK
 | TIME_TYPE LPAREN INT_LITERAL COMMA INT_LITERAL RPAREN
 | (INT_TYPE | BYTE_TYPE) largura? LPAREN expressao RPAREN
 | FLOAT LPAREN expressao RPAREN
 | BIT_NOT largura LPAREN expressao RPAREN
 | (BIT_AND | BIT_OR | BIT_XOR | SHIFT_LEFT | SHIFT_RIGHT) largura LPAREN expressao COMMA expressao RPAREN
 | (DIGITAL_READ | ANALOG_READ) ID
 ;
listaArgumentos
 : expressao (COMMA expressao)*
 ;
