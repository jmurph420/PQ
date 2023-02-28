
// fnGetSharePointLists
// Name: fnGetSharePointLists
// Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details
// Inputs: SharePointURL parameter as text - e.g. https://YourSite.SharePoint.com/Sites/SiteName
// Outputs: 8 Field Query with name: "Invoked Function (#)", with basic list description for all user accessible SharePoint Lists, including Items field - Structured table field, allowing retrieval of all files/items
//          and associated properties.  ** USE CAUTION when expanding items field for lists with high item count, as this will be very slow.
//          If connection to list with high item count is necessary, a more refined REST API ODATA query may be more suitable. 


let func = 

()  => 


 
    let
        Source = OData.Feed(#"1_SharePointURL"  & "/_api/web/lists/?$Select=Title,EntityTypeName,Description,ID,BaseTemplate,ItemCount,Created,Items&$expand=Items&$filter=Hidden eq false", null, [Implementation="2.0"]),
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