
// Requires: fnCleanHTMLTags, fnGetFunctionMetaData,GetAllObjects 
// Name: SharedObjectsWithAllMetaData
let
    Source = GetAllObjects,
    InvokeGetFunctionMetaData = Table.AddColumn(Source, "fnGetFunctionMetaData", each fnGetFunctionMetaData([Name])),
    RemoveErrors = Table.RemoveRowsWithErrors(InvokeGetFunctionMetaData, {"fnGetFunctionMetaData"}),
    FilterOnlyFunctions = Table.SelectRows(RemoveErrors, each ([FunctionIncluded] = true) and ([Name] <> "R.Execute")and ([Name] <> "Python.Execute") and ([Name] <> "AtScale.Cubes")),
    ExpandfnGetFunctionMetaData = Table.ExpandTableColumn(FilterOnlyFunctions, "fnGetFunctionMetaData", {"Documentation.Name", "Documentation.Description", "Documentation.LongDescription", "Documentation.Category", "Documentation.Source", "Documentation.Version", "Documentation.Author", "Documentation.Examples.Description", "Documentation.Examples.Code", "Documentation.Examples.Result"}, {"Documentation.Name", "Documentation.Description", "Documentation.LongDescription", "Documentation.Category", "Documentation.Source", "Documentation.Version", "Documentation.Author", "Documentation.Examples.Description", "Documentation.Examples.Code", "Documentation.Examples.Result"}),
    AlphaSort = Table.Sort(ExpandfnGetFunctionMetaData,{{"Name", Order.Ascending}}),
    CleanHTMLTagsFromLongDescription = Table.AddColumn(AlphaSort, "LongDescription", each try fnCleanHTMLTags([Documentation.LongDescription]) otherwise ""),
    RemoveUnnecessary = Table.RemoveColumns(CleanHTMLTagsFromLongDescription,{"FunctionIncluded", "Documentation.LongDescription"}),
    RenameFields = Table.RenameColumns(RemoveUnnecessary,{{"Documentation.Name", "Function Name"}, {"Documentation.Description", "Description"}, {"Documentation.Category", "Category"}, {"Documentation.Source", "Source"}, {"Documentation.Version", "Version"}, {"Documentation.Author", "Author"}, {"Documentation.Examples.Description", "Example Description"}, {"Documentation.Examples.Code", "Example Code"}, {"Documentation.Examples.Result", "Example Result"}, {"LongDescription", "Long Description"}}),
    ChangeDataTypes = Table.TransformColumnTypes(RenameFields,{{"Long Description", type text}, {"Example Result", type text}, {"Example Code", type text}, {"Example Description", type text}, {"Author", type text}, {"Version", type text}, {"Source", type text}, {"Category", type text}, {"Description", type text}, {"Function Name", type text}, {"Name", type text}})
in
    ChangeDataTypes