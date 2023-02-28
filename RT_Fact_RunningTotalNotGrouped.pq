/*
    Written by Philip Treacy
    https://www.myonlinetraininghub.com/grouped-running-totals-in-power-query
*/

let
    Source = Fact_RunningTotalQty,
    BufferedValues = List.Buffer(Source[Value]),
    BufferedCountries = List.Buffer(Source[Country]),

    RunningTotal = Table.FromColumns(
    {
        Source[Country], Source[Value], fnGroupedRunningTotal(BufferedValues, BufferedCountries)
    },
    {
        "Country",
        "Value",
        "Running Total"
    })

in
    RunningTotal