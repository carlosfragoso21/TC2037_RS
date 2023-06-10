# Highlighter Syntax
this is the user manual for the ABAP Syntax Highlighter program! This program, developed in Elixir, aims to provide a convenient tool for highlighting ABAP code syntax, making it easier for developers to analyze and understand their ABAP programs.

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/0de6d3fd-58c6-484f-97f6-d5aae35ae4be)

## Diagram to facilitate perception of logical flow
![Diagrama de flujo (3)](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/dd2383e0-b634-452f-a2ba-4cf0050371ac)

## Token types
* Reserved keywords: AUTHORITY-CHECK, FIELD-SYMBOL, ASSIGNING, IMPORTING, PERFORM, PARAMETERS, ENDMETHOD, ENDMODULE, STRUCTURE, CONDENSE, CONSTANTS, UNASSIGN, ENDSELECT, ENDLOOP, ENDFORM, CONTINUE, CONVERT, DESCRIBE, COLLECT, COMMIT, COMPUTE, SELECTION, FUNCTION, ROLLBACK, REFRESH, REJECT, REPORT, RETURN, METHOD, MODIFY, MODULE, MOVE, MULTIPLY, EXPORT, EXTRACT, APPEND, OBJECT, CATCH, CHECK, CLASS, CLEAR, CLOSE, OPTION, ENDTRY, UNION, UPDATE, VALUE, VALUES, VARYING, WHEN, WHILE, WITH, WRITE, WHERE, REPORT, INCLUDE, GROUP, HAVING, IMPORT, INCLUDE, INITIAL, INNER, INTO, LEAVE, SELECT, SWITCH, DEFINE, DELETE, FROM, SUBMIT, ASSIGN, START, FORM, BREAK, CASE, NODES, ORDER, RAISE, READ, ELSEIF, TYPE, TYPES, TABLE, AND, CALL, DATA, ELSE, ENDIF, END, EXIT, FETCH, FILTER, FINAL, FOR, LIKE, LOOP, NEW, NEXT, NOT, SET, SHIFT, SPLIT, STEP, SUM, TRY, DO, AT, IF, NO, OF, ON, OR.

* Identifiers: Following the pattern of starting with a letter (uppercase or lowercase) and being composed of letters, numbers, and underscores.

* String literals: Enclosed within single quotes ('') and can contain any content between them.

* Operators: +, -, *, /, =.

* Delimiters: Parentheses () and brackets [].

* Comments: Starting with double quotes (") and can span multiple lines.

* Numbers: Can be integers or decimals.

* Dot, comma, and at symbol: ., ,, @.

* Line break: Represented by a line break pattern.

* Error token: Used to identify syntax highlighting errors.

## Recursive Function Calls

This program utilizes recursive function calls based on the content of the test file. The number of recursive calls is variable and depends on the specific content of the file being processed. It is important to understand the following aspects:

Best-case Scenario: In the best-case scenario, the program may not require any recursive calls. This occurs when the content of the string does conceed once time or none with regex validation.

Worst-case Scenario: In the worst-case scenario, the program may make multiple recursive calls. The exact number of recursive calls cannot be determined in advance, as it depends on the specific content of the file being processed.
## Big O complex
The complexity of the program in Big O terms it's O(n). Considering step process depending on content, we can infer the O(n) because steps will increase proportionally to content.

In order to visualize this behavior, let's compare process time between a small file (10 words) and a medium file (100 words):

First file test:

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/69d9f061-6696-483d-beee-414e383e0c91)

As we can see, the average is 38333 nanoseconds

Second file test (10x words):

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/e21f680a-19e5-486f-955d-236ce1d45bd7)

As we can see, the averagge 248333 nanoseconds

We can infer that time does not increment 10 times, this could be because we have to know that iniciation process and final process(the ones that are not in loop or recursively calling) these are not reprocessing 10 times. So in this test we can see that the complexity is not worse than O(n). And just to assert, program will increase steps depending on words quantity, this increase is proportional to content.

## User Manual
There´s a few considerations before using the program:
* This program will generate 2 files (1 html, 1 css) and will read your test file. Program also just ask for the path, you must be organizated in the path that you wanna work with.
* As mentioned in the previous point, Program will ask just for path, so let´s talk about the path format that you must use:
z = any directory name.
... = represents n
#### Format example: ...z\\z\\z\\
Here's how I introduce my path 
![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/80c58792-6efd-4e4d-96c6-f7d24065648d)
![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/7f1b381e-0c7d-4519-af7e-a306793ee19b)
This is the result from file explorer C:\Users\Inetum\Desktop\Sintaxis 

We need to consider 2 steps:

1.- Add your file name to your path, in this case, mine would be C:\Users\Inetum\Desktop\Sintaxis/CONTENT.TXT

2.- I'll just add extra \ and end path with \\ to complete format:
C:\\Users\\Inetum\\Desktop\\Sintaxis\\CONTENT.TXT

### Now we can go to next steps

1.- Download exs file

2.- Download or get your test files

3.- Get your path ready where your file test is and the html, css generated will be generated

4.- Open exs

5.- Call Function (H.Syntax is module and main_syntax is function) So H.Syntax.main_syntax("") between "" you'll write your path
So in my case: H.Syntax.main_syntax("C:\\Users\\Inetum\\Desktop\\Sintaxis\\CONTENT.TXT")

6.- enter

7.- Check the HTML File generated in your directory

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/92a9405c-bf7f-4f04-8e89-7d77d26461b8)

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/5e1feef1-7a55-4d37-853f-cfbb640cfdaf)

