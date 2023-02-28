let
    func = (List as list) =>
        let
            List = List.Buffer(List),
            LA = List.Accumulate(
                List.Skip(List),
                [
                    Table = Table.FromColumns({List}),
                    Counter = 2
                ],
                (prev, this) =>
                    [
                        AddColumn = Table.AddColumn(
                            prev[Table],
                            "Column" & Text.From(prev[Counter]),
                            each List.Difference(List, Record.FieldValues(_))
                        ),
                        Table = Table.ExpandListColumn(AddColumn, "Column" & Text.From(prev[Counter])),
                        Counter = prev[Counter] + 1
                    ]
            ),
            Result = LA[Table]
        in
            Result,
    documentation = [
        Documentation.Name = " List.Permutations ",
        Documentation.Description = " Creates a permuations table from all elements from a <code>List</code> ",
        Documentation.LongDescription = " Creates a permuations table from all elements from a <code>List</code> ",
        Documentation.Category = " List ",
        Documentation.Source = " https://wp.me/p6lgsG-Qz . ",
        Documentation.Version = " 2.0 (Changed from List.Generate to List.Accumulate) ",
        Documentation.Author = " Imke Feldmann: www.TheBIccountant.com . ",
        Documentation.Examples = {[
            Description = "  ",
            Code = "  ",
            Result = "  "
        ]}
    ]
in
    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
