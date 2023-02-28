// SelfJoinTableExample
let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45Wcs7PLUjMq1RwVIrVQfCcUHjOSrGxAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type text) meta [Serialized.Text = true]) in type table [Company = _t]),
    
    // Add a custom column using the name of the last step. The name of the step is a table unto itself, which allows the self-join of a table, which you can expand in the next step.

    AddLastStepAsColumn = Table.AddColumn(Source, "SelfJoinTable", each Source),
    // Self joining a table creates a matrix, wherein the result provided an equal amount of rows for each item in the table. For Example: if your joined field has 10 values prior to the join, you will have 10x the amount values after the join. 
    ExpandTableFromStep = Table.ExpandTableColumn(AddLastStepAsColumn, "SelfJoinTable", {"Company"}, {"Company.1"})
in
    ExpandTableFromStep