// GetAllObjects
let
    GetShared = #shared,
    ConvertToTable = Record.ToTable(GetShared),
    SortByName = Table.Sort(ConvertToTable,{{"Name", Order.Ascending}}),
    CheckIfFunctionIsIncludedInSource = Table.AddColumn(ConvertToTable, "FunctionIncluded", each 
       Type.Is ( 
            Value.Type(
                    [Value]
                    )
                ,type function))
in
    CheckIfFunctionIsIncludedInSource