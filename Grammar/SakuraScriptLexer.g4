lexer grammar SakuraScriptLexer;

fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

fragment CommonCharacter
	: SimpleEscapeSequence
	| HexEscapeSequence
	| UnicodeEscapeSequence
	;
fragment SimpleEscapeSequence
	: '\\\''
	| '\\"'
	| '\\\\'
	| '\\0'
	| '\\a'
	| '\\b'
	| '\\f'
	| '\\n'
	| '\\r'
	| '\\t'
	| '\\v'
	;
fragment HexEscapeSequence
	: '\\x' HexDigit
	| '\\x' HexDigit HexDigit
	| '\\x' HexDigit HexDigit HexDigit
	| '\\x' HexDigit HexDigit HexDigit HexDigit
	;
fragment UnicodeEscapeSequence
	: '\\u' HexDigit HexDigit HexDigit HexDigit
	| '\\U' HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit
	;
fragment HexDigit : [0-9] | [A-F] | [a-f];

// Card descriptor tokens
ID: I D;
CARD_ID: [A-Za-z]+ '-' (O | A INT) '-' (N | S) '-' INT ('-' E X INT)?;
NAME: N A M E;
TYPE: T Y P E;
ATK: A T K;
ACT: A C T;
ENH: E N H;
REA: R E A;
THR: T H R;
RANGE: R A N G E;
DAMAGE: D A M A G E;
CHARGE: C H A R G E;
DESCRIPTION: D E S C R I P T I O N;
SCRIPT: S C R I P T;

// Player and shared areas tokens
LIFE: L I F E;
AURA: A U R A;
FLARE: F L A R E;
VIGOR: V I G O R;
DISTANCE: D I S T A N C E;
SHADOW: S H A D O W;

// Megami selector tokens
ALL: A L L;
OWNER: O W N E R;
NOT_OWNER: N O T '_' O W N E R;

// Card types tokens
NORMAL: N O R M A L;
SPECIAL: S P E C I A L;

// Sub-blocks tokens
IF: I F;
AFTER_ATK: A F T E R '_' A T K;
ONGOING: O N G O I N G;
DISENCHANT: D I S E N C H A N T;

// Target tokens
SELF: S E L F;
THIS: T H I S;
OPP: O P P;
FIRST_ATK: F I R S T '_' A T K;
NEXT_ATK: N E X T '_' A T K;
REACTED: R E A C T E D;

// Special characters tokens
L_PAREN: '(';
R_PAREN: ')';
L_BRACKET: '[';
R_BRACKET: ']';
L_BRACE: '{';
R_BRACE: '}';
BECOME_LESS: '<=';
BECOME_MORE: '=>';
LESSER: '<';
GREATER: '>';
EQUAL: '='; 
SEMI_COLON: ';';
COLON: ':';
SLASH: '/';
COMMA: ',';
DASH: '-';
DOT: '.';

// Trigger tokens
IMMEDIATE: I M M E D I A T E;
ON: O N;

// Literals tokens
STRING: '"' (~["\\\r\n\u0085\u2028\u2029] | CommonCharacter)* '"';
INT : I N F | [0-9]+;
FUNC_NAME: [_a-zA-Z]+;

// Whitespaces and comments
WS: [ \t\r\n\u000C]+ -> skip;
COMMENT: '/*' .*? '*/' -> skip;
LINE_COMMENT: '//' ~[\r\n]* -> skip;