// 3_fnSharePointItemRetrieval
let 
// ----------------------- Documentation ----------------------- 
documentation_ = [
Documentation.Name =  " fnSharePointItemRetrieval
", Documentation.Description = " Retrieves list of SharePoint lists/libraries from site specified in SharePointURL parameter, then upon invocation creates a table which pulls back item details for all items on the list. 
" , Documentation.LongDescription = "  Retrieves list of SharePoint lists/libraries from site specified in SharePointURL parameter, then upon invocation creates a table which pulls back item details for all items on the list. .
", Documentation.Category = " Table
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


    Source = fnGetSharePointListItems(Selection)

in
    Source,
// ----------------------- New Function Type ----------------------- 
type_ = type function (
     
      Selection as (type text meta [
                            Documentation.FieldCaption = "Select SharePoint List",
                            Documentation.FieldDescription = "Select SharePoint List",
                            Documentation.AllowedValues = #"2_SharePointListTable"[Title]
                            ])
        )
    as table meta documentation_,

// Replace the extisting type of the function with the individually defined
Result =  Value.ReplaceType(function_, type_)
 in 
Result

