
#*----------------------------------------------------*
#*     This program Elixir program will syntax        *
#*         highlighting your ABAP code                *
#*----------------------------------------------------*
#*         Creator    | Version |    Date             *
#*----------------------------------------------------*
#*                                                    *
#*     Carlos Fragoso |   1.0   |  26/05/2023         *
#*                                                    *
#* Modifications: Creation of exs, Module             *
#* Function Fun.Files, R.Sintaxis. Also Functions:    *
#* Fun.Files.appendFile, main_sintax Conform_css,     *
#* Conform_html. Also variables and Regex definitions *
#*----------------------------------------------------*
#*                                                    *
#*     Carlos Fragoso |   1.1   |  29/05/2023         *
#*                                                    *
#* Modifications: Creation of dynamic_span and        *
#* rest_content                                       *
#*----------------------------------------------------*

defmodule Fun.Files do
  def appendFile(file_path, cont, type)do #Creates txt file with user content
    cond do                               #Also Appends content to a existing file
      type == 'A' ->                      #Type == A will append, Type == C will create
        case File.open(file_path, [:append])do
          {:ok, file} ->
            IO.write(file, cont)
            File.close(file)
            {:ok, "Archivo creado: #{file_path}"}

          {:error, reason} ->
            {:error, reason}
        end

      type == 'C' ->
        case File.open(file_path, [:write])do
          {:ok, file} ->
            IO.write(file, cont)
            File.close(file)
            {:ok, "Archivo creado: #{file_path}"}

          {:error, reason} ->
            {:error2, reason}
        end
    end
  end
end

defmodule H.Syntax do
  #Regex to identify tokens or ABAP component code
  @regular_ex_kw     ~r/^\s*(SELECTION|START|FORM|PERFORM|AT|AND|APPEND|ASSIGNING|ASSIGN|AUTHORITY-CHECK|BREAK|CASE|
                          CATCH|CHECK|CLASS|CLEAR|CLOSE|CALL|IMPORTING|FIELD-SYMBOL|
                          COLLECT|COMMIT|COMPUTE|CONDENSE|CONSTANTS|CONTINUE|CONVERT|DATA|DEFINE|DELETE|
                          DESCRIBE|DO|ELSE|ELSEIF|END|ENDIF|ENDLOOP|ENDMETHOD|ENDMODULE|ENDSELECT|ENDTRY|
                          EXIT|EXPORT|EXTRACT|FETCH|FILTER|FINAL|FOR|FROM|FUNCTION|GROUP|HAVING|IF|IMPORT|
                          INCLUDE|INITIAL|INNER|INTO|LEAVE|LIKE|LOOP|METHOD|MODIFY|MODULE|MOVE|MULTIPLY|NEW|
                          NEXT|NO|NODES|NOT|OBJECT|OF|ON|OPTION|OR|ORDER|PARAMETERS|RAISE|READ|REFRESH|REJECT|
                          REPORT|RETURN|ROLLBACK|SELECT|SET|SHIFT|SPLIT|STEP|STRUCTURE|SUBMIT|SUM|SWITCH|TABLE|
                          TRY|TYPE|TYPES|UNASSIGN|UNION|UPDATE|VALUE|VALUES|VARYING|WHEN|WHILE|WITH|WRITE|WHERE|REPORT|
                          |INCLUDE)/
  @regular_ex_id    ~r/^\s*(?i)<?[a-z][a-z0-9\_]*>?/
  @regular_ex_lit   ~r/^\s*'.*'/
  @regular_ex_opera ~r/^\s*[+\-*\/=:]/
  @regular_ex_delim  ~r/^\s*[\(\)\[\]]/
  @regular_ex_comm   ~r/^\s*".*\r\n/
  @regular_ex_num    ~r/^\s*\d+(\.\d+)?/
  @regular_ex_dot    ~r/^\s*\.|\,|\@/
  @regular_ex_enter ~r/^\s*\r\n/
  @regular_ex_error ~r/^.*\.|.*/ #this one is used to figure out where to end Highling error

  defp conform_css(lv_css_path) do
    file_cont_css =
"/* Styles for syntax */
body {
  background-color: #f6f6f6;
  color: #000000;
  font-family: \"Courier New\", monospace;
  font-size: 14px;
  line-height: 1.4;
  padding: 20px;
}
span {
  margin-right: 0;
}
.key_word,
.Identifier,
.Literal,
.Operator,
.Delimiter,
.Comment,
.Number
.Error {
  font-weight: bold;
}
.key_word{
  color: blue;
}
.Identifier {
  font-weight: normal;
  color: black;
}
.Literal {
  color: #00C800;
}
.Operator {
  color: #800080;
}
.Delimiter {
  color: #333333;
}
.Comment {
  color: #808080;
}
.Number {
  color: #0000FF;
}
.Error {
  color: #FF0000;
}
"
    Fun.Files.appendFile(lv_css_path,file_cont_css, 'C') #creates css with file_cont_css css code
  end

  defp conform_html(lv_html_path, lv_name_content) do
    file_cont_head_html =
"<!DOCTYPE html>
<html>
  <head>
  <meta charset=\"UTF-8\" />
  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />
  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />
  <link rel=\"stylesheet\" type=\"text/css\" href=\"SYNTAX.CSS\" />
  </style>
  </head>
  <body> \n
"
file_cont_end_html =
"  </body>
</html>"
      Fun.Files.appendFile(lv_html_path,file_cont_head_html,'C') #Creates first part from html

      {:ok, file_contents} = File.read(lv_name_content) #Get CONTENT.TXT data
      dynamic_span(lv_html_path, file_contents) #Creates dynamic part from html (ABAP components)

      Fun.Files.appendFile(lv_html_path,file_cont_end_html, 'A') #Creates last part from html
  end

  defp dynamic_span(lv_html_path, content) do
    cond do
      Regex.match?(@regular_ex_enter, content) -> #Regex validation
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,9)) #Recursive call in order to validate
                                                                        #rest of code, function rest_content helps
                                                                        #to the creating of <span>s and deleting the
                                                                        #actual component
      Regex.match?(@regular_ex_comm, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,1))

      Regex.match?(@regular_ex_kw, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,2))

      Regex.match?(@regular_ex_id, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,3))

      Regex.match?(@regular_ex_num, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,4))

      Regex.match?(@regular_ex_opera, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,5))

      Regex.match?(@regular_ex_lit, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,6))

      Regex.match?(@regular_ex_delim, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,7))

      Regex.match?(@regular_ex_dot, content) ->
        dynamic_span(lv_html_path,rest_content(lv_html_path,content,8))

      Regex.match?(~r/^$/, content) -> #Validation to know when content is empty
      "done"

      Regex.match?(@regular_ex_error, content) ->
      dynamic_span(lv_html_path,rest_content(lv_html_path,content,10))
    end
  end

  defp rest_content(lv_html_path,content, type)do
    case type do
      1 ->
        m = hd(Regex.scan(@regular_ex_comm, content)) #scan data already validated and saving it in variable m
        [value | _] = m #partition of m where head (value) will get the identificated word
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Comment\">"<>value<>"</span> \n", 'A') #append of <span>

        rest ="
        "<> Regex.replace(@regular_ex_comm, content, "", global: false)
        rest #returns rest of content

      2 ->
        m = hd(Regex.scan(@regular_ex_kw, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"key_word\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_kw, content, "", global: false)
        rest

      3 ->
        m = hd(Regex.scan(@regular_ex_id, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Identifier\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_id, content, "", global: false)
        rest
      4 ->
        m = hd(Regex.scan(@regular_ex_num, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Number\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_num, content, "", global: false)
        rest
      5 ->
        m = hd(Regex.scan(@regular_ex_opera, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Operator\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_opera, content, "", global: false)
        rest
      6 ->
        m = hd(Regex.scan(@regular_ex_lit, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Literal\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_lit, content, "", global: false)
        rest
      7 ->
        m = hd(Regex.scan(@regular_ex_delim, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Delimiter\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_delim, content, "", global: false)
        rest
      8 ->
        m = hd(Regex.scan(@regular_ex_dot, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Operator\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_dot, content, "", global: false)
        rest
      9 ->
        Fun.Files.appendFile(lv_html_path,"<br> \n", 'A') #In case of enter add <br> to html

        rest = Regex.replace(@regular_ex_enter, content, "", global: false)
        rest
      10 ->
        m = hd(Regex.scan(@regular_ex_error, content))
        [value | _] = m
        Fun.Files.appendFile(lv_html_path,"<span class="<>"\"Error\">"<>value<>"</span> \n", 'A')

        rest = Regex.replace(@regular_ex_error, content, "", global: false)
        rest
    end
  end

  def main_syntax(p_path) do
    #Conformation of final paths
    lv_css_path = p_path <> "SYNTAX.CSS"
    lv_html_path = p_path <> "SYNTAX.HTML"
    lv_name_content = p_path <> "CONTENT.TXT"

    #Function call
    conform_css(lv_css_path)
    conform_html(lv_html_path,lv_name_content)
  end
end
