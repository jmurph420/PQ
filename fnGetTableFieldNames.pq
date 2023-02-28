// fnGetTableFieldNames
// Name: fnGetTableFieldNames
// Purpose: Generates 1 column table containing field names from selected table
// Inputs: TableName as table
// Outputs: 1 column table containing field names from selected table. 

let func = 


(TableName as table) =>

let
    Source = Table.ColumnNames(TableName),
   
    MakeTable = Table.FromList(Source),
    RenameColumn = Table.RenameColumns(MakeTable,{"Column1", "Field_Names"})
    
    //TransposeRows = Table.Transpose(MakeTable),
   // PromoteHeaders = Table.PromoteHeaders(TransposeRows, [PromoteAllScalars=true])
   
   
   
in
  RenameColumn,

 documentation = [
    Documentation.Name = "Function Name: fnGetTableFieldNames", 
    Documentation.Description
    = " PGenerates 1 column table containing field names from selected table", 
    Documentation.LongDescription
      = "  Generates 1 column table containing field names from selected table", 
    Documentation.Category = " Data Documentation", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "  ", Result = " "]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))