// fnCleanHTMLTags
// Name: fnCleanHTMLTags
// Purpose: Removes all HTML tags from a text string
// Inputs: HTML as text
// Outputs: Text string with no instances of HTML tags
// Example: Input: <DIV style=".css">This is My Text</DIV>  //  Output: This is My Text

let func = 

(HTML as text) =>
let
    Source = Text.From(HTML),
    SplitAny = Text.SplitAny(Source,"<>"),
    ListAlternate = List.Alternate(SplitAny,1,1,1),
    ListSelect = List.Select(ListAlternate, each _<>" "),
    TextCombine = Text.Combine(ListSelect, " ")
in
TextCombine,
 documentation = [
    Documentation.Name = "Function Name: fnCleanHTMLTags", 
    Documentation.Description
    = " Purpose: Removes all HTML tags from a text string ", 
    Documentation.LongDescription
      = "  Purpose: Removes all HTML tags from a text string ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: <DIV style='.css'>This is My Text</DIV>  ", Result = "  This is My Text"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))

// fnCleanHTMLTagsAll
// Name: fnCleanHTMLTagsAll - NOTE: Requires fnCleanHTMLTags in your project
// Purpose: Removes all HTML tags and creates a new table/query
// Inputs: Select_Table as table - String containing HTML tags to remove
// Outputs: New Table/Query with HTML Tags Removed
// Example: Input: <DIV style='.css'>This is My Text</DIV> // Output: This is my text


let func = 

(Select_Table as table)=>
let
    Source = (Select_Table as table),
  
   //function to replace all values in all columns with special characters removed
   CleanHTMLTagsAll = (DataTable as table, DataTableColumns as list) =>
     let
        Counter = Table.ColumnCount(DataTable),
        ReplaceCol = (DataTableTemp, i) =>
            let
                colName = DataTableColumns{i},
                
                ReplaceTable = Table.ReplaceValue(DataTableTemp,each Record.Field(_, colName), each if Record.Field(_, colName) is text then fnCleanHTMLTags(Record.Field(_, colName)) else Record.Field(_, colName),Replacer.ReplaceValue,{colName})
                
            in
                if i = Counter-1 then ReplaceTable else @ReplaceCol(ReplaceTable, i+1)
     in
        ReplaceCol(DataTable, 0),
    allColumns = Table.ColumnNames(Source),
   AllCleaned = CleanHTMLTagsAll(Source, allColumns)
in
 AllCleaned
,
 documentation = [
    Documentation.Name = "Function Name: fnCleanHTMLTagsAll - NOTE: Requires fnCleanHTMLTags in your project", 
    Documentation.Description
    = " Purpose: Removes all HTML tags from a text string in ALL records and creates a NEW table/query ", 
    Documentation.LongDescription
      = "  Purpose: Removes all HTML tags from a text string in ALL records and creates a NEW table/query ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: <DIV style='.css'>This is My Text</DIV>  ", Result = "  This is My Text"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))