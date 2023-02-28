

// fnGetSingleFunctionDetails
// Name: fnGetSingleFunctionDetails
// Purpose: Retrieves Function metadata for name of function input by user
// Inputs: Function Name
// Outputs: Single row table containining function metadata for function input by user. 


let func = 
(FunctionName as text)  as any =>


let
    MyType = Value.Type(FunctionName),
    Source = Value.Metadata(Value.Type(fnCleanCurlyBrackets)),

    ConvertToTable = Record.ToTable(Source),

    PivotName = Table.Pivot(ConvertToTable, List.Distinct(ConvertToTable[Name]), "Name", "Value"),

    ExpandExamplesToRecord = Table.ExpandListColumn(PivotName, "Documentation.Examples"),
    
    ExpandExamplesToText = Table.ExpandRecordColumn(ExpandExamplesToRecord, "Documentation.Examples", {"Description", "Code", "Result"}, {"Examples Description", "Examples Code", "Examples Result"})

in 
    ExpandExamplesToText,

 documentation = [
    Documentation.Name = "Function Name: fnGetSingleFunctionDetails", 
    Documentation.Description
    = " Purpose: Retrieves Function metadata for name of function input by user", 
    Documentation.LongDescription
      = "  Purpose: Retrieves Function metadata for name of function input by user", 
    Documentation.Category = " Data Utility ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: FunctionName", Result = " Single row table containining function metadata for function input by user"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))