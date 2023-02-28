
// fnCleanToNameValuesOnlyAll
// Name: fnCleanToNameValuesOnlyAll  - NOTE: Requires fnCleanToNameValuesOnly in your project
// Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space
// Inputs: EnterText as text - String containing Non-alpha characters to remove
// Outputs: Text string with only A-Z, a-z, and space
// Example: Input: Chocolate Candy1234 b!a@r# // Output: Chocolate Candy bar


let func = 

(Select_Table as table)=>
let
    Source = (Select_Table as table),
  
   //function to replace all values in all columns with special characters removed
   CleanToNameValuesOnlyAll = (DataTable as table, DataTableColumns as list) =>
     let
        Counter = Table.ColumnCount(DataTable),
        ReplaceCol = (DataTableTemp, i) =>
            let
                colName = DataTableColumns{i},
                
                ReplaceTable = Table.ReplaceValue(DataTableTemp,each Record.Field(_, colName), each if Record.Field(_, colName) is text then fnCleanToNameValuesOnly(Record.Field(_, colName)) else Record.Field(_, colName),Replacer.ReplaceValue,{colName})
                
            in
                if i = Counter-1 then ReplaceTable else @ReplaceCol(ReplaceTable, i+1)
     in
        ReplaceCol(DataTable, 0),
    allColumns = Table.ColumnNames(Source),
   AllCleaned = CleanToNameValuesOnlyAll(Source, allColumns)
in
 AllCleaned
,
 documentation = [
    Documentation.Name = "Function Name: fnCleanToNameValuesOnlyAll - NOTE: Requires fnCleanToNameValuesOnly in your project", 
    Documentation.Description
    = " Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space from ALL fields and creates a NEW table/query", 
    Documentation.LongDescription
      = " Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space  from ALL fields and creates a NEW table/query", 
    Documentation.Category = "Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "Jane O'Rourke-Doe ", Result = "Output: Jane ORourke-Doe"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))