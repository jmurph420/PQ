// NOTE: This function requires fnCleanSpecialCharacters in your project
// Name: fnCleanSpecialCharactersALL
// Purpose: Removes all special characters listed on SplitAny step in fnCleanSpecialCharacters FROM THE ENTIRE SELECTED TABLE
// Inputs: Table selected from dropdown list
// Outputs: New query containing duplicate table with no instances of Special Characters from the SplitAny step in fnCleanSpecialCharacters
// Example: Input: a!b@c#d$1234<>??  //  Output: abcd1234

let func = 

(SelectTable as table)=>
let
    Source = (SelectTable as table),
  
   //function to replace all values in all columns with special characters removed
   CleanSpecialCharactersAll = (DataTable as table, DataTableColumns as list) =>
     let
        Counter = Table.ColumnCount(DataTable),
        ReplaceCol = (DataTableTemp, i) =>
            let
                colName = DataTableColumns{i},
                
                ReplaceTable = Table.ReplaceValue(DataTableTemp,each Record.Field(_, colName), each if Record.Field(_, colName) is text then fnCleanSpecialCharacters(Record.Field(_, colName)) else Record.Field(_, colName),Replacer.ReplaceValue,{colName})
                
            in
                if i = Counter-1 then ReplaceTable else @ReplaceCol(ReplaceTable, i+1)
     in
        ReplaceCol(DataTable, 0),
    allColumns = Table.ColumnNames(Source),
   AllCleaned = CleanSpecialCharactersAll(Source, allColumns)
in
 AllCleaned
,
 documentation = [
    Documentation.Name = "Function Name: fnCleanSpecialCharactersALL - NOTE: This function requires fnCleanSpecialCharacters in your project", 
    Documentation.Description
    = " Purpose: Removes all special characters listed on SplitAny step in fnCleanSpecialCharacters FROM THE ENTIRE SELECTED TABLE ", 
    Documentation.LongDescription
      = "  Purpose: Removes all special characters listed on SplitAny step in fnCleanSpecialCharacters FROM THE ENTIRE SELECTED TABLE  ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: ex: Field Containing a!b@c#d$1234<>?? ", Result = "  abcd1234"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))