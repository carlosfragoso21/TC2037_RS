# Highlighter Syntax
this is the user manual for the ABAP Syntax Highlighter program! This program, developed in Elixir, aims to provide a convenient tool for highlighting ABAP code syntax, making it easier for developers to analyze and understand their ABAP programs.

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/0de6d3fd-58c6-484f-97f6-d5aae35ae4be)

## Diagram to facilitate perception of logical flow
![Diagrama de flujo (3)](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/dd2383e0-b634-452f-a2ba-4cf0050371ac)

## Recursive Function Calls

This program utilizes recursive function calls based on the content of the test file. The number of recursive calls is variable and depends on the specific content of the file being processed. It is important to understand the following aspects:

Best-case Scenario: In the best-case scenario, the program may not require any recursive calls. This occurs when the content of the string does conceed once time or none with regex validation.

Worst-case Scenario: In the worst-case scenario, the program may make multiple recursive calls. The exact number of recursive calls cannot be determined in advance, as it depends on the specific content of the file being processed.

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
This is the result from file explorer C:\Users\Inetum\Desktop\Sintaxis I'll just add extra \ and end path with \\ to complete format:
C:\\Users\\Inetum\\Desktop\\Sintaxis\\

### Now we can go to steps

1.- Download exs file

2.- Download or get your test files

3.- Program will read the file that is named CONTENT.TXT so name like this the file that you will run

4.- Get your path ready where your file test is and the html, css generated will be generated

5.- Open exs

6.- Call Function (R.Syntax is module and main_syntax is function) So R.Syntax.main_syntax("") between "" you'll write your path
So in my case: R.Syntax.main_syntax("C:\\Users\\Inetum\\Desktop\\Sintaxis\\")

7.- enter

8.- Check the HTML File generated in your directory

![image](https://github.com/carlosfragoso21/TC2037_RS/assets/80837879/e8667008-6057-4b60-af28-1f1c4e25995d)
