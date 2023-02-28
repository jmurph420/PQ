// _SharePointCodeBankInstructions
let
    Source = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("lVRNTxsxEP0ro/QC1WYXKIWqN8qHhEQhSuiJcnB2Z7MGr8f4gyj/vjPekJSKQ3Oz7Dcz78288cPD6HBUjM49qoig4ILq1KONcKPnXvkVtORhRcnDOTUIP5R9BrLDzaxTHiekGT3THD2Gizu4vbuHFBCCUzUG0BZih2DW2azqEfamaLhaA5Hg1/QGLm1NjbaLfSYiZO5sjcBlk+NKHg3VKmo+UrslMXosmLli9H3yVii9og+M4jygbAMBIyjnPDmvRZpD3+sgiPCRgLXcXRkcMfjSRvRZpSeKWREL+6hDBWC5KKGL0YXvVbVcLstzspEClVtkWVNfAYzH3JeQPEomUE2TK0SvtBGJPJal8izTqNDBXrVz7768Y+5U7DasN8ASrlvQEXRgZ2RxXNc06AsYQp9SiFvlw1uecQF6GxnSfBOHOU4FmLBeG6/ydTVL8wEgKtQuMo7fycj2Ysw/hh2q5EbW2eiN+HIW0cHhMJMCfq4En/Myh/kuHL4y+ILs73RwcHQaoSE24Cp2MibpKQ++D3D0eXxcSLoTYboCls+NcY58zPNMtpbsIXcuM+2UXeAmVSGXQwljYM4ynofJeeI9C0xhqHDCp9vqLBOT8wQ9e6WHM5hi65HNojieeB2yGkYI/UOIus9LAi8JZe3XfEQAG24QesrIGRqs47tuy7l0L9Bqg9B66vNNw6vHvVhajmeXyE5q+0rPmF/f8u9U/xsjp5jLSo7rnK6BqzV279P+OnqBVvTxm8rWxZBMFKp55qeS9G8Bb8WqITpkiYNJhhbjq6YUIEh0FtLK32J0reaGve4M/3Vv6Jq8lw6tmXhKTp6yJXlYT/z2/6If/wA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [#"Step Number" = _t, Instructions = _t, #"Relates To Item" = _t, FrequencyPerformed = _t]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Step Number", type text}, {"Instructions", type text}, {"Relates To Item", type text}})
in
    #"Changed Type"

// 1_CodeImportURL
"https://k2share.sharepoint.com/sites/k2federal/" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// 1a_CodeImportPath
"Power BI Resources/CodeBank/" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// 1b_CodeBankRootFolder
"Power BI Resources" meta [IsParameterQuery=true, Type="Text", IsParameterQueryRequired=true]

// 2_SPListTableCodeImport
// This query executes function 2a_fnGetSPListsCodeImport, retrieving the names of the SharePoint Lists from the site specified in Parameter 1. The list is then used in Step 3, 3_fnGetSPListsItemRetrievalCodeImport

let
    
    Source = #"1_CodeImportURL",
    ConvertToTable = #table(1, {{Source}}),
    RenameColumn1 = Table.RenameColumns(ConvertToTable,{{"Column1", "SharePointDomain"}}),
    // This step executes function 2a_fnGetSPListsCodeImport, retrieving the names of the SharePoint Lists from the site specified in Parameter 1
    GetListNames = Table.AddColumn(RenameColumn1, "fnGetSharePointListNames", each #"2a_fnGetSPListsCodeImport"()),
    ExpandFields = Table.ExpandTableColumn(GetListNames, "fnGetSharePointListNames", {"Title"}, {"Title"}),
    RemoveURL = Table.RemoveColumns(ExpandFields,{"SharePointDomain"})
in
    RemoveURL

// 2a_fnGetSPListsCodeImport
let
    Source = let func = 

() =>


    let
        Source = OData.Feed(#"1_CodeImportURL"  & "/_api/web/lists/?$Select=Title&$filter=Hidden eq false", null, [Implementation="2.0"]),
       
        ChangeDataTypes = Table.TransformColumnTypes(Source,{{"Title", type text}})
       
    in
        ChangeDataTypes,


 documentation = [
    Documentation.Name = "Function Name: 2a_fnGetSPListsCodeImport", 
    Documentation.Description
    = " Purpose: Retrieve all user accessible SharePoint Lists from Parameter1_CodeImportURL Parameter into a new query", 
    Documentation.LongDescription
      = "  Purpose: Retrieve all user accessible SharePoint Lists from Parameter1_CodeImportURL Parameter into a new query", 
    Documentation.Category = " SharePoint Actions ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " https://YourSite.SharePoint.com/Sites/SiteName ", Result = " List of User Accessible SharePoint lists from SharePoint URL Parameter."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
in
    Source

// 3_fnGetSPListsItemRetrievalCodeImport
/*
This query depends on:
    2_SPListTableCodeImport for the values in the dropdown
    3a_fnGetSPListItemsCodeImport as the executed function using the selected value as the parameter passed to 3a..
*/

let 
// ----------------------- Documentation ----------------------- 
documentation_ = [
Documentation.Name =  "Name: 3_fnGetSPListsItemRetrievalCodeImport
", Documentation.Description = "" , 

Documentation.LongDescription = "Executes function, 3a_fnGetPowerQueryInfo, is then used as the source for 4_CodeAvailable to Transport.  This function returns all .PQ files stored in the root of the directory specified in Parameter 1b_CodeBankRootFolder.
", Documentation.Category = "
", Documentation.Source = "  . 
", Documentation.Author = " Jordan Murphy . 
", Documentation.Examples = {[Description =  "  .
" , Code = " 
 ", Result = " 
"]}],

// ----------------------- Function Code ----------------------- 
function_ =  
(Selection as text ) =>
let


    Source = #"3a_fnGetPowerQueryInfo"(Selection)

in
    Source,
// ----------------------- New Function Type ----------------------- 

type_ = type function (
     
      Selection as (type text meta [
                            Documentation.FieldCaption = "//Disabled// Select SharePoint List",
                            Documentation.FieldDescription = "//Disabled// Select SharePoint List",
                            Documentation.AllowedValues = ""// #"2_SPListTableCodeImport"[Title]
                            ])
        )
    as table meta documentation_,

// Replace the extisting type of the function with the individually defined
Result =  Value.ReplaceType(function_, type_)
 in 
Result

// 3a_fnGetPowerQueryInfo
//*** DO NOT USE AS Standalone function *** Function Name: 3a_fnGetPowerQueryInfo *** DO NOT USE AS Standalone function ***

//Purpose: Retrieve all user accessible Power Query (.pq) file names from Parameter 1b_CodeBankRootFolder using the SharePoint REST API

// You will have to authenticate to your SharePoint Server prior to, or part of executing this function. 

let
    Source = let func = 

(ListTitle as text) =>


    let

    ListTitle = #"1b_CodeBankRootFolder", // This is the SharePoint List Title where the .pq files are stored
             
        Source = OData.Feed(#"1_CodeImportURL"  & "/_api/web/lists/GetByTitle('"& ListTitle & "')/Items?$Select=FileSystemObjectType,File", null, [Implementation="2.0"]),
       FilterToFile = Table.SelectRows(Source, each ([FileSystemObjectType] = 0)),
    ExpandFile = Table.ExpandRecordColumn(FilterToFile, "File", {"Name", "TimeCreated", "TimeLastModified", "UIVersionLabel"}, {"Name", "Created", "Modified", "Version"}),
    FilterToPQ = Table.SelectRows(ExpandFile, each Text.EndsWith([Name], ".pq"))
in
    FilterToPQ,

 documentation = [
    Documentation.Name = "*** DO NOT USE AS Standalone function *** Function Name: 3a_fnGetPowerQueryInfo *** DO NOT USE AS Standalone function ***" , 
    Documentation.Description
    = " Purpose: Retrieve all user accessible Power Query (.pq) file names from Parameter 1b_CodeBankRootFolder", 
    Documentation.LongDescription
      = "   Purpose: Retrieve all user accessible Power Query (.pq) file names from Parameter 1b_CodeBankRootFolder", 
    Documentation.Category = " CodeImporterTool", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "  ", Result = " ."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
in
    Source

// 4_CodeAvailableToImport
/*
This query depends on: 
    3_fnGetSPListsItemRetrievalCodeImport
    1b_CodeBankRootFolder

This query executes 3_fnGetSPListsItemRetrievalCodeImport using the value from 1b_CodeBankRootFolder and returns the name, created, modified, and Version values of all PQ files stored in the SharePoint CodeBank Root Folder
*/

let
    Source = #"3_fnGetSPListsItemRetrievalCodeImport"(#"1b_CodeBankRootFolder"),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"Created", type datetime}, {"Modified", type datetime}, {"Version", type number}, {"FileSystemObjectType", type number}, {"Name", type text}}),
    #"Sorted Rows" = Table.Sort(#"Changed Type",{{"Name", Order.Ascending}})
in
    #"Sorted Rows"

// 5_SelectCodeToImport
/*
This function depends on: 
    #"4_CodeAvailableToImport"

This function calls: 
    #"6_ImportCodeFromSelection" using the value from the dropdown list

*/

let 
// ----------------------- Documentation ----------------------- 
documentation_ = [
Documentation.Name =  "Name: 5_SelectCodeToImport
", Documentation.Description = " Retrieves list of Power Query (.pq)  from list returned by 4_CodeAvailableToImport. Upon invocation calls 6_ImportCodeFromSelection, which imports the code as a new function/query in the 'Other Queries' group, named 'Invoked Function(#)'. After verifying the imported code, ensure to rename the function/query and place in the appropriate group
" , Documentation.LongDescription = "  Retrieves list of Power Query (.pq)  from list returned by 4_CodeAvailableToImport. Upon invocation calls 6_ImportCodeFromSelection, which imports the code as a new function/query in the 'Other Queries' group, named 'Invoked Function(#)'. After verifying the imported code, ensure to rename the function/query and place in the appropriate group
", Documentation.Category = " Code Bank
", Documentation.Source = "  . 
", Documentation.Author = " Jordan Murphy . 
", Documentation.Examples = {[Description =  "  .
" , Code = " 
 ", Result = " 
"]}],

// ----------------------- Function Code ----------------------- 
function_ =  
(Selection as text ) =>
let


    Source = #"6_ImportCodeFromSelection"(Selection)

in
    Source,
// ----------------------- New Function Type ----------------------- 
type_ = type function (
     
      Selection as (type text meta [
                            Documentation.FieldCaption = "Select Power Query File",
                            Documentation.FieldDescription = "Select Power Query File ",
                            Documentation.AllowedValues = #"4_CodeAvailableToImport"[Name]
                            ])
        )
    as table meta documentation_,

// Replace the extisting type of the function with the individually defined
Result =  Value.ReplaceType(function_, type_)
 in 
Result

// 6_ImportCodeFromSelection
let
    Source = let func = 
    
(PQFileName as text ) =>


let

SiteURL = #"1_CodeImportURL",
FolderPath = #"1a_CodeImportPath", 
ImportObject = PQFileName,
FullName = SiteURL & FolderPath & ImportObject,
Source2 = Text.FromBinary(Web.Contents(FullName)),
fnImportCode = Expression.Evaluate(Source2,#shared)
in
    fnImportCode

    ,

 documentation = [
    Documentation.Name = "*** DO NOT USE AS Standalone function *** Function Name: 6_ImportCodeFromSelection *** DO NOT USE AS Standalone function ***" , 
    Documentation.Description
    = " Purpose: Retrieve all user accessible Power Query (.pq) file names from Parameter 1b_CodeBankRootFolder", 
    Documentation.LongDescription
      = "   Purpose: Using PQFileName as an input...", 
    Documentation.Category = " CodeImporterTool", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "  ", Result = " ."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
in
    Source

// zz_fnSingleObjectSpecifyImport
(PQFileName as text ) =>


let

SiteURL = #"1_CodeImportURL",
FolderPath = "Power BI Resources/CodeBank/", 
ImportObject = PQFileName,

    Source = SharePoint.Files(SiteURL, [ApiVersion = 15]),
    FilterToPQ = Table.SelectRows(Source, each ([Extension] = ".pq")),
    QueryBinaryData = FilterToPQ{[Name=ImportObject,#"Folder Path"=SiteURL & FolderPath]}[Content],
    ImportObjectBinary = (Text.FromBinary(QueryBinaryData)),
    fnImportCode = Expression.Evaluate(ImportObjectBinary,#shared)
in
    fnImportCode

// zz_SingleObjectImport
let
    Source = Text.FromBinary(Web.Contents("https://k2share.sharepoint.com/sites/K2Federal/Power%20BI%20Resources/CodeBank/Dim_ColorPallette.pq")),
    Custom1 = Expression.Evaluate(Source,#shared)
in
    Custom1

// zz_fnGetSPListsCodeImport2
// Name: fnGetSharePointLists
// Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details
// Inputs: SharePointURL parameter as text - e.g. https://YourSite.SharePoint.com/Sites/SiteName
// Outputs: 8 Field Query with name: "Invoked Function (#)", with basic list description for all user accessible SharePoint Lists, including Items field - Structured table field, allowing retrieval of all files/items
//          and associated properties.  ** USE CAUTION when expanding items field for lists with high item count, as this will be very slow.
//          If connection to list with high item count is necessary, a more refined REST API ODATA query may be more suitable. 


let
    Source = let func = 

()  => 


 
    let
        Source = OData.Feed(#"1_CodeImportURL"  & "/_api/web/lists/?$Select=Title,EntityTypeName,Description,ID,BaseTemplate,ItemCount,Created,Items&$expand=Items&$filter=Hidden eq false", null, [Implementation="2.0"]),
        RenameFields = Table.RenameColumns(Source,{{"EntityTypeName", "GetByName"}, {"Id", "GetByID"}}),
        ReorderFields = Table.ReorderColumns(RenameFields,{"Title", "GetByName", "GetByID", "Description", "BaseTemplate", "ItemCount", "Created", "Items"}),
        ChangeDataTypes = Table.TransformColumnTypes(ReorderFields,{{"Title", type text}, {"GetByName", type text}, {"GetByID", type text}, {"Description", type text}, {"BaseTemplate", Int64.Type}, {"ItemCount", Int64.Type}, {"Created", type datetime}})
       
in
    ChangeDataTypes
   ,


 documentation = [
    Documentation.Name = "Function Name: fnGetSharePointLists", 
    Documentation.Description
    = " Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details", 
    Documentation.LongDescription
      = "  Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details", 
    Documentation.Category = " SharePoint Actions ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "Uses value from parameter SharePointURL to return list of lists", Result = " 8 Field Query with name: 'Invoked Function (#)', with basic list description for all user accessible SharePoint Lists, including Items field - Structured table field, allowing retrieval of all files/items and associated properties.  ** USE CAUTION when expanding items field for lists with high item count, as this will be very slow. If connection to list with high item count is necessary, a more refined REST API ODATA query may be more suitable."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
in
    Source