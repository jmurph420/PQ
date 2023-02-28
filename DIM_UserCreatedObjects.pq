// GetUserCreatedObjects
let
    Source = #sections,
    Section1 = Source[Section1],
    ConvertToTable = Record.ToTable(Section1),
    SortByName = Table.Sort(ConvertToTable,{{"Name", Order.Ascending}})
in
    SortByName