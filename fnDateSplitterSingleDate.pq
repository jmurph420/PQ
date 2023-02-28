// fnDateSplitterSingleDate
// Name: fnDateSplitterSingleDate ** NOTE - Requires fnDateSplitter in your project
// Purpose: Generates 2 column table for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date
// Inputs: Date or DateTime value specified implicitly or explicitly
// Outputs: 2 column table for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date. 

let func = 


let
    Source = (InputDate as date) =>
    
    let
        DateToUse = fnDateSplitter(InputDate),
        DemoteHeaders = Table.DemoteHeaders(DateToUse),
        TransposeColumns = Table.Transpose(DemoteHeaders),
        RenameColumns = Table.RenameColumns(TransposeColumns,{{"Column1", "DatePart"}, {"Column2", "DatePartValue"}}),
        ChangeTypes = Table.TransformColumnTypes(RenameColumns,{{"DatePartValue", type text}, {"DatePart", type text}})
    in
        ChangeTypes

    
in Source,

 documentation = [
    Documentation.Name = "Function Name: fnDateSplitterSingleDate  ** NOTE - Requires fnDateSplitter in your project", 
    Documentation.Description
    = " Purpose: Generates 2 column table for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date", 
    Documentation.LongDescription
      = "  Purpose: Generates 2 column table for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date", 
    Documentation.Category = " Date Calculations ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: 9/6/2024 7:17 PM ", Result = " 2 Column Table with Groupings of Time, Date, Month, Quarter, Year, and logical date checks"]}
  ]


in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))