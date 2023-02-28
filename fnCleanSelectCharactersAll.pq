// fnCleanSelectCharactersALL
// Name: fnCleanSelectCharactersALL - NOTE: Requires fnCleanSelectCharacters in your project
// Purpose: Removes all characters listed in CharactersToRemove parameter for an ENTIRE TABLE
// Inputs: CASE SENSITIVE - CharactersToRemove as text / TableToClean as table
// Outputs: New Query containing duplicate of TableToClean with no instances of Characters listed in CharactersToRemove parameter
// Example: Input: Chocolate Candy // CharactersToRemove: ca  //  Output: Choolte Cndy

let func = 


(CharactersToRemove as text, TableToClean as table) =>
let
    Source = (TableToClean as table),
   
   //function to replace all values in all columns with special characters removed
   CleanAllSelect = (DataTable as table, DataTableColumns as list) =>
     let
        Counter = Table.ColumnCount(DataTable),
        ReplaceCol = (DataTableTemp, i) =>
            let
                colName = DataTableColumns{i},
                
                ReplaceTable = Table.ReplaceValue(DataTableTemp,each Record.Field(_, colName), each if Record.Field(_, colName) is text then fnCleanSelectCharacters(Record.Field(_, colName),CharactersToRemove) else fnCleanSelectCharacters(Record.Field(_, colName),CharactersToRemove),Replacer.ReplaceValue,{colName})
                //ReplaceTable = Table.ReplaceValue(DataTableTemp, each col, each if col is number then col*100 else col, Replace.ReplaceValue, colName)
            in
                if i = Counter-1 then ReplaceTable else @ReplaceCol(ReplaceTable, i+1)
     in
        ReplaceCol(DataTable, 0),
    allColumns = Table.ColumnNames(Source),
    CleanSelectAll = CleanAllSelect(Source, allColumns)
   
in
    CleanSelectAll,
 documentation = [
    Documentation.Name = "Function Name: fnCleanSelectCharactersALL - NOTE: Requires fnCleanSelectCharacters in your project", 
    Documentation.Description
    = " Purpose: Removes all characters listed in CharactersToRemove parameter for an ENTIRE TABLE ", 
    Documentation.LongDescription
      = "  Purpose: Removes all characters listed in CharactersToRemove parameter for an ENTIRE TABLE  ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Table field containing value: InputValue: Chocolate Candy // CharactersToRemove: ca  ", Result = "  Choolte Cndy"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))