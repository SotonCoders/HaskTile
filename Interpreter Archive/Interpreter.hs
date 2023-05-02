import HasktileTokens
import HasktileGrammar
import System.Environment ( getArgs )
import Control.Exception
import System.IO
import Functions
import Data.Map as Map
import Data.Char
import System.Posix (stdError)
import HasktileGrammar (FunctionsLibrary(CONCAT_STRINGS))
import System.Timeout (timeout)
import Functions (removeFromList)



main :: IO ()
-- main = catch main' noParse
main = do
  result <- timeout (60 * 1000000) $ do
    catch main' noParse
    return ()
  case result of
    Just _  -> return ()
    Nothing -> error "Compilation timed out!"


main' = do (fileName : _ ) <- getArgs 
           sourceText <- readFile fileName
           let parsedProg = parseCalc (alexScanTokens sourceText)
           outputMap <- evalProg parsedProg Map.empty (alexScanTokens sourceText) >>= return . fst

           
           return()

noParse :: ErrorCall -> IO ()
noParse e = do let err =  show e
               hPutStr stderr err
               return ()


type VarName = String

data VarValue = Bool Bool | String String | StrStrList [[String]] | Integer Int | StrList [String] deriving (Eq)

instance Show VarValue where
  show (StrList strings) = show strings


output :: IO (Map.Map VarName VarValue) -> IO [String]
output varMapIO = do
    varMap <- varMapIO
    let ourRes = case Map.lookup "return" varMap of
                   Just (StrList strings) -> strings
                   _ -> []
    return ourRes

    



evalProg :: Prog -> Map.Map VarName VarValue -> [HasktileToken] -> IO ((Map.Map VarName VarValue),[HasktileToken])
evalProg (SEQ prog1 prog2) varMap tokens = do
    (varMap',updated_tokens) <- (evalProg prog1 varMap tokens)
    evalProg prog2 varMap' (updated_tokens)
    



evalProg (LAST_ACTION_CALLED prog) varMap tokens= do
    evalProg prog varMap (tokens)



                        

evalProg (FUNCTION_CALL func) varMap tokens = do
    (StrList value,updated_tokens) <- evalFunction func varMap (tokens)
    return (varMap, updated_tokens)
    

    


evalProg (DECLARE_LIST_STRING var function) varMap tokens = do
    (value,updated_tokens) <- evalFunction function varMap ( tail (tail (tail(tokens))))
    case value of 
        StrList strListValue -> return (Map.insert var value varMap, updated_tokens)
        _ -> error ("Expected a List_String value for DECLARE_LIST_STRING " ++ (tokenPosn (head tokens)))

evalProg (DECLARE_STRING var function) varMap tokens = do
    (value,updated_tokens) <- evalFunction function varMap (tail (tail (tail(tokens))))
    case value of 
        String stringValue -> return (Map.insert var value varMap, updated_tokens)
        _ -> error ("Expected a String value for DECLARE_STRING " ++ (tokenPosn (head tokens)))

evalProg (DECALRE_STRING_WITH_QUOTES var string) varMap tokens = do
    let string1 = init (tail string)
    return (Map.insert var (String string1) varMap, (tail(tail(tail(tail(tail(tokens)))))))





evalProg (DECLARE_INT var function) varMap tokens= do
    (value,updated_tokens) <- evalFunction function varMap (tail(tail(tail tokens)))
    case value of
        Integer intVal -> return (Map.insert var value varMap, updated_tokens)
        _ -> error ("Expected an integer value for DECLARE_INT " ++ (tokenPosn (head tokens)))


evalProg (DECLARE_INT_WITH_NUMBER var int) varMap tokens= do
    return (Map.insert var (Integer int) varMap, (tail(tail(tail(tail(tail tokens))))))


evalProg (DECLARE_LIST_LIST_STRING var function) varMap tokens= do
    (value,newTokens) <- evalFunction function varMap (tail(tail(tail(tokens))))
    case value of
        StrStrList strStrVal -> return (Map.insert var value varMap, newTokens)
        _ -> error ("Expected an List_List_String value for DECLARE_LIST_LIST_STRING " ++ (tokenPosn (head tokens)))


evalProg(DECLARE_LIST_STRING_EMPTY var) varMap tokens = do
    return (Map.insert var (StrList []) varMap, (tail(tail(tail(tail(tail(tail(tokens))))))))

evalProg(DECLARE_LIST_LIST_STRING_EMPTY var) varMap tokens = do
    return (Map.insert var (StrStrList [[]]) varMap, (tail(tail(tail(tail(tail(tail(tokens))))))))

evalProg(PRINT func) varMap tokens = do
    (value,newTokens) <- evalFunction func varMap (tail(tail(tokens)))
    case value of
        StrList strListVal -> prettyPrint strListVal
        _ -> error ("Cannot print a non StrList value " ++ (tokenPosn (head tokens)))
    return (varMap, tail(tail(newTokens)))


evalProg(PRINT_VAR varName) varMap tokens = do
    let value = Map.lookup varName varMap
    case value of 
        (Just(StrList strListVal)) -> (prettyPrint strListVal)
        (Just(String strList)) -> putStrLn strList 
        (Just(Integer int)) -> putStrLn (show int)
        Nothing -> error ("Variable is not defined "  ++ (tokenPosn (head tokens)))
        _ -> error ("Cannot print a non StrList value " ++ (tokenPosn (head tokens)))
    return (varMap, (tail(tail(tail(tail(tail(tokens)))))))




evalProg(IF cond prog) varMap tokens = do 
    let (boolVal,tokens) = evalCond cond varMap (tail(tail(tokens)))
    if (boolVal == (True))
        then do
            (varMap',updated_tokens) <- evalProg prog varMap (tail(tail(tokens)))
            return (varMap', tail(tail(updated_tokens)))
        else do
            (varMap',updated_tokens) <- evalProg prog varMap (tail(tail(tokens)))
            return (varMap, tail(tail(updated_tokens)))



evalProg(ELSEIF cond prog1 prog2) varMap tokens = do
    let (boolVal,new_tokens) = evalCond cond varMap (tail(tail(tokens)))
    if (boolVal == (True))
        then do
            (varMap',updated_tokens) <- evalProg prog1 varMap (tail(tail(new_tokens)))
            (varMap2,updated_tokens2) <- evalProg prog2 varMap (tail(tail(tail(updated_tokens))))
            return (varMap', tail(tail(updated_tokens2)))
        else do 
            (varMap',updated_tokens) <- evalProg prog1 varMap (tail(tail(new_tokens)))
            (varMap2,updated_tokens2) <- evalProg prog2 varMap (tail(tail(tail(updated_tokens))))
            return (varMap2, tail(tail(updated_tokens2)))


evalProg(OVERWRITE varName func) varMap tokens = do
    let oldVarValue = Map.lookup varName varMap
    if oldVarValue == Nothing
        then do
            error ("Variable empty " ++ (tokenPosn (head tokens)))
        else do
            (newValue, newTokens) <- evalFunction func varMap (tail(tail(tokens)))
            case (newValue,oldVarValue) of
                (Bool var1 ,Just(Bool var2)) -> return (Map.insert varName newValue varMap, newTokens)
                (String var1 ,Just(String var2)) -> return (Map.insert varName newValue varMap, newTokens)
                (StrStrList var1 ,Just(StrStrList var2)) -> return (Map.insert varName newValue varMap, newTokens)
                (Integer var1 ,Just(Integer var2)) -> return (Map.insert varName newValue varMap, newTokens)
                (StrList var1 ,Just(StrList var2)) -> return (Map.insert varName newValue varMap, newTokens)
                (_ ,Nothing) -> error ("Cant overwrite a non declared variable " ++ (tokenPosn (head tokens)))
                _ -> error ("Cant overwrite a different type of declaration " ++ (tokenPosn (head tokens)))


evalProg(OVERWRITE_WITH_QUOTES varName string1) varMap tokens = do
    let oldVarValue = Map.lookup varName varMap
    if oldVarValue == Nothing
        then do
            error ("Variable empty " ++ (tokenPosn (head tokens)))
        else do
            case (oldVarValue) of

                (Just(String var2)) -> return (Map.insert varName (String (init(tail string1))) varMap, (tail(tail(tail(tail(tokens))))))
                (Nothing) -> error ("Cant overwrite a non declared variable " ++ (tokenPosn (head tokens)))
                _ -> error ("Cant overwrite a different type of declaration "++ (tokenPosn (head tokens)))

                
            
evalProg(OVERWRITE_NUMBER varName intInput) varMap tokens = do 
    let oldVarValue = Map.lookup varName varMap
    if oldVarValue == Nothing
        then do
            error ("Variable empty " ++ (tokenPosn (head tokens)))
        else do
            case (oldVarValue) of
                (Just(Integer var2)) -> return (Map.insert varName (Integer intInput) varMap, (tail(tail(tail(tail(tokens))))))
                (Nothing) -> error ("Cant overwrite a non declared variable " ++ (tokenPosn (head tokens)))
                _ -> error ("Cant overwrite a different type of declaration " ++ (tokenPosn (head tokens)))








evalCond :: Cond -> Map.Map VarName VarValue ->[HasktileToken] -> (Bool,[HasktileToken])



evalCond (LESS_THAN par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 < int2), (tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            case var1 of
                (Just (Integer var1)) -> ((var1 < int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 < var2), (tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 < var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))


evalCond (GREATER_THAN par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 > int2), (tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            
            case var1 of
                (Just (Integer var1)) -> ((var1 > int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 > var2), (tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 > var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer "++ (tokenPosn (head tokens)))


evalCond (COMPARE_EQUAL par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 == int2), (tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            case var1 of
                (Just (Integer var1)) -> ((var1 == int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 == var2), (tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 == var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))


evalCond (NOT_EQUAL par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 /= int2), (tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            case var1 of
                (Just (Integer var1)) -> ((var1 /= int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 /= var2), (tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 /= var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))

evalCond (LESS_THAN_OR_EQUAL par1 par2) varMap tokens = do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 <= int2),(tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            case var1 of
                (Just (Integer var1)) -> ((var1 <= int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 <= var2),(tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 <= var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))


evalCond (GREATER_THAN_OR_EQUAL par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> ((int1 >= int2), (tail(tail(tail(tokens)))))
        ((PARAMETER_STRING int1),(PARAMETER_INT int2)) -> do
            let var1 = Map.lookup int1 varMap
            case var1 of
                (Just (Integer var1)) -> ((var1 >= int2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING int1),(PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup int1 varMap
            let var2 = Map.lookup int2 varMap
            case (var1,var2) of
                ((Just (Integer var1)),(Just (Integer var2))) -> ((var1 >= var2), (tail(tail(tail(tokens)))))
                (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
                (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1),(PARAMETER_STRING int2)) -> do
            let var2 = Map.lookup int2 varMap
            case var2 of
                (Just (Integer var2)) -> ((int1 >= var2), (tail(tail(tail(tokens)))))
                (Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
                _ -> error ("Parameters are not of type Integer " ++ (tokenPosn (head tokens)))



evalCond (EQUAL_TILES string1 string2) varMap tokens= do 
    let var1 = Map.lookup string1 varMap
    let var2 = Map.lookup string2 varMap
    case (var1,var2) of 
        ((Just (StrList var1)),(Just (StrList var2))) -> ((equalTiles var1 var2), tail(tail(tail(tail(tail(tail(tokens)))))))
        (Nothing,Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
        (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens))) 
        (_, Nothing) -> error ("Parameters are not defined "  ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))






evalFunction :: FunctionsLibrary -> Map.Map VarName VarValue -> [HasktileToken] -> IO (VarValue,[HasktileToken])


evalFunction (GET_ROW_COUNT string) varMap tokens = do
    case Map.lookup string varMap of
        (Just (StrList newList)) -> do
            let result = getRowCount newList
            -- putStrLn (show result)
            return ((Integer result), (tail(tail(tail(tail(tail tokens))))))
        _ ->  error ("Variables are not of type StrList" ++ (tokenPosn (head tokens)))


evalFunction (GET_COL_COUNT string) varMap tokens = do
    case Map.lookup string varMap of
        (Just (StrList newList)) -> do
            let result = getColCount newList
            -- putStrLn (show result)
            return ((Integer result), (tail(tail(tail(tail(tail tokens))))))
        _ ->  error ("Variables are not of type StrList" ++ (tokenPosn (head tokens)))





evalFunction (READ_FILE string) varMap tokens= do
    contents <- readFile string
    let stringList = lines contents
    if((validTile stringList) == True)
        then do
            return ((StrList stringList), (tail(tail(tail(tail(tail(tail(tail tokens))))))))
        else do
            error ("Tile is not in valid format " ++ (tokenPosn (head tokens)))




evalFunction (ADD_HORZ string1 string2) varmap (tokens)= do

    let maybeVar1 = Map.lookup string1 varmap
        maybeVar2 = Map.lookup string2 varmap
    case (maybeVar1, maybeVar2) of
        (Just (StrList var1), Just (StrList var2)) -> do
            let result = addHorizontal var1 var2
            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error ("Variables are not of type StrList " ++ tokenPosn (head tokens))








evalFunction (ADD_VERT string1 string2) varmap tokens= do
    let var1 = Map.lookup string1 varmap
        var2 = Map.lookup string2 varmap
    case (var1, var2) of
        (Just (StrList var1), Just (StrList var2)) -> do
            let result = addVertical var1 var2
            -- prettyPrint result
            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error ("Variables are not of type StrList" ++ (tokenPosn (head tokens)))
    





evalFunction (REPEAT_HORZ par1 par2) varMap tokens= do
    case(par1, par2) of 
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrList var1)) -> do
                    let result = repeatHorizontal var1 int1 [] tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup int1 varMap
            case(var1,var2) of
                ((Just (StrList var1)),(Just (Integer var2))) -> do
                    let result = repeatHorizontal var1 var2 [] tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))


evalFunction (REPEAT_VERT par1 par2) varMap tokens= do
    case(par1, par2) of 
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrList var1)) -> do
                    let result = repeatVertical var1 int1 [] tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup int1 varMap
            case(var1,var2) of
                ((Just (StrList var1)),(Just (Integer var2))) -> do
                    let result = repeatVertical var1 var2 [] tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))

        
                


evalFunction (ROTATE list) varMap tokens= do
    let var1 = Map.lookup list varMap
    case var1 of 
        (Just (StrList var1)) -> do
            let result = rotate90 var1
            -- prettyPrint result
            return ((StrList result),(tail(tail(tail(tail(tail tokens))))))
        _ -> error ("Parameter is not of Strlist type" ++ (tokenPosn (head tokens)))



evalFunction (SCALE par1 par2) varMap tokens= do
    case(par1, par2) of 
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrList var1)) -> do
                    let result = scale var1 int1 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup int1 varMap
            case (var1,var2) of
                ((Just (StrList var1)),(Just (Integer var2))) -> do
                    let result = scale var1 var2 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Paramaters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are not in the correct Type (StrList, Integer) " ++ (tokenPosn (head tokens)))





evalFunction (REFLECT_HORZ list) varMap tokens= do
    let var1 = Map.lookup list varMap
    case var1 of 
        (Just (StrList var1)) -> do
            let result = reflectHorizontal var1
            return ((StrList result),(tail(tail(tail(tail(tail tokens))))))
        _ -> error ("Parameter is not in String List type " ++ (tokenPosn (head tokens)))


evalFunction (REFLECT_VERT list) varMap tokens= do
    let var1 = Map.lookup list varMap
    case var1 of 
        (Just (StrList var1)) -> do
            let result = reflectVertical var1
            return ((StrList result), (tail(tail(tail(tail(tail tokens))))))
        _ -> error ("Paramter is not in String List type "++ (tokenPosn (head tokens)))





evalFunction (NEGATION list) varMap tokens= do
    let var1 = Map.lookup list varMap
    case var1 of 
        (Just (StrList var1)) -> do
            let result = negation var1
            return ((StrList result),(tail(tail(tail(tail(tail tokens))))))
        _ -> error ("Parameter is not in String List type " ++ (tokenPosn (head tokens)))




evalFunction (CONJUNCTION string1 string2) varMap tokens = do
    let var1 = Map.lookup string1 varMap
    let var2 = Map.lookup string2 varMap
    case (var1, var2) of 
        ((Just (StrList var1)), (Just (StrList var2))) -> do
            let result = conjunction var1 var2 tokens
            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error ("Parameter is not in String List type " ++ (tokenPosn (head tokens)))



evalFunction (MAKE_TRIANGLE_DOWN par1 par2) varMap tokens= do
    case (par1, par2) of
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrList var1)) -> do
                    let result = makeTriangleDown var1 int1 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("First paramter of MAKE_TRIANGLE_DOWN is not in String List type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup int1 varMap
            case (var1,var2) of
                ((Just (StrList var1)),(Just (Integer var2))) -> do
                    let result = makeTriangleDown var1 var2 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Parameters of MAKE_TRIANGLE_DOWN is not in the correct type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters of MAKE_TRIANLGE_DOWN is not in the correct type " ++ (tokenPosn (head tokens)))

evalFunction (MAKE_TRIANGLE_UP par1 par2) varMap tokens= do
    case (par1, par2) of
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrList var1)) -> do
                    let result = makeTriangleUp var1 int1 0 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("First paramter of MAKE_TRIANGLE_UP is not in String List type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup int1 varMap
            case (var1,var2) of
                ((Just (StrList var1)),(Just (Integer var2))) -> do
                    let result = makeTriangleUp var1 var2 0 tokens
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Parameters of MAKE_TRIANGLE_UP is not in the correct type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters of MAKE_TRIANLGE_UP is not in the correct type " ++ (tokenPosn (head tokens)))





evalFunction (MAKE_TILE par1 par2) varMap tokens= do
    case (par1, par2) of
        ((PARAMETER_INT int1),(PARAMETER_INT int2)) -> do
            if int1 == 0 || int1 == 1
                then do
                    let char1 = chr(int1 + 48)
                        result = makeTile char1 int2 tokens 
                    return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                else do 
                    error ("Invalid character to make a Tile " ++ (tokenPosn (head tokens))) 
        ((PARAMETER_STRING string1), (PARAMETER_INT int1)) -> do
            let char = Map.lookup string1 varMap
            case char of
                (Just (Integer char_num)) -> do
                    if char_num == 0 || char_num == 1
                        then do
                            let char1 = chr (char_num+48)
                                result = makeTile char1 int1 tokens
                            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                        else do
                            error ("Not a valid character to make a Tile" ++ (tokenPosn (head tokens))) 
                _ -> error("First parameter of Make_TILE is not the correct type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1), (PARAMETER_STRING string2)) -> do
            let char = Map.lookup string1 varMap
            let number_arg = Map.lookup string2 varMap
            case (char, number_arg) of
                ((Just (Integer char_num)), (Just (Integer arg_num))) -> do
                    if char_num == 0 || char_num == 1
                        then do
                            let char1 = chr (char_num+48)
                                result = makeTile char1 arg_num tokens
                            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                        else do
                            error ("Not a valid character to make a Tile" ++ (tokenPosn (head tokens))) 
                _ -> error("Parameters of Make_TILE is not the correct type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_INT int1), (PARAMETER_STRING string1)) -> do
            let number_arg = Map.lookup string1 varMap
            case (number_arg) of
                (Just (Integer arg_num)) -> do
                    if int1 == 0 || int1 == 1
                        then do
                            let char1 = chr (int1+48)
                                result = makeTile char1 arg_num tokens
                            return ((StrList result),(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                        else do
                            error ("Not a valid character to make a Tile" ++ (tokenPosn (head tokens))) 
                _ -> error("Parameters of Make_TILE is not the correct type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))




evalFunction (SUBTILES par_string par_int1 par_int2) varMap tokens= do
    case(par_string, par_int1, par_int2) of 
        ((PARAMETER_STRING string1),(PARAMETER_INT int1), (PARAMETER_INT int2)) -> do
            let var1 = Map.lookup string1 varMap 
            case var1 of
                (Just (StrList var1)) -> do
                    let result = subtiles var1 int1 int2 tokens   
                    return ((StrStrList result), (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters of SUBTILES is not in correct type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1), (PARAMETER_INT int2)) -> do
            let var1 = Map.lookup string1 varMap 
            let var2 = Map.lookup int1 varMap 
            case (var1,var2) of 
                ((Just (StrList var1)), (Just (Integer var2))) -> do
                    let result = subtiles var1 var2 int2 tokens   
                    return ((StrStrList result), (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters of SUBTILES is not in correct type " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING int1), (PARAMETER_STRING int2)) -> do
            let var1 = Map.lookup string1 varMap 
            let var2 = Map.lookup int1 varMap 
            let var3 = Map.lookup int2 varMap 
            case (var1,var2, var3) of 
                ((Just (StrList var1)), (Just (Integer var2)), (Just (Integer var3))) -> do
                    let result = subtiles var1 var2 var3 tokens   
                    return ((StrStrList result), (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters of SUBTILES is not in correct type " ++ (tokenPosn (head tokens)))

        _ ->  error ("Parameters of SUBTILES is not in correct type " ++ (tokenPosn (head tokens)))




evalFunction(GET_BY_INDEX par1 par2) varMap tokens= do 
    case (par1, par2) of
        ((PARAMETER_STRING string1),(PARAMETER_INT int1)) -> do
            let var1 = Map.lookup string1 varMap
            case var1 of
                (Just (StrStrList list)) -> do
                    let result = getByIndex list int1 tokens
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
                (Just (StrList list)) -> do
                    let result = getByIndex list int1 tokens
                    return (String result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Type error " ++ (tokenPosn (head tokens)))
        ((PARAMETER_STRING string1),(PARAMETER_STRING string2)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of
                ((Just (StrStrList list)),(Just (Integer int1))) -> do
                    let result = getByIndex list int1 tokens
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
                ((Just (StrList list)),(Just (Integer int1))) -> do
                    let result = getByIndex list int1 tokens
                    return (String result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Variables are of the correct Type " ++ (tokenPosn (head tokens)))


evalFunction(DISJUNCTION string1 string2) varMap tokens = do
    let var1 = Map.lookup string1 varMap
    let var2 = Map.lookup string2 varMap
    case (var1, var2) of
        ((Just (StrList list1)),(Just (StrList list2))) -> do
            let result = disjunction list1 list2 tokens
            return (StrList result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error ("Variables are not type of StrList for Function DISJUNCTION " ++ (tokenPosn (head tokens)))

evalFunction(IMPLICATION string1 string2) varMap tokens = do
    let var1 = Map.lookup string1 varMap
    let var2 = Map.lookup string2 varMap
    case (var1, var2) of
        ((Just (StrList list1)),(Just (StrList list2))) -> do
            let result = implication list1 list2 tokens
            return (StrList result, (tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error ("Variables are not type of StrList for Function IMPLICATION " ++ (tokenPosn (head tokens)))

evalFunction(XOR string1 string2) varMap tokens = do
    let var1 = Map.lookup string1 varMap
    let var2 = Map.lookup string2 varMap
    case (var1, var2) of
        ((Just(StrList list1)),(Just(StrList list2))) -> do
            let result = xor list1 list2 tokens
            return (StrList result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
        _ -> error( "Variables are not type of StrList for Function XOR " ++ (tokenPosn (head tokens)))
    

    

evalFunction(CONCAT_STRINGS par1 par2 ) varMap tokens = do
    case (par1,par2) of

        ((PARAMETER_STRING string1), (PARAMETER_STRING string2)) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case(var1,var2) of 
                ((Just(String var1)),(Just(String var2))) -> do
                    let result = concatStrings var1 var2
                    return (String result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))
        _ ->  error ("Parameters are not of type StrList " ++ (tokenPosn (head tokens)))

        

evalFunction(Plus par1 par2) varMap tokens = do
    case (par1, par2) of 
        (PARAMETER_INT int1, PARAMETER_INT int2) -> do
            let result = int1 + int2
            return (Integer result,(tail(tail(tail(tail tokens)))))
        (PARAMETER_STRING string1, PARAMETER_STRING string2) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of 
                (Just(Integer var1), (Just(Integer var2))) -> do
                    let result = var1 + var2
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                (Nothing, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (_, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = var1 + int1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_INT int1, PARAMETER_STRING string1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = int1 + var1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
                    

evalFunction(Minus par1 par2) varMap tokens = do
    case (par1, par2) of 
        (PARAMETER_INT int1, PARAMETER_INT int2) -> do
            let result = int1 - int2
            return (Integer result,(tail(tail(tail(tail tokens)))))
        (PARAMETER_STRING string1, PARAMETER_STRING string2) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of 
                (Just(Integer var1), (Just(Integer var2))) -> do
                    let result = var1 - var2
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                (Nothing, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (_, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error" ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = var1 - int1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_INT int1, PARAMETER_STRING string1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = int1 - var1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                _ -> error ("Type Error "++ (tokenPosn (head tokens)))

           

evalFunction(Div par1 par2) varMap tokens = do
    case (par1, par2) of 
        (PARAMETER_INT int1, PARAMETER_INT int2) -> do
            let result = int1 `div` int2
            return (Integer result,(tail(tail(tail(tail tokens)))))
        (PARAMETER_STRING string1, PARAMETER_STRING string2) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of 
                (Just(Integer var1), (Just(Integer var2))) -> do
                    let result = var1 `div` var2
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                (Nothing, Nothing) -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                (_, Nothing) -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = var1 `div` int1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_INT int1, PARAMETER_STRING string1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = int1 `div` var1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined "++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))         
                


evalFunction(Times par1 par2) varMap tokens = do
    case (par1, par2) of 
        (PARAMETER_INT int1, PARAMETER_INT int2) -> do
            let result = int1 * int2
            return (Integer result,(tail(tail(tail(tail tokens)))))
        (PARAMETER_STRING string1, PARAMETER_STRING string2) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of 
                (Just(Integer var1), (Just(Integer var2))) -> do
                    let result = var1 * var2
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                (Nothing, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (_, Nothing) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                (Nothing, _) -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = var1 * int1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))
        (PARAMETER_INT int1, PARAMETER_STRING string1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(Integer var1)) -> do
                    let result = int1 * var1
                    return (Integer result,(tail(tail(tail(tail tokens)))))
                Nothing -> error ("Parameters are not defined " ++ (tokenPosn (head tokens)))
                _ -> error ("Type Error " ++ (tokenPosn (head tokens)))

evalFunction(REVERSE_LIST par1) varMap tokens = do
    case (par1) of
        (PARAMETER_STRING string1) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of
                (Just(StrList var)) -> do
                    let result = reverse var
                    return (StrList result,(tail(tail(tail(tail(tail tokens))))))
                (Just(StrStrList var)) -> do
                    let result = reverse var
                    return (StrStrList result,(tail(tail(tail(tail(tail tokens))))))
                (Just(String var)) -> do
                    let result = reverse var
                    return (String result,(tail(tail(tail(tail(tail tokens))))))
                _ -> error ("Parameter is not defined as a correct type variable "++ (tokenPosn (head tokens)))

evalFunction(ADD_TO_LIST par1 par2) varMap tokens = do
    
    case (par1,par2) of
        (PARAMETER_STRING string1, PARAMETER_STRING string2) ->do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case(var1, var2) of 
                (Just(StrList var1), (Just(String var2))) -> do
                    let result = addToList var1 var2
                    return (StrList result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                (Just(StrStrList var1), (Just(StrList var2))) -> do
                    let result = addToList var1 var2
                    return (StrStrList result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are of wrong type" ++ (tokenPosn (head tokens)))


evalFunction(REMOVE_FROM_LIST par1 par2) varMap tokens = do
    case (par1,par2) of
        (PARAMETER_STRING string1, PARAMETER_STRING string2) ->do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case(var1, var2) of 
                (Just(StrList var1), (Just(String var2))) -> do
                    let result = removeFromList var1 var2
                    return (StrList result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                (Just(StrStrList var1), (Just(StrList var2))) -> do
                    let result = removeFromList var1 var2
                    return (StrStrList result,(tail(tail(tail(tail(tail(tail(tail tokens))))))))
                _ -> error( "Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are of wrong type "++ (tokenPosn (head tokens)))


evalFunction(SUBLIST par1 par2 par3) varMap tokens = do
    case(par1, par2, par3) of 
        (PARAMETER_STRING string1, PARAMETER_INT int1, PARAMETER_INT int2) -> do
            let var1 = Map.lookup string1 varMap
            case (var1) of 
                (Just(StrList var1)) -> do
                    let result = subList var1 int1 int2 
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                (Just(StrStrList var1)) -> do
                    let result = subList var1 int1 int2
                    return (StrStrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_STRING string2, PARAMETER_STRING string3) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            let var3 = Map.lookup string3 varMap
            case(var1,var2,var3) of 
                ((Just(StrList var1)),(Just(Integer int1)),((Just(Integer int2)))) -> do
                    let result = subList var1 int1 int2 
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                ((Just(StrStrList var1)),(Just(Integer int1)),((Just(Integer int2)))) -> do
                    let result = subList var1 int1 int2 
                    return (StrStrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_STRING string2, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case(var1,var2) of 
                ((Just(StrList var1)),(Just(Integer var2))) -> do
                    let result = subList var1 var2 int1 
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                ((Just(StrStrList var1)),(Just(Integer var2))) -> do
                    let result = subList var1 var2 int1
                    return (StrStrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_INT int1, PARAMETER_STRING string2) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case(var1,var2) of 
                ((Just(StrList var1)),(Just(Integer var2))) -> do
                    let result = subList var1 int1 var2
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                ((Just(StrStrList var1)),(Just(Integer var2))) -> do
                    let result = subList var1 int1 var2
                    return (StrStrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens))) 



evalFunction(REPLACE_IN_ROW par1 par2 par3) varMap tokens = do
    case(par1, par2, par3) of
        (PARAMETER_STRING string1, PARAMETER_STRING string2, PARAMETER_INT int1) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            case (var1,var2) of
                ((Just(StrList var1)),(Just(StrList var2))) -> do
                    let result = replaceInRow var1 var2 int1
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        (PARAMETER_STRING string1, PARAMETER_STRING string2, PARAMETER_STRING string3) -> do
            let var1 = Map.lookup string1 varMap
            let var2 = Map.lookup string2 varMap
            let var3 = Map.lookup string3 varMap
            case (var1,var2,var3) of
                ((Just(StrList var1)),(Just(StrList var2)), (Just(Integer int1))) -> do
                    let result = replaceInRow var1 var2 int1
                    return (StrList result, (tail(tail(tail(tail(tail(tail(tail(tail(tail tokens))))))))))
                _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))
        _ -> error ("Parameters are of wrong type " ++ (tokenPosn (head tokens)))




myFunction :: String -> IO VarValue
myFunction input = do
    let output = input
    return (String output)

compareStringLists :: [String] -> [String] -> IO ()
compareStringLists xs ys = if xs == ys
                            then putStrLn "True"
                            else putStrLn "False"









