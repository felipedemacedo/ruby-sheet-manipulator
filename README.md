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
### Remove all blank lines from sheet
```markdown
sheet.skip_blank_lines()
--------------------------------------------------------------------
** BACKUP STORED !
REMOVE_BLANK_LINES APPLIED !
  DATA: 
["123", "456   ", "789\n"]
["12", "   34", "56\n"]
["78", "90", "1   \n"]
["a", "b", "c\n"]
["dD", "Ee", "fF\n"]
--
```
### Get rid of leading and trailing whitespaces
```markdown
sheet.skip_whitespaces()
--------------------------------------------------------------------
** BACKUP STORED !
REMOVE_WHITESPACES APPLIED !
  DATA: 
["", "", "\n"]
["123", "456", "789\n"]
["12", "34", "56\n"]
["", "\n"]
["", "", "\n"]
["78", "90", "1\n"]
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
--
```
### Remove all line breaks
```markdown
sheet.skip_line_breaks()
--------------------------------------------------------------------
** BACKUP STORED !
REMOVE_LINE_BREAKS APPLIED !
  DATA: 
["", "", ""]
["123", "456   ", "789"]
["12", "   34", "56"]
["", ""]
["", "", ""]
["78", "90", "1   "]
["a", "b", "c"]
[""]
[""]
[""]
["dD", "Ee", "fF"]
[""]
[""]
["", "", "", "", "", ""]
[""]
["", "", ""]
--
```
### Remove similar lines
```markdown
sheet.uniq()
--------------------------------------------------------------------
** BACKUP STORED !
UNIQ APPLIED !
  DATA: 
["", "", "\n"]
["123", "456   ", "789\n"]
["12", "   34", "56\n"]
["", "\n"]
["78", "90", "1   \n"]
["a", "b", "c\n"]
["\n"]
["dD", "Ee", "fF\n"]
["", "", "", "", "", "\n"]
[]
--
```
### Sort all lines of the sheet
```markdown
sheet.sort()
--------------------------------------------------------------------
** BACKUP STORED !
SORT APPLIED !
  DATA: 
[]
["", "", "", "", "", "\n"]
["", "", "\n"]
["", "", "\n"]
["", "", "\n"]
["", "\n"]
["\n"]
["\n"]
["\n"]
["\n"]
["\n"]
["\n"]
["12", "   34", "56\n"]
["123", "456   ", "789\n"]
["78", "90", "1   \n"]
["a", "b", "c\n"]
["dD", "Ee", "fF\n"]
--
```
### UPCASE
```markdown
sheet.upcase()
--------------------------------------------------------------------
** BACKUP STORED !
APPLY_UPCASE APPLIED !
  DATA: 
["", "", "\n"]
["123", "456   ", "789\n"]
["12", "   34", "56\n"]
["", "\n"]
["", "", "\n"]
["78", "90", "1   \n"]
["A", "B", "C\n"]
["\n"]
["\n"]
["\n"]
["DD", "EE", "FF\n"]
["\n"]
["\n"]
["", "", "", "", "", "\n"]
["\n"]
["", "", "\n"]
--
```
### downcase
```markdown
sheet.downcase()
--------------------------------------------------------------------
** BACKUP STORED !
APPLY_DOWNCASE APPLIED !
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
["dd", "ee", "ff\n"]
["\n"]
["\n"]
["", "", "", "", "", "\n"]
["\n"]
["", "", "\n"]
--
```
### Remove all numeric elements from the sheet.
```markdown
sheet.skip_numeric()
--------------------------------------------------------------------
** BACKUP STORED !
REMOVE_NUMERICS APPLIED !
  DATA: 
["", "", "\n"]
["", "", ""]
["", "", ""]
["", "\n"]
["", "", "\n"]
["", "", ""]
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
--
```
### You can always come back and undo last change.
```markdown
sheet.skip_numeric()
sheet.rollback()
--------------------------------------------------------------------
** BACKUP STORED !
REMOVE_NUMERICS APPLIED !
  DATA: 
["", "", "\n"]
["", "", ""]
["", "", ""]
["", "\n"]
["", "", "\n"]
["", "", ""]
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
--
** ROLLED BACK !
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
### Some methods can be applied into specific columns only.
For instance: upcase, downcase, skip_line_breaks, skip_whitespaces, skip_numeric, skip_non_numeric
```markdown
sheet.upcase([0,1])
--------------------------------------------------------------------
****************************SPECIFIC COLUMNS: [0,1]
** BACKUP STORED !
APPLY_UPCASE APPLIED !
  DATA: 
["", "", "\n"]
["123", "456   ", "789\n"]
["12", "   34", "56\n"]
["", "\n"]
["", "", "\n"]
["78", "90", "1   \n"]
["A", "B", "c\n"]
["\n"]
["\n"]
["\n"]
["DD", "EE", "fF\n"]
["\n"]
["\n"]
["", "", "", "", "", "\n"]
["\n"]
["", "", "\n"]
--
```
