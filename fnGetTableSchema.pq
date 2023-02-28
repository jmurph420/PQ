// fnGetTableSchema
// Name: fnGetTableSchema
// Purpose: Retrieves Table schema for selected table and generates table
// Inputs: TableName
// Outputs: Table with schema for selected table


let func = 


(TableName as table) =>

let
    Source = Table.Schema(TableName)
   
    //MakeTable = Table.FromList(Source),
    //RenameColumn = Table.RenameColumns(MakeTable,{"Column1", "Field_Names"})
    
    //TransposeRows = Table.Transpose(MakeTable),
   // PromoteHeaders = Table.PromoteHeaders(TransposeRows, [PromoteAllScalars=true])
   
   
   
in
  Source,

 documentation = [
    Documentation.Name = "Function Name: fnGetTableSchema", 
    Documentation.Description
    = " Purpose: Retrieves Table schema for selected table and generates table", 
    Documentation.LongDescription
      = "  Purpose: Retrieves Table schema for selected table and generates table", 
    Documentation.Category = " Data Utility ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: TableName", Result = " Table with schema for selected table"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))