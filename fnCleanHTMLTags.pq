// fnCleanHTMLTags
// Name: fnCleanHTMLTags
// Purpose: Removes all HTML tags from a text string
// Inputs: HTML as text
// Outputs: Text string with no instances of HTML tags
// Example: Input: <DIV style=".css">This is My Text</DIV>  //  Output: This is My Text

let func = 

(HTML as text) =>
let
    Source = Text.From(HTML),
    SplitAny = Text.SplitAny(Source,"<>"),
    ListAlternate = List.Alternate(SplitAny,1,1,1),
    ListSelect = List.Select(ListAlternate, each _<>" "),
    TextCombine = Text.Combine(ListSelect, " ")
in
TextCombine,
 documentation = [
    Documentation.Name = "Function Name: fnCleanHTMLTags", 
    Documentation.Description
    = " Purpose: Removes all HTML tags from a text string ", 
    Documentation.LongDescription
      = "  Purpose: Removes all HTML tags from a text string ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: <DIV style='.css'>This is My Text</DIV>  ", Result = "  This is My Text"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))