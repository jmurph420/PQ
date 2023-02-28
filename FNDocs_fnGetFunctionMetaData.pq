// fnGetFunctionMetaData
// Name: fnGetFunctionMetaData
// Purpose: Returns function metadata on selected #shared and user created functions
//          with the exception of r.execute, python.execute, and AtScale.Cubes, as they return errors
// Inputs: FunctionName as text
// Outputs: When called individually, details on a single function. When used as an invoked function
//          on a custom column, details on all #shared and user created functions
// Example: 

let func = 

( FunctionName as text ) =>                                                                                      
    let
        SharedLibrary = #shared,
        ToTable = Record.ToTable ( SharedLibrary ),
        GetFunction = Table.SelectRows ( ToTable, each [Name] = FunctionName )[Value]{0},
        Source = Value.Metadata ( Value.Type ( GetFunction ) ),                                                                                                                      
        ConvertToTable = Record.ToTable ( Source ),
        PivotName = 
            Table.Pivot (
                ConvertToTable,
                List.Distinct ( ConvertToTable[Name] ),
                "Name",
                "Value"
            ),
        ExpandExamplesToRecord = Table.ExpandListColumn ( PivotName, "Documentation.Examples" ),
        ExpandExamplesToText = 
            Table.ExpandRecordColumn (
                ExpandExamplesToRecord,
                "Documentation.Examples",
                { "Description", "Code", "Result" },
                {
                    "Documentation.Examples.Description",
                    "Documentation.Examples.Code",
                    "Documentation.Examples.Result"
                }
            )
    in
        ExpandExamplesToText,
 documentation = [
    Documentation.Name = "Function Name: fnGetFunctionMetaData", 
    Documentation.Description
    = " Purpose: Returns function metadata on selected #shared and user created functions with the exception of r.execute, python.execute, and AtScale.Cubes, as they return errors ", 
    Documentation.LongDescription
      = "  When called individually, details on a single function. When used as an invoked function on a custom column, details on all #shared and user created functions ", 
    Documentation.Category = " Documentation ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "  ", Result = "  "]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))