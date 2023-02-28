// fnExtractFieldToNewQuery
// Name: fnExtractFieldToNewQuery
// Purpose: Extract Single field from table to a new STATIC query, i.e., will not update. 
// Inputs: FieldName as list, NewFieldName as text
// Outputs: New Query containing static values from original column.
let func = 


let
    Source = (FieldName as list, NewFieldName as text) =>

let
    Source = Table.ColumnNames(FieldName),
    MakeTable = Table.FromList(Source)
    , Test2 = Embedded.Value(FieldName,""),
    MakeSeparateTable = Table.FromList(Test2, Splitter.SplitByNothing(),  {NewFieldName}, null, ExtraValues.Error)

   
in
  MakeSeparateTable
in
    Source,
documentation = [
    Documentation.Name = "Function Name: fnExtractFieldToNewQuery", 
    Documentation.Description
    = " Purpose: Extract Single field from table to a new STATIC query, i.e., will not update.", 
    Documentation.LongDescription
      = "  Extract Single field from table to a new STATIC query, i.e., will not update.", 
    Documentation.Category = " Table Manipulation ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: Selected field from query ", Result = " New Query with single column containing static values from original"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))