// fnURLDecoder
// Name: fnURLDecoder
// Purpose: Decodes URI / URL Parts
// Inputs: URLToDecode as Text
// Outputs: Column containing decoded URL values

let func =   
 
    (URLToDecode as text) as text => 
        let t1 = Text.Replace (URLToDecode, "?", Character.FromNumber (29) ), // ? -> <group separator> 
            t2 = Text.Replace (t1, "&", Character.FromNumber (30) ), // & -> <record separator>
            t3 = Uri.Parts("http://foo?a=" & t2)[Query][a],
            t4 = Text.Replace(t3, Character.FromNumber (29), "?" ),
            decoded = Text.Replace(t4, Character.FromNumber (30), "&" )
        in decoded

        ,
    
documentation = [
Documentation.Name =  " fnURLDecoder",
Documentation.Description = " Decodes URI / URL Parts, converting to readable URL Format. ",
Documentation.LongDescription = " Decodes URI / URL Parts, converting to readable URL Format.  ",
Documentation.Category = " Table.ColumnOperations ",
Documentation.Source = " n/a . ",
Documentation.Version = " 2.0 ",
Documentation.Author = "Jordan Murphy ",
Documentation.Examples = {[Description =  "  ",
Code = "Starting URL: https%3A%2F%2Fk2share.sharepoint.com%2Fsites%2FK2Federal%3FID%3D3%26env%3DEmbedded.",

Result = " https://k2share.sharepoint.com/sites/K2Federal?ID=3&env=Embedded"]}]
  
 in  
  Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))