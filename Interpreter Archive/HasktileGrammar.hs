{-# OPTIONS_GHC -w #-}
module HasktileGrammar where 
import HasktileTokens
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.1.1

data HappyAbsSyn t4 t5 t6 t7
	= HappyTerminal (HasktileToken)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,547) ([65408,61439,511,16384,57367,65535,32763,0,1488,0,0,0,4,0,0,0,0,0,0,0,124,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,32768,0,0,0,0,32,0,0,0,2048,0,0,0,0,2,0,0,0,128,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,32768,0,0,0,0,32,0,0,0,2048,0,0,0,0,2,0,0,0,128,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,32768,0,0,0,0,32,0,0,0,2048,0,0,0,0,2,0,0,0,128,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,0,0,4,0,0,0,256,0,0,0,16384,0,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,8,0,0,0,512,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,256,32768,65535,65519,1,5952,65504,64511,1,32768,63493,65535,126,0,352,0,64,0,22528,0,0,512,0,0,0,32768,0,0,0,0,32,0,0,0,2048,0,0,0,0,2,0,0,0,128,0,0,0,0,0,352,0,0,0,22528,0,0,0,0,22,0,0,0,1408,0,0,0,24576,1,0,0,0,88,0,0,0,5632,0,0,0,32768,5,0,0,0,64,0,0,0,4096,0,0,0,0,4,0,0,0,256,0,0,0,16384,0,0,0,0,16,0,0,0,1024,0,0,0,32768,5,0,0,0,352,0,0,0,4096,0,0,0,0,4,0,0,0,1408,0,0,0,24576,1,0,0,0,16,0,0,32768,0,0,0,0,0,1,0,0,0,64,0,0,0,22528,0,0,0,0,22,0,0,0,1408,0,0,0,24576,1,0,0,0,88,0,0,0,5632,0,0,0,32768,5,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,32768,0,0,0,0,0,8,0,0,64,0,0,0,0,2,0,0,0,128,0,0,0,256,0,0,0,16384,0,0,0,0,512,0,0,0,32768,0,0,0,0,1,0,0,0,64,0,0,0,4096,0,0,0,0,128,0,0,0,8192,0,0,0,0,8,0,0,0,512,0,0,0,32768,0,0,0,0,32,0,0,0,2048,0,0,0,0,2,0,0,0,128,0,0,0,256,0,0,0,0,8,0,0,0,512,0,65534,8127,0,22528,65408,61439,7,0,22,0,4,0,1408,65528,32511,0,24576,65025,49151,31,32,32856,65535,2031,2048,5632,0,0,16384,0,0,0,0,61440,3,0,0,512,0,0,0,0,1,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,1408,0,0,0,24576,1,0,0,0,88,0,0,0,5632,0,0,0,32768,5,0,0,0,352,0,0,2048,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,24576,1,0,0,0,88,0,0,0,0,0,0,0,32768,5,0,0,0,352,0,0,0,22528,0,0,0,0,22,0,0,0,1408,0,0,0,16384,0,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1408,0,0,0,24576,1,0,0,0,0,0,0,0,0,0,0,0,32768,5,0,0,0,352,0,0,0,0,0,0,0,128,0,0,0,0,256,0,0,0,16384,0,0,0,0,88,0,0,0,5632,0,0,16384,0,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,0,64,0,0,0,4096,0,0,0,0,4,0,0,0,256,0,0,0,0,8,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,0,64,0,0,0,4096,0,0,0,0,4,0,0,0,8192,0,0,0,0,8,0,0,0,16,0,0,0,1024,0,0,0,0,1,0,0,0,0,0,0,0,0,0,65024,49151,2047,0,93,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,16,0,0,17408,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,0,0,0,1408,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,22,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,4096,0,0,0,0,4,0,0,0,0,128,0,0,16384,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65024,49151,2047,0,93,0,0,17408,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parseCalc","Prog","Cond","FunctionsLibrary","Parameter","REPEAT_HORZ","REPEAT_VERT","ADD_HORZ","ADD_VERT","READ_FILE","ROTATE","SCALE","MAKE_TILE","REFLECT_VERT","REFLECT_HORZ","GET_BY_INDEX","SUBTILES","GET_ROW_COUNT","GET_COL_COUNT","NEGATION","CONJUNCTION","DISJUNCTION","IMPLICATION","XOR","MAKE_TRIANGLE_UP","MAKE_TRIANGLE_DOWN","EQUAL_TILES","SUBLIST","REPLACE_IN_ROW","CONCAT_STRINGS","REVERSE_LIST","ADD_TO_LIST","REMOVE_FROM_LIST","Int","String","Bool","'List<Int>'","'List<String>'","'List<List<String>>'","'='","'+'","'-'","'*'","'^'","'/'","'('","')'","'{'","'}'","'['","']'","','","';'","'\"'","'<'","'>'","'=='","'<='","'>='","'!='","if","else","print","Number","VarName","FileName","NumbersAsString","%eof"]
        bit_start = st Prelude.* 70
        bit_end = (st Prelude.+ 1) Prelude.* 70
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..69]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (8) = happyShift action_5
action_0 (9) = happyShift action_6
action_0 (10) = happyShift action_7
action_0 (11) = happyShift action_8
action_0 (12) = happyShift action_9
action_0 (13) = happyShift action_10
action_0 (14) = happyShift action_11
action_0 (15) = happyShift action_12
action_0 (16) = happyShift action_13
action_0 (17) = happyShift action_14
action_0 (18) = happyShift action_15
action_0 (19) = happyShift action_16
action_0 (20) = happyShift action_17
action_0 (21) = happyShift action_18
action_0 (22) = happyShift action_19
action_0 (23) = happyShift action_20
action_0 (24) = happyShift action_21
action_0 (25) = happyShift action_22
action_0 (26) = happyShift action_23
action_0 (27) = happyShift action_24
action_0 (28) = happyShift action_25
action_0 (30) = happyShift action_26
action_0 (31) = happyShift action_27
action_0 (32) = happyShift action_28
action_0 (33) = happyShift action_29
action_0 (34) = happyShift action_30
action_0 (35) = happyShift action_31
action_0 (36) = happyShift action_32
action_0 (37) = happyShift action_33
action_0 (38) = happyShift action_34
action_0 (39) = happyShift action_35
action_0 (40) = happyShift action_36
action_0 (41) = happyShift action_37
action_0 (63) = happyShift action_38
action_0 (65) = happyShift action_39
action_0 (66) = happyShift action_40
action_0 (67) = happyShift action_41
action_0 (69) = happyShift action_42
action_0 (4) = happyGoto action_43
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (8) = happyShift action_5
action_1 (9) = happyShift action_6
action_1 (10) = happyShift action_7
action_1 (11) = happyShift action_8
action_1 (12) = happyShift action_9
action_1 (13) = happyShift action_10
action_1 (14) = happyShift action_11
action_1 (15) = happyShift action_12
action_1 (16) = happyShift action_13
action_1 (17) = happyShift action_14
action_1 (18) = happyShift action_15
action_1 (19) = happyShift action_16
action_1 (20) = happyShift action_17
action_1 (21) = happyShift action_18
action_1 (22) = happyShift action_19
action_1 (23) = happyShift action_20
action_1 (24) = happyShift action_21
action_1 (25) = happyShift action_22
action_1 (26) = happyShift action_23
action_1 (27) = happyShift action_24
action_1 (28) = happyShift action_25
action_1 (30) = happyShift action_26
action_1 (31) = happyShift action_27
action_1 (32) = happyShift action_28
action_1 (33) = happyShift action_29
action_1 (34) = happyShift action_30
action_1 (35) = happyShift action_31
action_1 (36) = happyShift action_32
action_1 (37) = happyShift action_33
action_1 (38) = happyShift action_34
action_1 (39) = happyShift action_35
action_1 (40) = happyShift action_36
action_1 (41) = happyShift action_37
action_1 (63) = happyShift action_38
action_1 (65) = happyShift action_39
action_1 (66) = happyShift action_40
action_1 (67) = happyShift action_41
action_1 (69) = happyShift action_42
action_1 (4) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (55) = happyShift action_44
action_2 _ = happyFail (happyExpListPerState 2)

action_3 _ = happyReduce_10

action_4 (43) = happyShift action_81
action_4 (44) = happyShift action_82
action_4 (45) = happyShift action_83
action_4 (46) = happyShift action_84
action_4 (47) = happyShift action_85
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (48) = happyShift action_80
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (48) = happyShift action_79
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (48) = happyShift action_78
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (48) = happyShift action_77
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (48) = happyShift action_76
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (48) = happyShift action_75
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (48) = happyShift action_74
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (48) = happyShift action_73
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (48) = happyShift action_72
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (48) = happyShift action_71
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (48) = happyShift action_70
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (48) = happyShift action_69
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (48) = happyShift action_68
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (48) = happyShift action_67
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (48) = happyShift action_66
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (48) = happyShift action_65
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (48) = happyShift action_64
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (48) = happyShift action_63
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (48) = happyShift action_62
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (48) = happyShift action_61
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (48) = happyShift action_60
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (48) = happyShift action_59
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (48) = happyShift action_58
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (48) = happyShift action_57
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (48) = happyShift action_56
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (48) = happyShift action_55
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (48) = happyShift action_54
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (67) = happyShift action_53
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (67) = happyShift action_52
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (67) = happyShift action_51
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (67) = happyShift action_50
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (67) = happyShift action_49
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (67) = happyShift action_48
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (48) = happyShift action_47
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (48) = happyShift action_46
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_60

action_41 (42) = happyShift action_45
action_41 _ = happyReduce_62

action_42 _ = happyReduce_61

action_43 (55) = happyShift action_44
action_43 (70) = happyAccept
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (8) = happyShift action_5
action_44 (9) = happyShift action_6
action_44 (10) = happyShift action_7
action_44 (11) = happyShift action_8
action_44 (12) = happyShift action_9
action_44 (13) = happyShift action_10
action_44 (14) = happyShift action_11
action_44 (15) = happyShift action_12
action_44 (16) = happyShift action_13
action_44 (17) = happyShift action_14
action_44 (18) = happyShift action_15
action_44 (19) = happyShift action_16
action_44 (20) = happyShift action_17
action_44 (21) = happyShift action_18
action_44 (22) = happyShift action_19
action_44 (23) = happyShift action_20
action_44 (24) = happyShift action_21
action_44 (25) = happyShift action_22
action_44 (26) = happyShift action_23
action_44 (27) = happyShift action_24
action_44 (28) = happyShift action_25
action_44 (30) = happyShift action_26
action_44 (31) = happyShift action_27
action_44 (32) = happyShift action_28
action_44 (33) = happyShift action_29
action_44 (34) = happyShift action_30
action_44 (35) = happyShift action_31
action_44 (36) = happyShift action_32
action_44 (37) = happyShift action_33
action_44 (38) = happyShift action_34
action_44 (39) = happyShift action_35
action_44 (40) = happyShift action_36
action_44 (41) = happyShift action_37
action_44 (63) = happyShift action_38
action_44 (65) = happyShift action_39
action_44 (66) = happyShift action_40
action_44 (67) = happyShift action_41
action_44 (69) = happyShift action_42
action_44 (4) = happyGoto action_133
action_44 (6) = happyGoto action_3
action_44 (7) = happyGoto action_4
action_44 _ = happyReduce_20

action_45 (8) = happyShift action_5
action_45 (9) = happyShift action_6
action_45 (10) = happyShift action_7
action_45 (11) = happyShift action_8
action_45 (12) = happyShift action_9
action_45 (13) = happyShift action_10
action_45 (14) = happyShift action_11
action_45 (15) = happyShift action_12
action_45 (16) = happyShift action_13
action_45 (17) = happyShift action_14
action_45 (18) = happyShift action_15
action_45 (19) = happyShift action_16
action_45 (20) = happyShift action_17
action_45 (21) = happyShift action_18
action_45 (22) = happyShift action_19
action_45 (23) = happyShift action_20
action_45 (24) = happyShift action_21
action_45 (25) = happyShift action_22
action_45 (26) = happyShift action_23
action_45 (27) = happyShift action_24
action_45 (28) = happyShift action_25
action_45 (30) = happyShift action_26
action_45 (31) = happyShift action_27
action_45 (32) = happyShift action_28
action_45 (33) = happyShift action_29
action_45 (34) = happyShift action_30
action_45 (35) = happyShift action_31
action_45 (66) = happyShift action_131
action_45 (67) = happyShift action_87
action_45 (69) = happyShift action_132
action_45 (6) = happyGoto action_130
action_45 (7) = happyGoto action_4
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (8) = happyShift action_5
action_46 (9) = happyShift action_6
action_46 (10) = happyShift action_7
action_46 (11) = happyShift action_8
action_46 (12) = happyShift action_9
action_46 (13) = happyShift action_10
action_46 (14) = happyShift action_11
action_46 (15) = happyShift action_12
action_46 (16) = happyShift action_13
action_46 (17) = happyShift action_14
action_46 (18) = happyShift action_15
action_46 (19) = happyShift action_16
action_46 (20) = happyShift action_17
action_46 (21) = happyShift action_18
action_46 (22) = happyShift action_19
action_46 (23) = happyShift action_20
action_46 (24) = happyShift action_21
action_46 (25) = happyShift action_22
action_46 (26) = happyShift action_23
action_46 (27) = happyShift action_24
action_46 (28) = happyShift action_25
action_46 (30) = happyShift action_26
action_46 (31) = happyShift action_27
action_46 (32) = happyShift action_28
action_46 (33) = happyShift action_29
action_46 (34) = happyShift action_30
action_46 (35) = happyShift action_31
action_46 (66) = happyShift action_40
action_46 (67) = happyShift action_129
action_46 (69) = happyShift action_42
action_46 (6) = happyGoto action_128
action_46 (7) = happyGoto action_4
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (29) = happyShift action_127
action_47 (66) = happyShift action_40
action_47 (67) = happyShift action_87
action_47 (69) = happyShift action_42
action_47 (5) = happyGoto action_125
action_47 (7) = happyGoto action_126
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (42) = happyShift action_124
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (42) = happyShift action_123
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (42) = happyShift action_122
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (42) = happyShift action_121
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (42) = happyShift action_120
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (42) = happyShift action_119
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (66) = happyShift action_40
action_54 (67) = happyShift action_87
action_54 (69) = happyShift action_42
action_54 (7) = happyGoto action_118
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (66) = happyShift action_40
action_55 (67) = happyShift action_87
action_55 (69) = happyShift action_42
action_55 (7) = happyGoto action_117
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (66) = happyShift action_40
action_56 (67) = happyShift action_87
action_56 (69) = happyShift action_42
action_56 (7) = happyGoto action_116
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (66) = happyShift action_40
action_57 (67) = happyShift action_87
action_57 (69) = happyShift action_42
action_57 (7) = happyGoto action_115
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (66) = happyShift action_40
action_58 (67) = happyShift action_87
action_58 (69) = happyShift action_42
action_58 (7) = happyGoto action_114
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (66) = happyShift action_40
action_59 (67) = happyShift action_87
action_59 (69) = happyShift action_42
action_59 (7) = happyGoto action_113
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (66) = happyShift action_40
action_60 (67) = happyShift action_87
action_60 (69) = happyShift action_42
action_60 (7) = happyGoto action_112
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (66) = happyShift action_40
action_61 (67) = happyShift action_87
action_61 (69) = happyShift action_42
action_61 (7) = happyGoto action_111
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (67) = happyShift action_110
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (67) = happyShift action_109
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (67) = happyShift action_108
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (67) = happyShift action_107
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (67) = happyShift action_106
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (67) = happyShift action_105
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (67) = happyShift action_104
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (66) = happyShift action_40
action_69 (67) = happyShift action_87
action_69 (69) = happyShift action_42
action_69 (7) = happyGoto action_103
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (66) = happyShift action_40
action_70 (67) = happyShift action_87
action_70 (69) = happyShift action_42
action_70 (7) = happyGoto action_102
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (67) = happyShift action_101
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (67) = happyShift action_100
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (66) = happyShift action_40
action_73 (67) = happyShift action_87
action_73 (69) = happyShift action_42
action_73 (7) = happyGoto action_99
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (66) = happyShift action_40
action_74 (67) = happyShift action_87
action_74 (69) = happyShift action_42
action_74 (7) = happyGoto action_98
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (67) = happyShift action_97
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (56) = happyShift action_96
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (67) = happyShift action_95
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (67) = happyShift action_94
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (66) = happyShift action_40
action_79 (67) = happyShift action_87
action_79 (69) = happyShift action_42
action_79 (7) = happyGoto action_93
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (66) = happyShift action_40
action_80 (67) = happyShift action_87
action_80 (69) = happyShift action_42
action_80 (7) = happyGoto action_92
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (66) = happyShift action_40
action_81 (67) = happyShift action_87
action_81 (69) = happyShift action_42
action_81 (7) = happyGoto action_91
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (66) = happyShift action_40
action_82 (67) = happyShift action_87
action_82 (69) = happyShift action_42
action_82 (7) = happyGoto action_90
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (66) = happyShift action_40
action_83 (67) = happyShift action_87
action_83 (69) = happyShift action_42
action_83 (7) = happyGoto action_89
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (66) = happyShift action_40
action_84 (67) = happyShift action_87
action_84 (69) = happyShift action_42
action_84 (7) = happyGoto action_88
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (66) = happyShift action_40
action_85 (67) = happyShift action_87
action_85 (69) = happyShift action_42
action_85 (7) = happyGoto action_86
action_85 _ = happyFail (happyExpListPerState 85)

action_86 _ = happyReduce_58

action_87 _ = happyReduce_62

action_88 _ = happyReduce_59

action_89 _ = happyReduce_57

action_90 _ = happyReduce_56

action_91 _ = happyReduce_55

action_92 (54) = happyShift action_180
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (54) = happyShift action_179
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (54) = happyShift action_178
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (54) = happyShift action_177
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (68) = happyShift action_176
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (49) = happyShift action_175
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (54) = happyShift action_174
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (54) = happyShift action_173
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (49) = happyShift action_172
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (49) = happyShift action_171
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (54) = happyShift action_170
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (54) = happyShift action_169
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (49) = happyShift action_168
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (49) = happyShift action_167
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (49) = happyShift action_166
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (54) = happyShift action_165
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (54) = happyShift action_164
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (54) = happyShift action_163
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (54) = happyShift action_162
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (54) = happyShift action_161
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (54) = happyShift action_160
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (54) = happyShift action_159
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (54) = happyShift action_158
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (54) = happyShift action_157
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (49) = happyShift action_156
action_116 _ = happyFail (happyExpListPerState 116)

action_117 (54) = happyShift action_155
action_117 _ = happyFail (happyExpListPerState 117)

action_118 (54) = happyShift action_154
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (8) = happyShift action_5
action_119 (9) = happyShift action_6
action_119 (10) = happyShift action_7
action_119 (11) = happyShift action_8
action_119 (12) = happyShift action_9
action_119 (13) = happyShift action_10
action_119 (14) = happyShift action_11
action_119 (15) = happyShift action_12
action_119 (16) = happyShift action_13
action_119 (17) = happyShift action_14
action_119 (18) = happyShift action_15
action_119 (19) = happyShift action_16
action_119 (20) = happyShift action_17
action_119 (21) = happyShift action_18
action_119 (22) = happyShift action_19
action_119 (23) = happyShift action_20
action_119 (24) = happyShift action_21
action_119 (25) = happyShift action_22
action_119 (26) = happyShift action_23
action_119 (27) = happyShift action_24
action_119 (28) = happyShift action_25
action_119 (30) = happyShift action_26
action_119 (31) = happyShift action_27
action_119 (32) = happyShift action_28
action_119 (33) = happyShift action_29
action_119 (34) = happyShift action_30
action_119 (35) = happyShift action_31
action_119 (66) = happyShift action_153
action_119 (67) = happyShift action_87
action_119 (69) = happyShift action_42
action_119 (6) = happyGoto action_152
action_119 (7) = happyGoto action_4
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (8) = happyShift action_5
action_120 (9) = happyShift action_6
action_120 (10) = happyShift action_7
action_120 (11) = happyShift action_8
action_120 (12) = happyShift action_9
action_120 (13) = happyShift action_10
action_120 (14) = happyShift action_11
action_120 (15) = happyShift action_12
action_120 (16) = happyShift action_13
action_120 (17) = happyShift action_14
action_120 (18) = happyShift action_15
action_120 (19) = happyShift action_16
action_120 (20) = happyShift action_17
action_120 (21) = happyShift action_18
action_120 (22) = happyShift action_19
action_120 (23) = happyShift action_20
action_120 (24) = happyShift action_21
action_120 (25) = happyShift action_22
action_120 (26) = happyShift action_23
action_120 (27) = happyShift action_24
action_120 (28) = happyShift action_25
action_120 (30) = happyShift action_26
action_120 (31) = happyShift action_27
action_120 (32) = happyShift action_28
action_120 (33) = happyShift action_29
action_120 (34) = happyShift action_30
action_120 (35) = happyShift action_31
action_120 (66) = happyShift action_40
action_120 (67) = happyShift action_87
action_120 (69) = happyShift action_151
action_120 (6) = happyGoto action_150
action_120 (7) = happyGoto action_4
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (29) = happyShift action_127
action_121 (66) = happyShift action_40
action_121 (67) = happyShift action_87
action_121 (69) = happyShift action_42
action_121 (5) = happyGoto action_149
action_121 (7) = happyGoto action_126
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (8) = happyShift action_5
action_122 (9) = happyShift action_6
action_122 (10) = happyShift action_7
action_122 (11) = happyShift action_8
action_122 (12) = happyShift action_9
action_122 (13) = happyShift action_10
action_122 (14) = happyShift action_11
action_122 (15) = happyShift action_12
action_122 (16) = happyShift action_13
action_122 (17) = happyShift action_14
action_122 (18) = happyShift action_15
action_122 (19) = happyShift action_16
action_122 (20) = happyShift action_17
action_122 (21) = happyShift action_18
action_122 (22) = happyShift action_19
action_122 (23) = happyShift action_20
action_122 (24) = happyShift action_21
action_122 (25) = happyShift action_22
action_122 (26) = happyShift action_23
action_122 (27) = happyShift action_24
action_122 (28) = happyShift action_25
action_122 (30) = happyShift action_26
action_122 (31) = happyShift action_27
action_122 (32) = happyShift action_28
action_122 (33) = happyShift action_29
action_122 (34) = happyShift action_30
action_122 (35) = happyShift action_31
action_122 (66) = happyShift action_40
action_122 (67) = happyShift action_87
action_122 (69) = happyShift action_42
action_122 (6) = happyGoto action_148
action_122 (7) = happyGoto action_4
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (8) = happyShift action_5
action_123 (9) = happyShift action_6
action_123 (10) = happyShift action_7
action_123 (11) = happyShift action_8
action_123 (12) = happyShift action_9
action_123 (13) = happyShift action_10
action_123 (14) = happyShift action_11
action_123 (15) = happyShift action_12
action_123 (16) = happyShift action_13
action_123 (17) = happyShift action_14
action_123 (18) = happyShift action_15
action_123 (19) = happyShift action_16
action_123 (20) = happyShift action_17
action_123 (21) = happyShift action_18
action_123 (22) = happyShift action_19
action_123 (23) = happyShift action_20
action_123 (24) = happyShift action_21
action_123 (25) = happyShift action_22
action_123 (26) = happyShift action_23
action_123 (27) = happyShift action_24
action_123 (28) = happyShift action_25
action_123 (30) = happyShift action_26
action_123 (31) = happyShift action_27
action_123 (32) = happyShift action_28
action_123 (33) = happyShift action_29
action_123 (34) = happyShift action_30
action_123 (35) = happyShift action_31
action_123 (52) = happyShift action_147
action_123 (66) = happyShift action_40
action_123 (67) = happyShift action_87
action_123 (69) = happyShift action_42
action_123 (6) = happyGoto action_146
action_123 (7) = happyGoto action_4
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (8) = happyShift action_5
action_124 (9) = happyShift action_6
action_124 (10) = happyShift action_7
action_124 (11) = happyShift action_8
action_124 (12) = happyShift action_9
action_124 (13) = happyShift action_10
action_124 (14) = happyShift action_11
action_124 (15) = happyShift action_12
action_124 (16) = happyShift action_13
action_124 (17) = happyShift action_14
action_124 (18) = happyShift action_15
action_124 (19) = happyShift action_16
action_124 (20) = happyShift action_17
action_124 (21) = happyShift action_18
action_124 (22) = happyShift action_19
action_124 (23) = happyShift action_20
action_124 (24) = happyShift action_21
action_124 (25) = happyShift action_22
action_124 (26) = happyShift action_23
action_124 (27) = happyShift action_24
action_124 (28) = happyShift action_25
action_124 (30) = happyShift action_26
action_124 (31) = happyShift action_27
action_124 (32) = happyShift action_28
action_124 (33) = happyShift action_29
action_124 (34) = happyShift action_30
action_124 (35) = happyShift action_31
action_124 (52) = happyShift action_145
action_124 (66) = happyShift action_40
action_124 (67) = happyShift action_87
action_124 (69) = happyShift action_42
action_124 (6) = happyGoto action_144
action_124 (7) = happyGoto action_4
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (49) = happyShift action_143
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (57) = happyShift action_137
action_126 (58) = happyShift action_138
action_126 (59) = happyShift action_139
action_126 (60) = happyShift action_140
action_126 (61) = happyShift action_141
action_126 (62) = happyShift action_142
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (48) = happyShift action_136
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (49) = happyShift action_135
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (49) = happyShift action_134
action_129 _ = happyReduce_62

action_130 _ = happyReduce_7

action_131 (51) = happyReduce_8
action_131 (55) = happyReduce_8
action_131 (70) = happyReduce_8
action_131 _ = happyReduce_60

action_132 (51) = happyReduce_9
action_132 (55) = happyReduce_9
action_132 (70) = happyReduce_9
action_132 _ = happyReduce_61

action_133 (55) = happyShift action_44
action_133 _ = happyReduce_1

action_134 _ = happyReduce_19

action_135 _ = happyReduce_18

action_136 (67) = happyShift action_210
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (66) = happyShift action_40
action_137 (67) = happyShift action_87
action_137 (69) = happyShift action_42
action_137 (7) = happyGoto action_209
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (66) = happyShift action_40
action_138 (67) = happyShift action_87
action_138 (69) = happyShift action_42
action_138 (7) = happyGoto action_208
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (66) = happyShift action_40
action_139 (67) = happyShift action_87
action_139 (69) = happyShift action_42
action_139 (7) = happyGoto action_207
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (66) = happyShift action_40
action_140 (67) = happyShift action_87
action_140 (69) = happyShift action_42
action_140 (7) = happyGoto action_206
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (66) = happyShift action_40
action_141 (67) = happyShift action_87
action_141 (69) = happyShift action_42
action_141 (7) = happyGoto action_205
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (66) = happyShift action_40
action_142 (67) = happyShift action_87
action_142 (69) = happyShift action_42
action_142 (7) = happyGoto action_204
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (50) = happyShift action_203
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_15

action_145 (53) = happyShift action_202
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_13

action_147 (53) = happyShift action_201
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_12

action_149 _ = happyReduce_4

action_150 _ = happyReduce_5

action_151 (51) = happyReduce_6
action_151 (55) = happyReduce_6
action_151 (70) = happyReduce_6
action_151 _ = happyReduce_61

action_152 _ = happyReduce_3

action_153 (51) = happyReduce_2
action_153 (55) = happyReduce_2
action_153 (70) = happyReduce_2
action_153 _ = happyReduce_60

action_154 (66) = happyShift action_40
action_154 (67) = happyShift action_87
action_154 (69) = happyShift action_42
action_154 (7) = happyGoto action_200
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (66) = happyShift action_40
action_155 (67) = happyShift action_87
action_155 (69) = happyShift action_42
action_155 (7) = happyGoto action_199
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_52

action_157 (66) = happyShift action_40
action_157 (67) = happyShift action_87
action_157 (69) = happyShift action_42
action_157 (7) = happyGoto action_198
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (66) = happyShift action_40
action_158 (67) = happyShift action_87
action_158 (69) = happyShift action_42
action_158 (7) = happyGoto action_197
action_158 _ = happyFail (happyExpListPerState 158)

action_159 (66) = happyShift action_40
action_159 (67) = happyShift action_87
action_159 (69) = happyShift action_42
action_159 (7) = happyGoto action_196
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (66) = happyShift action_40
action_160 (67) = happyShift action_87
action_160 (69) = happyShift action_42
action_160 (7) = happyGoto action_195
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (66) = happyShift action_40
action_161 (67) = happyShift action_87
action_161 (69) = happyShift action_42
action_161 (7) = happyGoto action_194
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (67) = happyShift action_193
action_162 _ = happyFail (happyExpListPerState 162)

action_163 (67) = happyShift action_192
action_163 _ = happyFail (happyExpListPerState 163)

action_164 (67) = happyShift action_191
action_164 _ = happyFail (happyExpListPerState 164)

action_165 (67) = happyShift action_190
action_165 _ = happyFail (happyExpListPerState 165)

action_166 _ = happyReduce_42

action_167 _ = happyReduce_41

action_168 _ = happyReduce_40

action_169 (66) = happyShift action_40
action_169 (67) = happyShift action_87
action_169 (69) = happyShift action_42
action_169 (7) = happyGoto action_189
action_169 _ = happyFail (happyExpListPerState 169)

action_170 (66) = happyShift action_40
action_170 (67) = happyShift action_87
action_170 (69) = happyShift action_42
action_170 (7) = happyGoto action_188
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_37

action_172 _ = happyReduce_36

action_173 (66) = happyShift action_40
action_173 (67) = happyShift action_87
action_173 (69) = happyShift action_42
action_173 (7) = happyGoto action_187
action_173 _ = happyFail (happyExpListPerState 173)

action_174 (66) = happyShift action_40
action_174 (67) = happyShift action_87
action_174 (69) = happyShift action_42
action_174 (7) = happyGoto action_186
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_33

action_176 (56) = happyShift action_185
action_176 _ = happyFail (happyExpListPerState 176)

action_177 (67) = happyShift action_184
action_177 _ = happyFail (happyExpListPerState 177)

action_178 (67) = happyShift action_183
action_178 _ = happyFail (happyExpListPerState 178)

action_179 (66) = happyShift action_40
action_179 (67) = happyShift action_87
action_179 (69) = happyShift action_42
action_179 (7) = happyGoto action_182
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (66) = happyShift action_40
action_180 (67) = happyShift action_87
action_180 (69) = happyShift action_42
action_180 (7) = happyGoto action_181
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (49) = happyShift action_232
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (49) = happyShift action_231
action_182 _ = happyFail (happyExpListPerState 182)

action_183 (49) = happyShift action_230
action_183 _ = happyFail (happyExpListPerState 183)

action_184 (49) = happyShift action_229
action_184 _ = happyFail (happyExpListPerState 184)

action_185 (49) = happyShift action_228
action_185 _ = happyFail (happyExpListPerState 185)

action_186 (49) = happyShift action_227
action_186 _ = happyFail (happyExpListPerState 186)

action_187 (49) = happyShift action_226
action_187 _ = happyFail (happyExpListPerState 187)

action_188 (49) = happyShift action_225
action_188 _ = happyFail (happyExpListPerState 188)

action_189 (54) = happyShift action_224
action_189 _ = happyFail (happyExpListPerState 189)

action_190 (49) = happyShift action_223
action_190 _ = happyFail (happyExpListPerState 190)

action_191 (49) = happyShift action_222
action_191 _ = happyFail (happyExpListPerState 191)

action_192 (49) = happyShift action_221
action_192 _ = happyFail (happyExpListPerState 192)

action_193 (49) = happyShift action_220
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (49) = happyShift action_219
action_194 _ = happyFail (happyExpListPerState 194)

action_195 (49) = happyShift action_218
action_195 _ = happyFail (happyExpListPerState 195)

action_196 (54) = happyShift action_217
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (54) = happyShift action_216
action_197 _ = happyFail (happyExpListPerState 197)

action_198 (49) = happyShift action_215
action_198 _ = happyFail (happyExpListPerState 198)

action_199 (49) = happyShift action_214
action_199 _ = happyFail (happyExpListPerState 199)

action_200 (49) = happyShift action_213
action_200 _ = happyFail (happyExpListPerState 200)

action_201 _ = happyReduce_11

action_202 _ = happyReduce_14

action_203 (8) = happyShift action_5
action_203 (9) = happyShift action_6
action_203 (10) = happyShift action_7
action_203 (11) = happyShift action_8
action_203 (12) = happyShift action_9
action_203 (13) = happyShift action_10
action_203 (14) = happyShift action_11
action_203 (15) = happyShift action_12
action_203 (16) = happyShift action_13
action_203 (17) = happyShift action_14
action_203 (18) = happyShift action_15
action_203 (19) = happyShift action_16
action_203 (20) = happyShift action_17
action_203 (21) = happyShift action_18
action_203 (22) = happyShift action_19
action_203 (23) = happyShift action_20
action_203 (24) = happyShift action_21
action_203 (25) = happyShift action_22
action_203 (26) = happyShift action_23
action_203 (27) = happyShift action_24
action_203 (28) = happyShift action_25
action_203 (30) = happyShift action_26
action_203 (31) = happyShift action_27
action_203 (32) = happyShift action_28
action_203 (33) = happyShift action_29
action_203 (34) = happyShift action_30
action_203 (35) = happyShift action_31
action_203 (36) = happyShift action_32
action_203 (37) = happyShift action_33
action_203 (38) = happyShift action_34
action_203 (39) = happyShift action_35
action_203 (40) = happyShift action_36
action_203 (41) = happyShift action_37
action_203 (63) = happyShift action_38
action_203 (65) = happyShift action_39
action_203 (66) = happyShift action_40
action_203 (67) = happyShift action_41
action_203 (69) = happyShift action_42
action_203 (4) = happyGoto action_212
action_203 (6) = happyGoto action_3
action_203 (7) = happyGoto action_4
action_203 _ = happyFail (happyExpListPerState 203)

action_204 _ = happyReduce_26

action_205 _ = happyReduce_25

action_206 _ = happyReduce_24

action_207 _ = happyReduce_23

action_208 _ = happyReduce_22

action_209 _ = happyReduce_21

action_210 (54) = happyShift action_211
action_210 _ = happyFail (happyExpListPerState 210)

action_211 (67) = happyShift action_237
action_211 _ = happyFail (happyExpListPerState 211)

action_212 (51) = happyShift action_236
action_212 (55) = happyShift action_44
action_212 _ = happyFail (happyExpListPerState 212)

action_213 _ = happyReduce_54

action_214 _ = happyReduce_53

action_215 _ = happyReduce_51

action_216 (66) = happyShift action_40
action_216 (67) = happyShift action_87
action_216 (69) = happyShift action_42
action_216 (7) = happyGoto action_235
action_216 _ = happyFail (happyExpListPerState 216)

action_217 (66) = happyShift action_40
action_217 (67) = happyShift action_87
action_217 (69) = happyShift action_42
action_217 (7) = happyGoto action_234
action_217 _ = happyFail (happyExpListPerState 217)

action_218 _ = happyReduce_48

action_219 _ = happyReduce_47

action_220 _ = happyReduce_46

action_221 _ = happyReduce_45

action_222 _ = happyReduce_44

action_223 _ = happyReduce_43

action_224 (66) = happyShift action_40
action_224 (67) = happyShift action_87
action_224 (69) = happyShift action_42
action_224 (7) = happyGoto action_233
action_224 _ = happyFail (happyExpListPerState 224)

action_225 _ = happyReduce_38

action_226 _ = happyReduce_35

action_227 _ = happyReduce_34

action_228 _ = happyReduce_32

action_229 _ = happyReduce_31

action_230 _ = happyReduce_30

action_231 _ = happyReduce_29

action_232 _ = happyReduce_28

action_233 (49) = happyShift action_242
action_233 _ = happyFail (happyExpListPerState 233)

action_234 (49) = happyShift action_241
action_234 _ = happyFail (happyExpListPerState 234)

action_235 (49) = happyShift action_240
action_235 _ = happyFail (happyExpListPerState 235)

action_236 (64) = happyShift action_239
action_236 _ = happyReduce_17

action_237 (49) = happyShift action_238
action_237 _ = happyFail (happyExpListPerState 237)

action_238 _ = happyReduce_27

action_239 (50) = happyShift action_243
action_239 _ = happyFail (happyExpListPerState 239)

action_240 _ = happyReduce_50

action_241 _ = happyReduce_49

action_242 _ = happyReduce_39

action_243 (8) = happyShift action_5
action_243 (9) = happyShift action_6
action_243 (10) = happyShift action_7
action_243 (11) = happyShift action_8
action_243 (12) = happyShift action_9
action_243 (13) = happyShift action_10
action_243 (14) = happyShift action_11
action_243 (15) = happyShift action_12
action_243 (16) = happyShift action_13
action_243 (17) = happyShift action_14
action_243 (18) = happyShift action_15
action_243 (19) = happyShift action_16
action_243 (20) = happyShift action_17
action_243 (21) = happyShift action_18
action_243 (22) = happyShift action_19
action_243 (23) = happyShift action_20
action_243 (24) = happyShift action_21
action_243 (25) = happyShift action_22
action_243 (26) = happyShift action_23
action_243 (27) = happyShift action_24
action_243 (28) = happyShift action_25
action_243 (30) = happyShift action_26
action_243 (31) = happyShift action_27
action_243 (32) = happyShift action_28
action_243 (33) = happyShift action_29
action_243 (34) = happyShift action_30
action_243 (35) = happyShift action_31
action_243 (36) = happyShift action_32
action_243 (37) = happyShift action_33
action_243 (38) = happyShift action_34
action_243 (39) = happyShift action_35
action_243 (40) = happyShift action_36
action_243 (41) = happyShift action_37
action_243 (63) = happyShift action_38
action_243 (65) = happyShift action_39
action_243 (66) = happyShift action_40
action_243 (67) = happyShift action_41
action_243 (69) = happyShift action_42
action_243 (4) = happyGoto action_244
action_243 (6) = happyGoto action_3
action_243 (7) = happyGoto action_4
action_243 _ = happyFail (happyExpListPerState 243)

action_244 (51) = happyShift action_245
action_244 (55) = happyShift action_44
action_244 _ = happyFail (happyExpListPerState 244)

action_245 _ = happyReduce_16

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (SEQ happy_var_1 happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happyReduce 4 4 happyReduction_2
happyReduction_2 ((HappyTerminal (TokenNumber _ happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_INT_WITH_NUMBER happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_3 = happyReduce 4 4 happyReduction_3
happyReduction_3 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_INT happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 4 4 happyReduction_4
happyReduction_4 ((HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_BOOL happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 4 4 happyReduction_5
happyReduction_5 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_STRING happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 4 happyReduction_6
happyReduction_6 ((HappyTerminal (TokenNumbersAsString _ happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECALRE_STRING_WITH_QUOTES happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_3  4 happyReduction_7
happyReduction_7 (HappyAbsSyn6  happy_var_3)
	_
	(HappyTerminal (TokenVarName _ happy_var_1))
	 =  HappyAbsSyn4
		 (OVERWRITE happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  4 happyReduction_8
happyReduction_8 (HappyTerminal (TokenNumber _ happy_var_3))
	_
	(HappyTerminal (TokenVarName _ happy_var_1))
	 =  HappyAbsSyn4
		 (OVERWRITE_NUMBER happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  4 happyReduction_9
happyReduction_9 (HappyTerminal (TokenNumbersAsString _ happy_var_3))
	_
	(HappyTerminal (TokenVarName _ happy_var_1))
	 =  HappyAbsSyn4
		 (OVERWRITE_WITH_QUOTES happy_var_1 happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  4 happyReduction_10
happyReduction_10 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn4
		 (FUNCTION_CALL happy_var_1
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happyReduce 5 4 happyReduction_11
happyReduction_11 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_LIST_STRING_EMPTY happy_var_2
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 4 4 happyReduction_12
happyReduction_12 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_LIST_INT happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 4 happyReduction_13
happyReduction_13 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_LIST_STRING happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_14 = happyReduce 5 4 happyReduction_14
happyReduction_14 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_LIST_LIST_STRING_EMPTY happy_var_2
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 4 4 happyReduction_15
happyReduction_15 ((HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (DECLARE_LIST_LIST_STRING happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_16 = happyReduce 11 4 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (ELSEIF happy_var_3 happy_var_6 happy_var_10
	) `HappyStk` happyRest

happyReduce_17 = happyReduce 7 4 happyReduction_17
happyReduction_17 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (IF happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_18 = happyReduce 4 4 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (PRINT happy_var_3
	) `HappyStk` happyRest

happyReduce_19 = happyReduce 4 4 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (PRINT_VAR happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_2  4 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (LAST_ACTION_CALLED happy_var_1
	)
happyReduction_20 _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  5 happyReduction_21
happyReduction_21 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (LESS_THAN happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  5 happyReduction_22
happyReduction_22 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (GREATER_THAN happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  5 happyReduction_23
happyReduction_23 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (COMPARE_EQUAL happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  5 happyReduction_24
happyReduction_24 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (LESS_THAN_OR_EQUAL happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  5 happyReduction_25
happyReduction_25 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (GREATER_THAN_OR_EQUAL happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  5 happyReduction_26
happyReduction_26 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn5
		 (NOT_EQUAL happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happyReduce 6 5 happyReduction_27
happyReduction_27 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (EQUAL_TILES happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_28 = happyReduce 6 6 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REPEAT_HORZ happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_29 = happyReduce 6 6 happyReduction_29
happyReduction_29 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REPEAT_VERT happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_30 = happyReduce 6 6 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ADD_HORZ happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_31 = happyReduce 6 6 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ADD_VERT happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_32 = happyReduce 6 6 happyReduction_32
happyReduction_32 (_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenFileName _ happy_var_4)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (READ_FILE happy_var_4
	) `HappyStk` happyRest

happyReduce_33 = happyReduce 4 6 happyReduction_33
happyReduction_33 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ROTATE happy_var_3
	) `HappyStk` happyRest

happyReduce_34 = happyReduce 6 6 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (SCALE happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_35 = happyReduce 6 6 happyReduction_35
happyReduction_35 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (MAKE_TILE happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_36 = happyReduce 4 6 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REFLECT_VERT happy_var_3
	) `HappyStk` happyRest

happyReduce_37 = happyReduce 4 6 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REFLECT_HORZ happy_var_3
	) `HappyStk` happyRest

happyReduce_38 = happyReduce 6 6 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (GET_BY_INDEX happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_39 = happyReduce 8 6 happyReduction_39
happyReduction_39 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (SUBTILES happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_40 = happyReduce 4 6 happyReduction_40
happyReduction_40 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (GET_ROW_COUNT happy_var_3
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 4 6 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (GET_COL_COUNT happy_var_3
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 4 6 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (NEGATION happy_var_3
	) `HappyStk` happyRest

happyReduce_43 = happyReduce 6 6 happyReduction_43
happyReduction_43 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CONJUNCTION happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_44 = happyReduce 6 6 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DISJUNCTION happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_45 = happyReduce 6 6 happyReduction_45
happyReduction_45 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (IMPLICATION happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_46 = happyReduce 6 6 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenVarName _ happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (XOR happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_47 = happyReduce 6 6 happyReduction_47
happyReduction_47 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (MAKE_TRIANGLE_UP happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_48 = happyReduce 6 6 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (MAKE_TRIANGLE_DOWN happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_49 = happyReduce 8 6 happyReduction_49
happyReduction_49 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (SUBLIST happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_50 = happyReduce 8 6 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REPLACE_IN_ROW happy_var_3 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_51 = happyReduce 6 6 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CONCAT_STRINGS happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_52 = happyReduce 4 6 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REVERSE_LIST happy_var_3
	) `HappyStk` happyRest

happyReduce_53 = happyReduce 6 6 happyReduction_53
happyReduction_53 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (ADD_TO_LIST happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_54 = happyReduce 6 6 happyReduction_54
happyReduction_54 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (REMOVE_FROM_LIST happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_55 = happySpecReduce_3  6 happyReduction_55
happyReduction_55 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Plus happy_var_1 happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  6 happyReduction_56
happyReduction_56 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Minus happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  6 happyReduction_57
happyReduction_57 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Times happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  6 happyReduction_58
happyReduction_58 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Div happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  6 happyReduction_59
happyReduction_59 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 (Expo happy_var_1 happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  7 happyReduction_60
happyReduction_60 (HappyTerminal (TokenNumber _ happy_var_1))
	 =  HappyAbsSyn7
		 (PARAMETER_INT happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  7 happyReduction_61
happyReduction_61 (HappyTerminal (TokenNumbersAsString _ happy_var_1))
	 =  HappyAbsSyn7
		 (PARAMETER_STRING_QUOTES happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  7 happyReduction_62
happyReduction_62 (HappyTerminal (TokenVarName _ happy_var_1))
	 =  HappyAbsSyn7
		 (PARAMETER_STRING happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 70 70 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenREPEAT_HORZ _ -> cont 8;
	TokenREPEAT_VERT _ -> cont 9;
	TokenADD_HORZ _ -> cont 10;
	TokenADD_VERT _ -> cont 11;
	TokenREAD_FILE _ -> cont 12;
	TokenROTATE _ -> cont 13;
	TokenSCALE _ -> cont 14;
	TokenMAKE_TILE _ -> cont 15;
	TokenREFLECT_VERT _ -> cont 16;
	TokenREFLECT_HORZ _ -> cont 17;
	TokenGET_BY_INDEX _ -> cont 18;
	TokenSUBTILES _ -> cont 19;
	TokenGET_ROW_COUNT _ -> cont 20;
	TokenGET_COL_COUNT _ -> cont 21;
	TokenNEGATION _ -> cont 22;
	TokenCONJUNCTION _ -> cont 23;
	TokenDISJUNCTION _ -> cont 24;
	TokenIMPLICATION _ -> cont 25;
	TokenXOR _ -> cont 26;
	TokenMAKE_TRIANGLE_UP _ -> cont 27;
	TokenMAKE_TRIANGLE_DOWN _ -> cont 28;
	TokenEQUAL_TILES _ -> cont 29;
	TokenSUBLIST _ -> cont 30;
	TokenREPLACE_IN_ROW _ -> cont 31;
	TokenCONCAT_STRINGS _ -> cont 32;
	TokenREVERSE_LIST _ -> cont 33;
	TokenADD_TO_LIST _ -> cont 34;
	TokenREMOVE_FROM_LIST _ -> cont 35;
	TokenInt _ -> cont 36;
	TokenString _ -> cont 37;
	TokenBool _ -> cont 38;
	TokenListInt _ -> cont 39;
	TokenListString _ -> cont 40;
	TokenListListString _ -> cont 41;
	TokenEq _ -> cont 42;
	TokenPlus _ -> cont 43;
	TokenMinus _ -> cont 44;
	TokenTimes _ -> cont 45;
	TokenExp  _ -> cont 46;
	TokenDiv _ -> cont 47;
	TokenLParen _ -> cont 48;
	TokenRParen _ -> cont 49;
	TokenLBraket _ -> cont 50;
	TokenRBraket _ -> cont 51;
	TokenLSquareBraket _ -> cont 52;
	TokenRSquareBraket _ -> cont 53;
	TokenComma _ -> cont 54;
	TokenSemiColon _ -> cont 55;
	TokenQuote _ -> cont 56;
	TokenLessThan _ -> cont 57;
	TokenGreaterThan _ -> cont 58;
	TokenCompareEqual _ -> cont 59;
	TokenLessThanOrEqual _ -> cont 60;
	TokenGreaterThanOrEqual _ -> cont 61;
	TokenNotEqual _ -> cont 62;
	TokenIf _ -> cont 63;
	TokenElse _ -> cont 64;
	TokenPrint _ -> cont 65;
	TokenNumber _ happy_dollar_dollar -> cont 66;
	TokenVarName _ happy_dollar_dollar -> cont 67;
	TokenFileName _ happy_dollar_dollar -> cont 68;
	TokenNumbersAsString _ happy_dollar_dollar -> cont 69;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 70 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(HasktileToken)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parseCalc tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


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
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
