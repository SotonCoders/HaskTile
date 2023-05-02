{ 
module HasktileGrammar where 
import HasktileTokens 
}

%name parseCalc 

%tokentype { HasktileToken } 

%error { parseError }

%token 

  REPEAT_HORZ          { TokenREPEAT_HORZ _ }
  REPEAT_VERT          { TokenREPEAT_VERT _ }
  ADD_HORZ             { TokenADD_HORZ _ }
  ADD_VERT             { TokenADD_VERT _ }
  READ_FILE            { TokenREAD_FILE _ }
  ROTATE               { TokenROTATE _ }
  SCALE                { TokenSCALE _ }
  MAKE_TILE            { TokenMAKE_TILE _ }
  REFLECT_VERT         { TokenREFLECT_VERT _ }
  REFLECT_HORZ         { TokenREFLECT_HORZ _ }
  GET_BY_INDEX         { TokenGET_BY_INDEX _ }
  SUBTILES             { TokenSUBTILES _ }

  GET_ROW_COUNT        { TokenGET_ROW_COUNT _ }
  GET_COL_COUNT        { TokenGET_COL_COUNT _ }

  NEGATION             { TokenNEGATION _ }
  CONJUNCTION          { TokenCONJUNCTION _ }
  DISJUNCTION          { TokenDISJUNCTION _ }
  IMPLICATION          { TokenIMPLICATION _ }
  XOR                  { TokenXOR _ }

  MAKE_TRIANGLE_UP     { TokenMAKE_TRIANGLE_UP _ }
  MAKE_TRIANGLE_DOWN   { TokenMAKE_TRIANGLE_DOWN _ }

  EQUAL_TILES          { TokenEQUAL_TILES _ }

  SUBLIST    { TokenSUBLIST _ }
  REPLACE_IN_ROW    { TokenREPLACE_IN_ROW _ }

  CONCAT_STRINGS       { TokenCONCAT_STRINGS _ }
  REVERSE_LIST         { TokenREVERSE_LIST _ }

  ADD_TO_LIST          { TokenADD_TO_LIST _ }
  REMOVE_FROM_LIST     { TokenREMOVE_FROM_LIST _ }

  Int                  { TokenInt _ }
  String               { TokenString _ }
  Bool                 { TokenBool _ }

  'List<Int>'          { TokenListInt _ }
  'List<String>'       { TokenListString _ }
  'List<List<String>>' { TokenListListString _ }

  '='                  { TokenEq _ }
  '+'                  { TokenPlus _ } 
  '-'                  { TokenMinus _ } 
  '*'                  { TokenTimes _ } 
  '^'                  { TokenExp  _  }
  '/'                  { TokenDiv _ } 
  '('                  { TokenLParen _ }
  ')'                  { TokenRParen _ }
  '{'                  { TokenLBraket _ }
  '}'                  { TokenRBraket _ }
  '['                  { TokenLSquareBraket _ }
  ']'                  { TokenRSquareBraket _ }
  ','                  { TokenComma _ }
  ';'                  { TokenSemiColon _ }
  '"'                  { TokenQuote _ }

  '<'                  { TokenLessThan _ }
  '>'                  { TokenGreaterThan _ }
  '=='                 { TokenCompareEqual _ }
  '<='                 { TokenLessThanOrEqual _ }
  '>='                 { TokenGreaterThanOrEqual _ }
  '!='                 { TokenNotEqual _ }

  if                   { TokenIf _ }
  else                 { TokenElse _ }
  print                { TokenPrint _ }
        
  Number               { TokenNumber _ $$ }
  VarName              { TokenVarName _ $$ }
  FileName             { TokenFileName _ $$ }
  NumbersAsString      { TokenNumbersAsString _ $$ }


%right ';' 
%right ','
%left '+' '-' 
%left '*' '/' 
%left '^'
%left 'List<Int>' 'List<String>'

%% 
Prog : Prog ';' Prog                                                      { SEQ $1 $3 } 
     | Int VarName '=' Number                                             { DECLARE_INT_WITH_NUMBER $2 $4 }
     | Int VarName '=' FunctionsLibrary                                   { DECLARE_INT $2 $4 }
     | Bool VarName '=' Cond                                              { DECLARE_BOOL $2 $4 }
     | String VarName '=' FunctionsLibrary                                { DECLARE_STRING $2 $4 }
     | String VarName '=' NumbersAsString                                 { DECALRE_STRING_WITH_QUOTES $2 $4 }
     | VarName '=' FunctionsLibrary                                       { OVERWRITE $1 $3 }
     | VarName '=' Number                                                 { OVERWRITE_NUMBER $1 $3 }
     | VarName '=' NumbersAsString                                        { OVERWRITE_WITH_QUOTES $1 $3 }
     | FunctionsLibrary                                                   { FUNCTION_CALL $1 }
     | 'List<String>' VarName '=' '[' ']'                                 { DECLARE_LIST_STRING_EMPTY $2 }
     | 'List<Int>' VarName '=' FunctionsLibrary                           { DECLARE_LIST_INT $2 $4 }
     | 'List<String>' VarName '=' FunctionsLibrary                        { DECLARE_LIST_STRING $2 $4 } 
     | 'List<List<String>>' VarName '=' '[' ']'                           { DECLARE_LIST_LIST_STRING_EMPTY $2 }
     | 'List<List<String>>' VarName '=' FunctionsLibrary                  { DECLARE_LIST_LIST_STRING $2 $4 }
     | if '(' Cond ')' '{' Prog '}' else '{' Prog '}'                     { ELSEIF $3 $6 $10 }
     | if '(' Cond ')' '{' Prog '}'                                       { IF $3 $6 }
     | print '(' FunctionsLibrary ')'                                     { PRINT $3 }
     | print '(' VarName ')'                                              { PRINT_VAR $3 }
     | Prog ';'                                                           { LAST_ACTION_CALLED $1 }
         
Cond : Parameter '<' Parameter                                            { LESS_THAN $1 $3 }
     | Parameter '>' Parameter                                            { GREATER_THAN $1 $3 }
     | Parameter '==' Parameter                                           { COMPARE_EQUAL $1 $3 }
     | Parameter '<=' Parameter                                           { LESS_THAN_OR_EQUAL $1 $3 }
     | Parameter '>=' Parameter                                           { GREATER_THAN_OR_EQUAL $1 $3 }
     | Parameter '!=' Parameter                                           { NOT_EQUAL $1 $3 }
     | EQUAL_TILES '(' VarName ',' VarName ')'                            { EQUAL_TILES $3 $5 }
        
FunctionsLibrary : REPEAT_HORZ '(' Parameter ',' Parameter ')'            { REPEAT_HORZ $3 $5 }
                 | REPEAT_VERT '(' Parameter ',' Parameter ')'            { REPEAT_VERT $3 $5 }
                 | ADD_HORZ '(' VarName ',' VarName ')'                   { ADD_HORZ $3 $5 }
                 | ADD_VERT '(' VarName ',' VarName ')'                   { ADD_VERT $3 $5 }
                 | READ_FILE '(' '"' FileName '"' ')'                     { READ_FILE $4 }
                 | ROTATE '(' VarName ')'                                 { ROTATE $3 }
                 | SCALE '(' Parameter ',' Parameter ')'                  { SCALE $3 $5 }
                 | MAKE_TILE '(' Parameter ',' Parameter ')'              { MAKE_TILE $3 $5 }
                 | REFLECT_VERT '(' VarName ')'                           { REFLECT_VERT $3 }
                 | REFLECT_HORZ '(' VarName ')'                           { REFLECT_HORZ $3 }
                 | GET_BY_INDEX '(' Parameter ',' Parameter ')'           { GET_BY_INDEX $3 $5 }
                 | SUBTILES '(' Parameter ',' Parameter ',' Parameter ')' { SUBTILES $3 $5 $7 }
                 | GET_ROW_COUNT '(' VarName ')'                          { GET_ROW_COUNT $3 }
                 | GET_COL_COUNT '(' VarName ')'                          { GET_COL_COUNT $3 }
                 | NEGATION '(' VarName ')'                               { NEGATION $3 }
                 | CONJUNCTION '(' VarName ',' VarName ')'                { CONJUNCTION $3 $5 }
                 | DISJUNCTION '(' VarName ',' VarName ')'                { DISJUNCTION $3 $5 }
                 | IMPLICATION '(' VarName ',' VarName ')'                { IMPLICATION $3 $5 }
                 | XOR '(' VarName ',' VarName ')'                        { XOR $3 $5 }
                 | MAKE_TRIANGLE_UP '(' Parameter ',' Parameter ')'       { MAKE_TRIANGLE_UP $3 $5 }
                 | MAKE_TRIANGLE_DOWN '(' Parameter ',' Parameter ')'     { MAKE_TRIANGLE_DOWN $3 $5 }
                 | SUBLIST '(' Parameter ',' Parameter ',' Parameter ')'                 { SUBLIST $3 $5 $7 }
                 | REPLACE_IN_ROW '(' Parameter ',' Parameter ',' Parameter ')'          { REPLACE_IN_ROW $3 $5 $7 }
                 | CONCAT_STRINGS '(' Parameter ',' Parameter ')'         { CONCAT_STRINGS $3 $5 }
                 | REVERSE_LIST '(' Parameter ')'                         { REVERSE_LIST $3 }
                 | ADD_TO_LIST '(' Parameter ',' Parameter ')'            { ADD_TO_LIST $3 $5 }
                 | REMOVE_FROM_LIST '(' Parameter ',' Parameter ')'       { REMOVE_FROM_LIST $3 $5 }
                 | Parameter '+' Parameter                                { Plus $1 $3 } 
                 | Parameter '-' Parameter                                { Minus $1 $3 } 
                 | Parameter '*' Parameter                                { Times $1 $3 } 
                 | Parameter '/' Parameter                                { Div $1 $3 } 
                 | Parameter '^' Parameter                                { Expo $1 $3 }

Parameter : Number                                                        { PARAMETER_INT $1 }
          | NumbersAsString                                               { PARAMETER_STRING_QUOTES $1}
          | VarName                                                       { PARAMETER_STRING $1 }

 
 

{ 
parseError :: [HasktileToken] -> a
parseError [] = error "Unknown Parse Error" 
parseError (t:ts) = error ("Parse error at line:column " ++ (tokenPosn t))

data Prog = SEQ Prog Prog
          | FUNCTION_CALL FunctionsLibrary
          | DECLARE_INT_WITH_NUMBER String Int
          | DECLARE_INT String FunctionsLibrary
          | DECLARE_STRING String FunctionsLibrary
          | DECALRE_STRING_WITH_QUOTES String String
          | DECLARE_BOOL String Cond
          | DECLARE_LIST_INT String FunctionsLibrary
          | DECLARE_LIST_STRING String FunctionsLibrary
          | DECLARE_LIST_STRING_EMPTY String
          | DECLARE_LIST_LIST_STRING String FunctionsLibrary
          | DECLARE_LIST_LIST_STRING_EMPTY String 
          | OVERWRITE String FunctionsLibrary
          | OVERWRITE_NUMBER String Int
          | OVERWRITE_WITH_QUOTES String String
          | ELSEIF Cond Prog Prog
          | IF Cond Prog
          | PRINT FunctionsLibrary
          | PRINT_VAR String
          | LAST_ACTION_CALLED Prog
          deriving Show 

data Cond = LESS_THAN Parameter Parameter
          | GREATER_THAN Parameter Parameter 
          | COMPARE_EQUAL Parameter Parameter 
          | LESS_THAN_OR_EQUAL Parameter Parameter
          | GREATER_THAN_OR_EQUAL Parameter Parameter
          | NOT_EQUAL Parameter Parameter 
          | EQUAL_TILES String String
          deriving Show

data FunctionsLibrary = REPEAT_HORZ Parameter Parameter
                      | REPEAT_VERT Parameter Parameter
                      | ADD_HORZ String String
                      | ADD_VERT String String
                      | READ_FILE String
                      | ROTATE String
                      | SCALE Parameter Parameter
                      | MAKE_TILE Parameter Parameter
                      | REFLECT_VERT String
                      | REFLECT_HORZ String
                      | GET_BY_INDEX Parameter Parameter
                      | SUBTILES Parameter Parameter Parameter  
                      | GET_ROW_COUNT String 
                      | GET_COL_COUNT String
                      | NEGATION String
                      | CONJUNCTION String String
                      | DISJUNCTION String String
                      | IMPLICATION String String
                      | XOR String String
                      | MAKE_TRIANGLE_UP Parameter Parameter
                      | MAKE_TRIANGLE_DOWN Parameter Parameter
                      | SUBLIST Parameter Parameter Parameter
                      | REPLACE_IN_ROW Parameter Parameter Parameter
                      | CONCAT_STRINGS Parameter Parameter
                      | REVERSE_LIST Parameter
                      | ADD_TO_LIST Parameter Parameter
                      | REMOVE_FROM_LIST Parameter Parameter
                      | Plus Parameter Parameter 
                      | Minus Parameter Parameter 
                      | Times Parameter Parameter 
                      | Div Parameter Parameter 
                      | Expo Parameter Parameter
                      deriving Show

data Parameter = PARAMETER_INT Int 
               | PARAMETER_STRING_QUOTES String
               | PARAMETER_STRING String
               deriving Show


} 













