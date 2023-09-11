{ 
module HasktileTokens where 
}

%wrapper "posn" 

$digit = 0-9     
-- digits 
$alpha = [a-zA-Z]    
-- alphabetic characters

-- File details :

-- Comments related with tokens :
-- can't comment tokens part of the file
-- $white+ include new line
-- '.' does not include new line
-- note that both p and s are passed as lambdas
-- oder does matter in tokinising

-- TODO :
-- should we get rod of Int and String ?
-- missing the actual functions names tokens
-- should we approach tokenising for numbers and digits separate ? (one of them might not work now)

-- Important Notes :
-- tokens are unfinished

tokens :-
  $white+                        ; 
  "//".*                         ; 
  "--".*                         ;

  REPEAT_HORZ                    { \p s -> TokenREPEAT_HORZ p }
  REPEAT_VERT                    { \p s -> TokenREPEAT_VERT p }

  ADD_HORZ                       { \p s -> TokenADD_HORZ p }
  ADD_VERT                       { \p s -> TokenADD_VERT p }

  READ_FILE                      { \p s -> TokenREAD_FILE p }
  ROTATE                         { \p s -> TokenROTATE p }
  SCALE                          { \p s -> TokenSCALE p }
  MAKE_TILE                      { \p s -> TokenMAKE_TILE p }
  REFLECT_VERT                   { \p s -> TokenREFLECT_VERT p } 
  REFLECT_HORZ                   { \p s -> TokenREFLECT_HORZ p }

  GET_BY_INDEX                   { \p s -> TokenGET_BY_INDEX p }
  SUBTILES                       { \p s -> TokenSUBTILES p }

  GET_ROW_COUNT                  { \p s -> TokenGET_ROW_COUNT p }
  GET_COL_COUNT                  { \p s -> TokenGET_COL_COUNT p }

  NEGATION                       { \p s -> TokenNEGATION p }
  CONJUNCTION                    { \p s -> TokenCONJUNCTION p }
  DISJUNCTION                    { \p s -> TokenDISJUNCTION p }
  IMPLICATION                    { \p s -> TokenIMPLICATION p }
  XOR                            { \p s -> TokenXOR p }

  MAKE_TRIANGLE_UP               { \p s -> TokenMAKE_TRIANGLE_UP p }
  MAKE_TRIANGLE_DOWN             { \p s -> TokenMAKE_TRIANGLE_DOWN p }

  EQUAL_TILES                    { \p s -> TokenEQUAL_TILES p }

  SUBLIST              { \p s -> TokenSUBLIST p }
  REPLACE_IN_ROW              { \p s -> TokenREPLACE_IN_ROW p }

  CONCAT_STRINGS                 { \p s -> TokenCONCAT_STRINGS p }
  REVERSE_LIST                   { \p s -> TokenREVERSE_LIST p }

  ADD_TO_LIST                    { \p s -> TokenADD_TO_LIST p }
  REMOVE_FROM_LIST               { \p s -> TokenREMOVE_FROM_LIST p }

  Int                            { \p s -> TokenInt p }
  String                         { \p s -> TokenString p }
  Bool                           { \p s -> TokenBool p }
  List\<Int\>                    { \p s -> TokenListInt p }
  List\<String\>                 { \p s -> TokenListString p }
  List\<List\<String\>\>         { \p s -> TokenListListString p }

  \=                             { \p s -> TokenEq p }
  \+                             { \p s -> TokenPlus p }
  \-                             { \p s -> TokenMinus p }
  \*                             { \p s -> TokenTimes p }
  \/                             { \p s -> TokenDiv p }
  \^                             { \p s -> TokenExp p }
  \(                             { \p s -> TokenLParen p }
  \)                             { \p s -> TokenRParen p }
  \{                             { \p s -> TokenLBraket p }
  \}                             { \p s -> TokenRBraket p }
  \[                             { \p s -> TokenLSquareBraket p }
  \]                             { \p s -> TokenRSquareBraket p }
  \,                             { \p s -> TokenComma p }
  \;                             { \p s -> TokenSemiColon p }
  \"                             { \p s -> TokenQuote p }

  \<                             { \p s -> TokenLessThan p }
  \>                             { \p s -> TokenGreaterThan p }
  \=\=                           { \p s -> TokenCompareEqual p }
  \<\=                           { \p s -> TokenLessThanOrEqual p }
  \>\=                           { \p s -> TokenGreaterThanOrEqual p }
  \!\=                           { \p s -> TokenNotEqual p }

  if                             { \p s -> TokenIf p } 
  else                           { \p s -> TokenElse p }
  print                          { \p s -> TokenPrint p }

  [$alpha $digit \_ \’]+ \.tl    { \p s -> TokenFileName p s }
  \" [$digit]* \"                { \p s -> TokenNumbersAsString p s }
  $digit+                        { \p s -> TokenNumber p (read s) }
  $alpha [$alpha $digit \_ \’]*  { \p s -> TokenVarName p s }



{ 
-- to be checked
-- Each action has type :: AlexPosn -> String -> HasktileToken 

-- The token type: 

data HasktileToken =  
  TokenREPEAT_HORZ AlexPosn        |
  TokenREPEAT_VERT AlexPosn        |

  TokenADD_HORZ AlexPosn           |
  TokenADD_VERT AlexPosn           |

  TokenREAD_FILE AlexPosn          |

  TokenROTATE AlexPosn             |
  TokenSCALE AlexPosn              |
  TokenMAKE_TILE AlexPosn          | 

  TokenREFLECT_VERT AlexPosn       |
  TokenREFLECT_HORZ AlexPosn       | 

  TokenGET_BY_INDEX AlexPosn       |
  TokenSUBTILES AlexPosn           |

  TokenGET_ROW_COUNT AlexPosn      |
  TokenGET_COL_COUNT AlexPosn      |

  TokenNEGATION AlexPosn           |

  TokenCONJUNCTION AlexPosn        |
  TokenDISJUNCTION AlexPosn        |
  TokenIMPLICATION AlexPosn        |
  TokenXOR AlexPosn                | 

  TokenMAKE_TRIANGLE_UP AlexPosn   |
  TokenMAKE_TRIANGLE_DOWN AlexPosn | 

  TokenEQUAL_TILES AlexPosn        |

  TokenSUBLIST AlexPosn  | 
  TokenREPLACE_IN_ROW AlexPosn  |

  TokenCONCAT_STRINGS AlexPosn     |
  TokenREVERSE_LIST AlexPosn       | 
  TokenADD_TO_LIST AlexPosn        |
  TokenREMOVE_FROM_LIST AlexPosn   |

  TokenInt AlexPosn                |
  TokenString AlexPosn             |
  TokenBool AlexPosn               | 
   
  TokenListInt  AlexPosn           |
  TokenListString AlexPosn         |
  TokenListListString AlexPosn     | 
   
  TokenEq AlexPosn                 |
  TokenPlus AlexPosn               |
  TokenMinus AlexPosn              |
  TokenTimes AlexPosn              |
  TokenDiv AlexPosn                |
  TokenExp AlexPosn                |

  TokenLParen AlexPosn             |
  TokenRParen AlexPosn             |
  TokenLBraket AlexPosn            | 
  TokenRBraket AlexPosn            | 
  TokenLSquareBraket AlexPosn      | 
  TokenRSquareBraket AlexPosn      | 
  TokenComma AlexPosn              |
  TokenSemiColon AlexPosn          |
  TokenQuote AlexPosn              |

  TokenLessThan AlexPosn           |
  TokenGreaterThan AlexPosn        |
  TokenCompareEqual AlexPosn       |
  TokenLessThanOrEqual AlexPosn    |
  TokenGreaterThanOrEqual AlexPosn |
  TokenNotEqual AlexPosn           |

  TokenIf AlexPosn                 |
  TokenElse AlexPosn               | 
  TokenPrint AlexPosn              |

  TokenNumber AlexPosn Int         |
  TokenVarName AlexPosn String     | 
  TokenFileName AlexPosn String    |
  TokenNumbersAsString AlexPosn String 

  deriving (Eq,Show) 

tokenPosn :: HasktileToken -> String

tokenPosn (TokenREPEAT_HORZ  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenREPEAT_VERT  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenADD_HORZ  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenADD_VERT (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenREAD_FILE  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenROTATE  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenSCALE  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenMAKE_TILE  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenREFLECT_VERT  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenREFLECT_HORZ  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenGET_BY_INDEX  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenSUBTILES  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenGET_ROW_COUNT  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGET_COL_COUNT  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)


tokenPosn (TokenNEGATION (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenCONJUNCTION (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenDISJUNCTION (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenIMPLICATION (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenXOR (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenMAKE_TRIANGLE_UP  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenMAKE_TRIANGLE_DOWN  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenEQUAL_TILES  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenSUBLIST  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenREPLACE_IN_ROW  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenCONCAT_STRINGS  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenREVERSE_LIST  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenADD_TO_LIST  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenREMOVE_FROM_LIST  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)


tokenPosn (TokenInt  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenString  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenBool  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenListInt  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenListString  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenListListString  (AlexPn a l c) ) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenEq  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenPlus (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenMinus (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenTimes (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenDiv (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenExp (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLParen (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenRParen (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLBraket (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenRBraket (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLSquareBraket (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenRSquareBraket (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenComma  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenSemiColon  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenQuote  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenLessThan  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGreaterThan  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenCompareEqual  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenLessThanOrEqual  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenGreaterThanOrEqual  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenNotEqual  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)


tokenPosn (TokenIf  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenElse  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenPrint  (AlexPn a l c)) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenNumber  (AlexPn a l c) n) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenVarName  (AlexPn a l c) s) = show(l) ++ ":" ++ show(c)
tokenPosn (TokenFileName  (AlexPn a l c) s) = show(l) ++ ":" ++ show(c)

tokenPosn (TokenNumbersAsString  (AlexPn a l c) s) = show(l) ++ ":" ++ show(c)



}











