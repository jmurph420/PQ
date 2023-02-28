
// fnGetSharePointListItems
let func = 

(ListTitle as text) =>


    let
             
        Source = OData.Feed(#"1_SharePointURL"  & "/_api/web/lists/GetByTitle('"& ListTitle & "')/Items", null, [Implementation="2.0"])
       // RenameFields = Table.RenameColumns(Source,{{"EntityTypeName", "GetByName"}, {"Id", "GetByID"}}),
        //ReorderFields = Table.ReorderColumns(RenameFields,{"Title", "GetByName", "GetByID", "Description", "BaseTemplate", "ItemCount", "Created", "Items"}),
        //ChangeDataTypes = Table.TransformColumnTypes(ReorderFields,{{"Title", type text}, {"GetByName", type text}, {"GetByID", type text}, {"Description", type text}, {"BaseTemplate", Int64.Type}, {"ItemCount", Int64.Type}, {"Created", type datetime}})
    in
        Source,
       
   

 documentation = [
    Documentation.Name = "*** DO NOT USE AS Standalone function *** Function Name: fnGetSharePointLists *** DO NOT USE AS Standalone function ***" , 
    Documentation.Description
    = " Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details", 
    Documentation.LongDescription
      = "  Purpose: Retrieve all user accessible SharePoint Lists from SharePoint Root URL entered as Parameter, with further capability to extract item details", 
    Documentation.Category = " SharePoint Actions ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " *** DO NOT USE AS Standalone function *** ", Result = " Returns all items contained in list selected from fnSharePointItemRetrieval  ** USE CAUTION when expanding items field for lists with high item count, as this will be very slow. If connection to list with high item count is necessary, a more refined REST API ODATA query may be more suitable."]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))