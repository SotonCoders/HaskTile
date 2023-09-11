# HaskTile

A new domain-specific programming language made using Haskell, meant to solve tile - based problems.

<p align="center"><img width="350" src="https://github.com/LucianSerbanescu/HaskTile/blob/main/Documentation/Screenshot%202023-09-11%20at%2012.46.56%20pm.png?raw=true"/></p> 

### Cheat Sheet

<p align="center"><img width="350" src="https://github.com/LucianSerbanescu/HaskTile/blob/main/Documentation/Screenshot%202023-09-11%20at%203.05.34%20pm.png?raw=true"/></p> 

<p align="center"><img width="350" src="https://github.com/LucianSerbanescu/HaskTile/blob/main/Documentation/Screenshot%202023-09-11%20at%203.05.25%20pm.png?raw=true"/></p> 

## Language features

### Syntax

Lexing and Parsing are implemented using Alex and Happy, and are stored inside "HasktileTokens.x"
and "HasktileGrammar.y" files.

Some lexing details would be that variables have to start with a letter and can contain letters and
numbers, but no other charaters. All the functions have predefined tokens and you have to call them
with capital letters.

Regading syntax we allow a few main actions : declare a variable giving the type, change the value
stored by a variable, call a function, print a variable or even storing the output of a function in a
variable.

Variable declaration using the output of a function example :
<varType> <varName> = <functionCall>;

We also included for loops, but they work in a haslkell-like way. We have some functions such as
SCALE(), REPEAT-HORZ() ,SUBTILES(), SUBLIST() which cover the entire loops functionalities
reagarding tile creation. The main reason why we stick with a loop function is time-efficiency. We
added if statements so we can check the input tiles, or do some unregular changes in tiles.

We tried to keep the AST as simple as possible passing only variables name of funtions and parameters:
<p align="center"><img width="350" src="https://github.com/LucianSerbanescu/HaskTile/blob/main/Documentation/Screenshot%202023-09-11%20at%203.03.13%20pm.png?raw=true"/></p> 


We would say that we have only one scope (or none at all). We do not provide declarations of new
functions, neither classes, so the scope is only one. Even the if statements do not have scope.

### Compile time errors

The language has been designed in a way that if a program takes more than 60 seconds to execute, an error message is displayed. The timeout was set to only 1 minute, because the interpreter is quite fast. Most programs written in the language (including solutions to all 10 given problems) are executed within less than a second.

### Type checking 

Our coding language performs dynamic type checking. The types of variables and values are deter- mined at runtime during program execution, rather than being declared and checked at compile time. If we use ’DECLARE LIST STRING’ (Called when initializing a new tile variable) as an example, a function is given as an argument to evaluate the value assigned to the variable. We call the function we are assigning to the variable and if the function returns anything with a type other than a List of Strings we throw an error.
When we are calling functions that have variables as arguments we check the types of these argu- ments by pattern matching. In the case of the function ’REPEAT HORZ’, the first argument must be ’StrList’ type (which represents a tile) and the second argument must be an integer value.

Hasktile is a strongly typed language. Once a variable is defined with a specific data type, it can only store values of that type. This means that if you try to assign a value of a different type to that variable, the compiler will throw an error.
When a function is called the interpreter checks the types of variables that are being called. If the type of the variables is not consistent with what is being asked in the function, an error is thrown before the function is executed.


### Illegal inputs

Whenever a tile is read from file, the tile is validated by the interpreter.
If the inserted tile is valid (consists of only 0s and 1s, and the number of rows is equal to the number of columns), then the program continues executing.

### Parsing errors 

In case of a parsing error, the user will get an informative message printed and the program will not be executed. The message will state that it is a "Parsing error" and the line and column number to identify which line of the user’s code caused the problem.

### Library functions errors

Additionally, the Hasktile library functions stated in the previous section validate inputs to make sure that invalid parameters are caught. For instance, the "SCALE" function, which takes a tile and a number as inputs does not allow negative numbers to be inserted.
Whenever a user inputs invalid parameters to a function, an informative error message is displayed.