// fnColumnRunningTotal
// Name: fnRunningColumnTotal
// Purpose: Adds a new column to a table with the running total of field selected in AmountColumn parameter
// Inputs: Table column containing numeric values
// Outputs: Line by line running total of column selected in AmountColumn Parameter
// Example: Input:  10 | 15 | 35  //  Output: 10 | 25 | 60

let
func = (Table as table,  AmountColumn as text,  SortColumn as text) =>

let
/* Debug parameters
Table = #"Price Paid", 
SortColumn = "Date", 
AmountColumn = "Price paid",
*/

// Sort table and buffer it
    Sorted = Table.Buffer(Table.AddIndexColumn(Table.Sort(Table,{{SortColumn, Order.Ascending}}), "Index",1,1)),
// Select the Columns
    SelectColumns = Table.SelectColumns(Sorted, {SortColumn, AmountColumn, "Index"}),
// Extract Amount column and buffer it
    ExtractAmountColumn = List.Buffer(Table.Column(SelectColumns, AmountColumn)),
// Calculate a list with all running Totals
    RunningTotal = List.Skip(List.Generate( ()=> [ListItem=0, Counter=0]
                                            ,each [Counter] <= List.Count(ExtractAmountColumn)
                                            ,each [ ListItem = ExtractAmountColumn{[Counter]}+[ListItem],
                                                    Counter = [Counter]+1
                                                   ]
                                            ),1),
    ConvertedTable = Table.FromList(RunningTotal, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandedColumn = Table.ExpandRecordColumn( ConvertedTable, "Column1", {"ListItem", "Counter"}, {"ListItem", "Counter"}),
    MergedQueries = Table.NestedJoin(Sorted,{"Index"}, ExpandedColumn,{"Counter"},"Expanded Column1",JoinKind.LeftOuter),
    Expand = Table.ExpandTableColumn( MergedQueries, "Expanded Column1", {"ListItem"}, {"RunningTotal"}),
    #"Removed Columns" = Table.RemoveColumns(Expand,{"Index"}),
    #"Changed Type" = Table.TransformColumnTypes(#"Removed Columns",{{"RunningTotal", type number}})
in
    #"Changed Type"
//*
, 
    documentation = [ Documentation.Name =  "fnColumnRunningTotal"
        ,Documentation.Description = "Adds a new column to a table with the running total of field selected in AmountColumn parameter"
        ,Documentation.LongDescription = "Adds a new column to a table with the running total of field selected in AmountColumn parameter"
        ,Documentation.Category = " Table"
        ,Documentation.Source = " local"
        ,Documentation.Author = " Imke Feldmann: www.TheBIccountant.com"
        ,Documentation.Examples = {[Description =  " ", Code = "10 | 15 | 35  ", Result = "10 | 25 | 60 "]}] 
 in 
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))