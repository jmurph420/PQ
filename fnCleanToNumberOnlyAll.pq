

// fnCleanToNumberOnlyAll
// Name: fnCleanToNumberOnlyAll  - NOTE: Requires fnCleanSelectCharacters in your project
// Purpose: Removes all characters except Removes all characters except 0-9, period, and comma
// Inputs: Select_Table as any - String containing Non-numeric characters to remove
// Outputs: Numeric string with only characters except 0-9, period, and comma
// Example: Input: Chocolate Candy1234 b!a@r# // Output: 1234
let func = 

(Select_Table as table)=>

let
    Source = (Select_Table as table),
  
   //function to replace all values in all columns with special characters removed
   CleanToNumberOnlyAll = (DataTable as table, DataTableColumns as list) =>
     let
        Counter = Table.ColumnCount(DataTable),
        ReplaceCol = (DataTableTemp, i) =>
            let
                colName = DataTableColumns{i},
                
                ReplaceTable = Table.ReplaceValue(DataTableTemp,each Record.Field(_, colName), each if Record.Field(_, colName) is text then fnCleanToNumberOnly(Record.Field(_, colName)) else Record.Field(_, colName),Replacer.ReplaceValue,{colName})
                
            in
                if i = Counter-1 then ReplaceTable else @ReplaceCol(ReplaceTable, i+1)
     in
        ReplaceCol(DataTable, 0),
    allColumns = Table.ColumnNames(Source),
   AllCleaned = CleanToNumberOnlyAll(Source, allColumns)
in
 AllCleaned
,
 documentation = [
    Documentation.Name = "Function Name: fnCleanToNumberOnlyAll  - NOTE: Requires fnCleanToNumberOnly in your project", 
    Documentation.Description
    = " Purpose: Removes all characters except 0-9, period, and comma and creates a NEW table", 
    Documentation.LongDescription
      = "  Purpose: Removes all characters except 0-9, period, and comma and creates a NEW table", 
    Documentation.Category = "Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "Input: Select_Table ", Result = "Numeric values only"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))