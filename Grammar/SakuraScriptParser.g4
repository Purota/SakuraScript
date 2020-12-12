parser grammar SakuraScriptParser;

options
{
    tokenVocab=SakuraScriptLexer;
}

@members
{
    public CardCompiler Compiler = new CardCompiler();
}

// 1. Card details
cards: cards card | /* epsilon */;
card: card_id card_infos;
card_infos: card_infos card_info | /* epsilon */;
card_info: card_name | card_flare | card_type | card_range | card_damage | card_charge | card_description | card_script;
card_id: ID COLON CARD_ID { Compiler.AddCard($CARD_ID.text); };
card_name: NAME COLON STRING { Compiler.LastCard.Name = Compiler.ParseString($STRING.text); };
card_flare: FLARE COLON INT { Compiler.LastCard.Flare = Compiler.ParseInteger($INT.text); };
card_type: TYPE COLON main_type (SLASH sub_type)?
    {
        Compiler.LastCard.Type = Compiler.ParseCardType($main_type.text);
        if (_localctx.ChildCount == 5)
        {
            Compiler.LastCard.SubType = Compiler.ParseCardType($sub_type.text);
        }
    };
card_range: RANGE COLON atk_range;
card_damage: DAMAGE COLON damage;
card_charge: CHARGE COLON INT;
card_description: DESCRIPTION COLON STRING { Compiler.LastCard.Description = $STRING.text; };
card_script: SCRIPT COLON L_BRACE script_insts R_BRACE;

// 2. Game variables
// 2.1 Card types
main_type: ATK | ACT | ENH;
sub_type: REA | THR;
// 2.1 Range
atk_range: L_BRACKET ranges R_BRACKET | range;
ranges: ranges COMMA range | range;
range: INT | INT DASH INT;
// 2.3 Damage value
damage: damage_mod | DASH SLASH INT | INT SLASH DASH;
damage_mod: DASH? INT SLASH DASH? INT;
// 2.3 Attack type
atk_type: NORMAL | SPECIAL;

// 3. Scripting
script_insts: script_insts script_inst | /* epsilon */;
script_inst: arrow_effect SEMI_COLON | function SEMI_COLON | sub_block;
// 3.1 Arrow effects
arrow_effect: simple_arrow | double_arrow;
simple_arrow: zone DASH INT DASH GREATER zone;
double_arrow: zone LESSER DASH INT DASH GREATER zone;
// 3.2 Function call
function: target DOT function_name L_PAREN params R_PAREN trigger?;
function_name: FUNC_NAME;
params: params_n | param | /* epsilon */;
params_n: params_n COMMA param | param;
param: INT | atk_range | damage | megami_select | atk_type | IMMEDIATE | L_BRACE script_insts R_BRACE;
trigger: ON cond;

// 4. Sub-blocks
sub_block: if_block | keyword_block;
if_block: IF cond L_BRACE script_insts R_BRACE;
cond: (player_vigor | zone) (BECOME_LESS | BECOME_MORE | LESSER | GREATER) INT;
keyword_block: keyword L_BRACE script_insts R_BRACE;

// 5. Reserved keywords
// 5.1 Target keywords
target: player | player_vigor | THIS | first_atk | next_atk | REACTED;
// 5.1.1 Player and zones
player: SELF | OPP;
player_vigor: player DOT VIGOR;
zone: player_zone | shared_zone;
player_zone: player DOT (LIFE | AURA | FLARE);
shared_zone: DISTANCE | SHADOW;
// 5.1.2 Attacks
first_atk: FIRST_ATK (L_PAREN atk_filters R_PAREN)?;
next_atk: NEXT_ATK (L_PAREN atk_filters R_PAREN)?;
atk_filters: atk_filter1 | /* epsilon */;
atk_filter1: INT (COMMA atk_filter2)?;
atk_filter2: megami_select (COMMA atk_filter3)?;
atk_filter3: atk_type;
// 5.2 Megami select
megami_select: ALL | OWNER | NOT_OWNER;
// 5.3 Sub-blocks
keyword: AFTER_ATK | ONGOING | DISENCHANT;
