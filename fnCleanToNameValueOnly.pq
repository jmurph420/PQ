// fnCleanToNameValuesOnly
// Name: fnCleanToNameValuesOnly
// Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space
// Inputs: EnterText as text - String containing Non-alpha characters to remove
// Outputs: Text string with only A-Z, a-z, and space
// Example: Input: Chocolate Candy1234 b!a@r# // Output: Chocolate Candy bar

let func = 
(EnterText as text) =>

let
    Source = EnterText,
    CleanText = Text.Select( Source, {"A".."Z","a".."z","–","-","—"," "})
in
    CleanText,
 documentation = [
    Documentation.Name = "Function Name: fnCleanToNameValuesOnly", 
    Documentation.Description
    = " Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space", 
    Documentation.LongDescription
      = " Purpose: Removes all characters except A-Z, a-z, hypen, dash, and space", 
    Documentation.Category = "Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "Jane O'Rourke-Doe ", Result = "Output: Jane ORourke-Doe"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))