/*
    Written by Philip Treacy
    https://www.myonlinetraininghub.com/grouped-running-totals-in-power-query
*/

let
    Source = Dim_Location,
    BufferedValues = List.Buffer(Source[Value]),
    BufferedCountries = List.Buffer(Source[Country]),

    RT = Table.FromColumns(
    {
      Source[Country], Source[City], Source[Value],
      fnGroupedRunningTotal(BufferedValues, BufferedCountries)
    },
    {
      "Country",
      "City",
      "Value",
      "Running Total"
    })
in
    RT