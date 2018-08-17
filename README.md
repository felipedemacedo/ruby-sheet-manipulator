# Ruby Sheet Manipulator

Basic sheet manipulator in Ruby. ([Source Code](https://github.com/felipedemacedo/ruby-sheet-manipulator))

### Sample sheet:
![sheet_example](https://user-images.githubusercontent.com/7635127/44288672-81de3000-a247-11e8-899a-e9c6284ecbd0.png)

```markdown
Col A;Col B;Col C
;;
123;456   ;789
12;   34;56
;
;;
78;90;1   
a;b;c



dD;Ee;fF


;;;;;

;;
;;;
```

## Usage examples:

### Point to the sheet file
```markdown
sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv")
--------------------------------------------------------------------
#<Sheet:0xc2bbf78 @path="./example_sheets/skip_blank_lines/sheet.csv", @file=#<File:./example_sheets/skip_blank_lines/sheet.csv>, @column_separator=";">
```
### Point to the sheet file with custom column separator
```markdown
sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv", ",")
--------------------------------------------------------------------
#<Sheet:0xc2bbf18 @path="./example_sheets/skip_blank_lines/sheet.csv", @file=#<File:./example_sheets/skip_blank_lines/sheet.csv>, @column_separator=",">
```
### Load the sheet into memory
```markdown
sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv")
sheet.load()
--------------------------------------------------------------------
** LOADING 
  DATA: 
";;\n"
"123;456   ;789\n"
"12;   34;56\n"
";\n"
";;\n"
"78;90;1   \n"
"a;b;c\n"
"\n"
"\n"
"\n"
"dD;Ee;fF\n"
"\n"
"\n"
";;;;;\n"
"\n"
";;\n"
";;;"
--
```
### Load the sheet into memory as an Array
```markdown
sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv")
sheet.load_as_array()
--------------------------------------------------------------------
** LOADING AS ARRAY
  DATA: 
["", "", "\n"]
["123", "456   ", "789\n"]
["12", "   34", "56\n"]
["", "\n"]
["", "", "\n"]
["78", "90", "1   \n"]
["a", "b", "c\n"]
["\n"]
["\n"]
["\n"]
["dD", "Ee", "fF\n"]
["\n"]
["\n"]
["", "", "", "", "", "\n"]
["\n"]
["", "", "\n"]
[]
--
```
### Load the sheet into memory as a Hash
```markdown
sheet = Sheet.new("./example_sheets/skip_blank_lines/sheet.csv")
sheet.load_as_hash()
--------------------------------------------------------------------
** LOADING AS HASH
  DATA: 
{"Col A"=>"", "Col B"=>"", "Col C"=>"\n"}
{"Col A"=>"123", "Col B"=>"456   ", "Col C"=>"789\n"}
{"Col A"=>"12", "Col B"=>"   34", "Col C"=>"56\n"}
{"Col A"=>"", "Col B"=>"\n", "Col C"=>nil}
{"Col A"=>"", "Col B"=>"", "Col C"=>"\n"}
{"Col A"=>"78", "Col B"=>"90", "Col C"=>"1   \n"}
{"Col A"=>"a", "Col B"=>"b", "Col C"=>"c\n"}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"dD", "Col B"=>"Ee", "Col C"=>"fF\n"}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"", "Col B"=>"", "Col C"=>""}
{"Col A"=>"\n", "Col B"=>nil, "Col C"=>nil}
{"Col A"=>"", "Col B"=>"", "Col C"=>"\n"}
{"Col A"=>nil, "Col B"=>nil, "Col C"=>nil}
--
```
