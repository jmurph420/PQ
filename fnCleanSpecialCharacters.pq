// Name: fnCleanSpecialCharacters
// Purpose: Removes all special characters listed on SplitAny step
// Inputs: Text_To_Clean as text
// Outputs: Text string with no instances of Special Characters from the SplitAny step
// Example: Input: a!b@c#d$1234<>??  //  Output: abcd1234 // -- Code Change Check Test


let func = 


(Text_To_Clean as text) =>
let
    Source = Text_To_Clean,
  
   SplitAny = Text.SplitAny(Source,"!@#$%^&*()_- — – +={[}]|\?/>.<,{}`~#(tab)#(cr)#(lf)#(00A0):;' """" " ),
   ListRemover = List.RemoveNulls(SplitAny),  
   TextCombine = Text.Clean(Text.Combine(SplitAny, ""))
 
 in
  TextCombine,

 documentation = [
    Documentation.Name = "Function Name: fnCleanSpecialCharacters", 
    Documentation.Description
    = " Purpose: Removes special characters - !@#$%^&*()_- — – +={[}]|\?/>.<,{}`~#(tab)#(cr)#(lf)#(00A0):;' """" from a string ", 
    Documentation.LongDescription
      = "  Purpose: Removes special characters - !@#$%^&*()_- — – +={[}]|\?/>.<,{}`~#(tab)#(cr)#(lf)#(00A0):;' """"  from a string  ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: a!b@c#d$1234<>?? ", Result = "  abcd1234"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))