// fnIdentifyUnusedQueries
let
    func = (ModelJsonPath as text) =>
        let

            // Helper function                  
            fnRemoveBetweenDelimiters =
                let
                    func = (
                        TextToClean as text,
                        StartDelimiter as text,
                        EndDelimiter as text,
                        optional RemoveDelimiters
                    ) =>
                        let
                            removeDelimiters =
                                if RemoveDelimiters = null then
                                    StartDelimiter & EndDelimiter
                                else
                                    "",
                            Source = Text.From(TextToClean),
                            FirstSplit = List.Buffer(Text.Split(Source, StartDelimiter)),
                            Custom2 =
                                if List.First(FirstSplit) = "" then
                                    List.Skip(FirstSplit)
                                else
                                    FirstSplit,
                            Custom1 = List.Transform(
                                Custom2,
                                each
                                    if Text.Contains(_, EndDelimiter) then
                                        Text.AfterDelimiter(_, EndDelimiter, 0)
                                    else
                                        _
                            ),
                            ListSelect = List.Select(Custom1, each _ <> ""),
                            TextCombine = Text.Combine(ListSelect, removeDelimiters)
                        in
                            TextCombine,
                    documentation = [
                        Documentation.Name = " Text.RemoveBetweenDelimiters ",
                        Documentation.Description = " Removes text between 2 delimiters. ",
                        Documentation.LongDescription
                            = " Removes text between 2 delimiters. Option to remove the delimiters as well. Delimters are strings, so can contain multiple characters. ",
                        Documentation.Category = " Text ",
                        Documentation.Source
                            = " www.TheBIccountant.com .  https://wp.me/p6lgsG-2ak . ",
                        Documentation.Version = " 2.0 ",
                        Documentation.Author
                            = " Imke Feldmann: www.TheBIccountant.com. https://wp.me/p6lgsG-2ak . ",
                        Documentation.Examples = {[Description = "  ", Code = "  ", Result = "  "]}
                    ]
                in
                    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation)),
            Source = Json.Document(File.Contents(Text.Trim(ModelJsonPath, """"))),
            model = Source[model],
            LoadedQueries = List.Transform(model[tables], each _[partitions]{0}[source][expression]),
            #"Converted to Table" = Table.FromList(
                LoadedQueries,
                Splitter.SplitByNothing(),
                null,
                null,
                ExtraValues.Error
            ),
            LoadedQueriesTable = Table.RenameColumns(
                #"Converted to Table",
                {{"Column1", "expression"}}
            ),
            expressions = model[expressions],
            UnloadedQueries = Table.FromList(
                expressions,
                Splitter.SplitByNothing(),
                null,
                null,
                ExtraValues.Error
            ),
            ExpandUnloadedQueries = Table.ExpandRecordColumn(
                UnloadedQueries,
                "Column1",
                {
                    "name",
                    "kind",
                    "expression",
                    "queryGroup",
                    "lineageTag",
                    "annotations",
                    "description"
                }
            ),
            #"Removed Other Columns" = Table.SelectColumns(
                ExpandUnloadedQueries,
                {"name", "expression"}
            ),
            Custom1 = #"Removed Other Columns" & LoadedQueriesTable,
            Add_MCode = Table.AddColumn(
                Custom1,
                "MCode",
                each try Text.Combine([expression], "#(lf)") otherwise [expression]
            ),
            Add_RemovedMultiRowComments = Table.AddColumn(
                Add_MCode,
                "RemovedMultiRowComments",
                each fnRemoveBetweenDelimiters([MCode], "/*", "*/", true)
            ),
            Add_RemovedSingleRowComments = Table.AddColumn(
                Add_RemovedMultiRowComments,
                "RemovedSingleRowComments",
                each Text.Combine(
                    List.Transform(
                        Text.Split([RemovedMultiRowComments], "#(lf)"),
                        each Text.BeforeDelimiter(_, "//")
                    ),
                    "#(lf)"
                )
            ),
            _Staging = Table.Buffer(Add_RemovedSingleRowComments),
            CleanedQueryCode = Text.Combine(_Staging[RemovedSingleRowComments], "#(lf)"),
            AllQueryNames = List.Buffer(ExpandUnloadedQueries[name]),
            #"Converted to Table1" = Table.FromList(
                AllQueryNames,
                Splitter.SplitByNothing(),
                null,
                null,
                ExtraValues.Error
            ),
            #"Added Custom" = Table.AddColumn(
                #"Converted to Table1",
                "IsUsed",
                each Text.Contains(CleanedQueryCode, [Column1])
            ),
            #"Filtered Rows" = Table.SelectRows(#"Added Custom", each ([IsUsed] = false))
        in
            #"Filtered Rows",
    documentation = [
        Documentation.Name            = " Tool.IdentifyUnusedQueries ",
        Documentation.Description     = " Identifies unused M-Queries ",
        Documentation.LongDescription = " Identifies unused M-Queries that can be deleted. Enter path to JSON file that contains the data model definition (i.e. .bim from Tabular Editor) ",
        Documentation.Category        = " Tools ",
        Documentation.Source          = " www.TheBIcountant.com ",
        Documentation.Version         = " 1.0 ",
        Documentation.Author          = " Imke Feldmann ",
        Documentation.Examples        = {[Description = "  ", Code = "  ", Result = "  
  "
   ]}
    ]
in
    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))