let
    //Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i45WyigpKSi20tfPNirOSCxK1QOTBfmZeSV6yfm5+sWZJanF+t5GbqkpqUWJOUqxsQA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [SharePointDomain = _t]),
    Source = #"1_SharePointURL",
    #"Converted to Table" = #table(1, {{Source}}),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "SharePointDomain"}}),
    GetListNames = Table.AddColumn(#"Renamed Columns", "fnGetSharePointListNames", each fnGetSharePointListNames()),
    ExpandFields = Table.ExpandTableColumn(GetListNames, "fnGetSharePointListNames", {"Title"}, {"Title"}),
    RemoveURL = Table.RemoveColumns(ExpandFields,{"SharePointDomain"})
in
    RemoveURL