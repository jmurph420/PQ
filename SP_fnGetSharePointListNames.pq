
// fnGetSharePointListNames
let func = 

() =>


    let
        Source = OData.Feed(#"1_SharePointURL"  & "/_api/web/lists/?$Select=Title&$filter=Hidden eq false", null, [Implementation="2.0"]),
       
        ChangeDataTypes = Table.TransformColumnTypes(Source,{{"Title", type text}})
       
    in
        ChangeDataTypes,


 documentation = [
    Documentation.Name = "Function Name: fnGetSharePointListNames", 
    Documentation.Description
    = " Purpose: Retrieve all user accessible SharePoint Lists from SharePointURL  Parameter in a new query", 
    Documentation.LongDescription
      = "  Purpose: Retrieve all user accessible SharePoint Lists from SharePointURL  Parameter in a new query", 
    Documentation.Category = " SharePoint Actions ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " https://YourSite.SharePoint.com/Sites/SiteName ", Result = " List of User Accessible SharePoint lists from SharePoint URL Parameter."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))