// fnCleanCurlyBrackets
// Name: fnCleanCurlyBrackets
// Purpose: Removes Curly Brackets from values - good for any type of code using {}
// Inputs: CurlyBrackets as text
// Outputs: Text string with no instances of {}
// Example: Input: Name: MyArray, Value: {1},{2},{3}  //  Output: Name: MyArray, Value 1,2,3

let func = 

(CurlyBrackets as text) =>
let
    Source = Text.From(CurlyBrackets),
    SplitAny = Text.SplitAny(Source,"{}"),
    //ListAlternate = List.Alternate(SplitAny,1,1,1),
    ListRemover = List.RemoveNulls(SplitAny),
    
    TextCombine = Text.Combine(ListRemover, " ")
in
  Text.Combine,

 documentation = [
    Documentation.Name = "fnCleanCurlyBrackets", 
    Documentation.Description
      = " Purpose: Removes Curly Brackets from values - good for any type of code using {} ", 
    Documentation.LongDescription
      = " Purpose: Removes Curly Brackets from values - good for any type of code using {}  ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Name: MyArray, Value: {1},{2},{3} ", Result = "  Name: MyArray, Value 1,2,3"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))