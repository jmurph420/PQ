// Requires Fact_RunningTotalQty
// Name: GetPreviousNextRowValue
let
    Source = Fact_RunningTotalQty,
    AddIndexFrom0 = Table.AddIndexColumn(Source, "Index", 0, 1, Int64.Type),
    AddIndexFrom1 = Table.AddIndexColumn(AddIndexFrom0, "Index.1", 1, 1, Int64.Type),
    // Merge Index.1 to Index, this will get value of Next Row
    MergeIndex1To0 = Table.NestedJoin(AddIndexFrom1, {"Index.1"}, AddIndexFrom1, {"Index"}, "Added Index1", JoinKind.LeftOuter),
    ExpandNextValue = Table.ExpandTableColumn(MergeIndex1To0, "Added Index1", {"Value"}, {"NextRowValue"}),
    //Merge Index 0 to Index.1, this will get value of previous Row
    MergeIndex0To1 = Table.NestedJoin(ExpandNextValue, {"Index"}, ExpandNextValue, {"Index.1"}, "Expanded Added Index1", JoinKind.LeftOuter),
    ExpandPrevValue = Table.ExpandTableColumn(MergeIndex0To1, "Expanded Added Index1", {"Value"}, {"PreviousRowValue"}),
    SortOnIndex0 = Table.Sort(ExpandPrevValue,{{"Index", Order.Ascending}})
in
    SortOnIndex0