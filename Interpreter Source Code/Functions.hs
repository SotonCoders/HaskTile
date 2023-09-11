module Functions (module Functions) where

import Data.List
import HasktileGrammar
import HasktileTokens


-- Common:
prettyPrint :: [String] -> IO ()
prettyPrint = putStr . unlines

getStringFromArray :: [String] -> String
getStringFromArray [] = []
getStringFromArray (x:[]) = x
getStringFromArray (x:xs) = x ++ "\n" ++ getStringFromArray xs

-- Function that checks for Illegal Inputs
validTile :: [String] -> Bool
validTile xs | length ys == length xs = validTileHelper xs
             | otherwise = False
    where ys = filter (\x -> validLineHelper x) xs

validLineHelper :: String -> Bool
validLineHelper [] = True
validLineHelper ('0':xs) = validLineHelper xs
validLineHelper ('1':xs) = validLineHelper xs
validLineHelper (x:xs) = False

validTileHelper :: [String] -> Bool
validTileHelper [] = True
validTileHelper xs = length (head xs) == length ys
    where ys = filter (== length (head xs)) [length x | x <- xs] 


-- Problem 1
getRowCount :: [String] -> Int
getRowCount xs | validTile xs = length xs
               | otherwise = error "Invalid tile passed as input to GET_ROW_COUNT function. "

getColCount :: [String] -> Int
getColCount [] = 0
getColCount xs | validTile xs = length (head $ xs)
               | otherwise = error "Invalid tile passed as input to GET_COL_COUNT function. "

addHorizontal :: [String] -> [String] -> [String]
addHorizontal xs [] = xs
addHorizontal [] ys = ys
addHorizontal (x:xs) (y:ys) = (x ++ y) : addHorizontal xs ys

addVertical :: [String] -> [String] -> [String]
addVertical xs ys = xs ++ ys

repeatHorizontal :: [String] -> Int -> [String] -> [HasktileToken] -> [String]
repeatHorizontal xs 0 acc tokens = acc
repeatHorizontal xs n acc tokens | n < 0 = error ("Error: Cannot repeat tile for (n < 0) times. " ++ (tokenPosn (head tokens)))
                          | otherwise = repeatHorizontal xs (n - 1) ((addHorizontal acc xs)) tokens

repeatVertical :: [String] -> Int -> [String] -> [HasktileToken] -> [String]
repeatVertical xs 0 acc tokens = acc
repeatVertical xs n acc tokens | n < 0 = error ("Error: Cannot repeat tile for (n < 0) times. " ++ (tokenPosn (head tokens)))
                        | otherwise = repeatVertical xs (n - 1) (acc ++ xs) tokens 


-- Problem 2
rotate90 :: [String] -> [String]
rotate90 xs | validTile xs = rotate90Helper (reverse xs)
            | otherwise = error "Invalid tile passed as input to ROTATE function. "

rotate90Helper :: [String] -> [String]
rotate90Helper xs | emptyStrings xs = [] 
                  | otherwise = [head x | x <- xs] : rotate90Helper [tail x | x <- xs]
    where emptyStrings xs = and [x == "" | x <- xs]

scale :: [String] -> Int -> [HasktileToken] -> [String]
scale xs 0 tokens = xs
scale xs 1 tokens = xs
scale xs n tokens | n < 0 = error ("Error: Cannot SCALE tile (n < 0) times. " ++ (tokenPosn (head tokens)))
           | otherwise = concat [repeatVertical [scaledLine x] n [] tokens| x <- xs]
    where scaledLine x = concat (scaleLine x n)

scaleLine :: String -> Int -> [String]
scaleLine xs n = [repeatChar x n | x <- xs]

repeatChar :: Char -> Int -> String
repeatChar c 0 = []
repeatChar c n = c : repeatChar c (n - 1)


-- Problem 3
reflectVertical :: [String] -> [String]
reflectVertical xs = [reverse x | x <- xs]

reflectHorizontal :: [String] -> [String]
reflectHorizontal xs = reverse xs

makeTile :: Char -> Int -> [HasktileToken] -> [String]
makeTile c 0 tokens = []
makeTile c n tokens | n < 0 = error ("Error: Cannot MAKE_TILE of size (n < 0). " ++ (tokenPosn (head tokens)))
             | otherwise = repeatVertical [line] n [] tokens
    where line = makeLine c n

makeLine :: Char -> Int -> String
makeLine c 0 = []
makeLine c n = c : makeLine c (n - 1)


-- Problem 4

negation :: [String] -> [String]
negation [] = []
negation (x:xs) = negateLine x : negation xs

negateLine :: String -> String
negateLine [] = []
negateLine ('1':xs) = '0' : negateLine xs
negateLine ('0':xs) = '1' : negateLine xs

conjunction :: [String] -> [String] -> [HasktileToken] -> [String]
conjunction [] [] tokens = [] 
conjunction xs [] tokens = error ("Tiles of unequal size passed as input for CONJUNCTION function. " ++ (tokenPosn (head tokens)))
conjunction [] ys tokens = error ("Tiles of unequal size passed as input for CONJUNCTION function. " ++ (tokenPosn (head tokens)))
conjunction (x:xs) (y:ys) tokens = conjunctionLine x y : conjunction xs ys tokens

conjunctionLine :: String -> String -> String
conjunctionLine [] [] = []
conjunctionLine xs [] = error "Tiles of unequal size passed as input for CONJUNCTION function. "
conjunctionLine [] ys = error "Tiles of unequal size passed as input for CONJUNCTION function. "
conjunctionLine ('1':xs) ('1':ys) = '1' : conjunctionLine xs ys
conjunctionLine (x:xs) (y:ys) = '0' : conjunctionLine xs ys

makeTriangleUp :: [String] -> Int -> Int -> [HasktileToken] -> [String]
makeTriangleUp tile size acc tokens | (size < 0) || (acc < 0) = error ("Negative numbers passed as input to function MAKE_TRIANGLE_UP. " ++ (tokenPosn (head tokens)))
makeTriangleUp tile size acc tokens | acc == size = []
                             | otherwise = repeatHorizontal tile acc [] tokens ++ makeTriangleUp tile size (acc + 1) tokens

makeTriangleDown :: [String] -> Int -> [HasktileToken] -> [String]
makeTriangleDown tile size tokens | size < 0 = error ("Negative numbers passed as input to function MAKE_TRIANGLE_DOWN. " ++ (tokenPosn (head tokens)))
makeTriangleDown tile size tokens| size == 0 = []
                           | otherwise = repeatHorizontal tile size [] tokens ++ makeTriangleDown tile (size - 1) tokens


-- Problem 5
subtiles :: [String] -> Int -> Int -> [HasktileToken] -> [[String]]
subtiles xs size n tokens | (size < 0) || (n <= 0) || (size < n) || (size > length xs) = error ("Invalid numbers passed as input to function SUBTILES." ++ (tokenPosn (head tokens)))
subtiles xs size n tokens | validTile xs = subtilesHelper xs size (getStarts size n tokens)
                   | otherwise = error ("Invalid tile passed as input to function SUBTILES. " ++ (tokenPosn (head tokens)))

subtilesHelper :: [String] -> Int -> [Int] -> [[String]]
subtilesHelper xs size [] = []
subtilesHelper xs size (start:starts) = oneSubtile xs start (start + size - 1) : subtilesHelper xs size starts

oneSubtile :: [String] -> Int -> Int -> [String]
oneSubtile xs start end = [subtileLine (xs !! n) start end | n <- [start..end]]

subtileLine :: String -> Int -> Int -> String
subtileLine xs start end = [xs !! n | n <- [start..end]]

getStarts :: Int -> Int -> [HasktileToken] -> [Int]
getStarts size n tokens | (size < 0) || (n <= 0) || (size < n) = error "Invalid numbers passed as input to function GET_STARTS."
getStarts size n tokens = filter (\x -> mod x (div size n) == 0) [0..size-1]

getByIndex :: [a] -> Int -> [HasktileToken] -> a
getByIndex xs n tokens | n < 0 = error ("Negative index passed as input to function GET_BY_INDEX. " ++ (tokenPosn (head tokens)))
                | length xs <= n = error ("Index larger than list size passed as input to function GET_BY_INDEX. " ++ (tokenPosn (head tokens)))
                | otherwise = xs !! n


-- Extension: Boolean operations on tiles:
disjunction :: [String] -> [String] -> [HasktileToken] -> [String]
disjunction [] [] tokens = []
disjunction xs [] tokens = error ("Tiles of unequal size passed as input for DISJUNCTION function. " ++ (tokenPosn (head tokens)))
disjunction [] ys tokens = error ("Tiles of unequal size passed as input for DISJUNCTION function. " ++ (tokenPosn (head tokens)))
disjunction (x:xs) (y:ys) tokens = disjunctionLine x y : disjunction xs ys tokens

disjunctionLine :: String -> String -> String
disjunctionLine [] [] = []
disjunctionLine xs [] = error "Tiles of unequal size passed as input for DISJUNCTION function."
disjunctionLine [] ys = error "Tiles of unequal size passed as input for DISJUNCTION function."
disjunctionLine ('0':xs) ('0':ys) = '0' : disjunctionLine xs ys
disjunctionLine (x:xs) (y:ys) = '1' : disjunctionLine xs ys

implication :: [String] -> [String] -> [HasktileToken] -> [String]
implication [] [] tokens = []
implication xs [] tokens = error ("Tiles of unequal size passed as input for IMPLICATION function. " ++ (tokenPosn (head tokens)))
implication [] ys tokens = error ("Tiles of unequal size passed as input for IMPLICATION function. "++ (tokenPosn (head tokens)))
implication (x:xs) (y:ys) tokens = implicationLine x y : implication xs ys tokens

implicationLine :: String -> String -> String
implicationLine [] [] = []
implicationLine xs [] = error "Tiles of unequal size passed as input for IMPLICATION function. "
implicationLine [] ys = error "Tiles of unequal size passed as input for IMPLICATION function. "
implicationLine ('1':xs) ('0':ys) = '0' : implicationLine xs ys
implicationLine (x:xs) (y:ys) = '1' : implicationLine xs ys

xor :: [String] -> [String] -> [HasktileToken] -> [String]
xor [] [] tokens = []
xor xs [] tokens = error ("Tiles of unequal size passed as input for XOR function. " ++ (tokenPosn (head tokens)))
xor [] ys tokens = error ("Tiles of unequal size passed as input for XOR function. " ++ (tokenPosn (head tokens)))
xor (x:xs) (y:ys) tokens = xorLine x y : xor xs ys tokens

xorLine :: String -> String -> String
xorLine [] [] = []
xorLine xs [] = error "Tiles of unequal size passed as input for XOR function."
xorLine [] ys = error "Tiles of unequal size passed as input for XOR function."
xorLine ('1':xs) ('0':ys) = '1' : xorLine xs ys
xorLine ('0':xs) ('1':ys) = '1' : xorLine xs ys
xorLine (x:xs) (y:ys) = '0' : xorLine xs ys


-- Extension: function that checks whether 2 tiles are equal:
equalTiles :: [String] -> [String] -> Bool
equalTiles [] [] = True
equalTiles xs [] = False
equalTiles [] ys = False
equalTiles (x:xs) (y:ys) | x == y = equalTiles xs ys
                         | otherwise = False


-- Extension: functions for managing lists:
addToList :: [a] -> a -> [a]
addToList xs x = xs ++ [x]

removeFromList :: Eq a => [a] -> a -> [a]
removeFromList xs str = filter (/= str) xs

reverseList :: [a] -> [a]
reverseList = reverse


-- Extension: String concatenation:
concatStrings :: String -> String -> String
concatStrings xs ys = xs ++ ys


-- Functions for replacements in tiles:
subList :: [a] -> Int -> Int -> [a]
subList [] start end = error "Cannot sub-list an empty list."
subList xs start end | start > end || end > length xs = error "Invalid numbers input to function SUBLIST."
                     | otherwise = drop (start - 1) (take end xs)

replaceInRow :: [String] -> [String] -> Int -> [String]
replaceInRow [] subtile col = error "Cannot replace in empty row."
replaceInRow xs subtile col | length subtile > length xs = error "Subtile length is less than length of tile."
                            | col > length (xs !! 0) = error "Invalid number input to function REPLACE_IN_ROW."
                            | otherwise = [replaceInLine (xs !! n) (subtile !! n) col | n <- [0..(length xs - 1)]]

replaceInLine :: String -> String -> Int -> String
replaceInLine xs subline col = (take (col) xs) ++ subline ++ drop (col + (length subline)) xs
