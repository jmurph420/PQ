// fnCleanToNumberOnly
// Name: fnCleanToNumberOnly
// Purpose: Removes all characters except Removes all characters except 0-9, period, and comma
// Inputs: EnterValue as any - String containing Non-numeric characters to remove
// Outputs: Numeric string with only characters except 0-9, period, and comma
// Example: Input: Chocolate Candy1234 b!a@r# // Output: 1234

let func = 
(EnterValue as any) =>

let
    Source = EnterValue,
    CleanToNumbers = Text.Select( Source, {"0".."9", ",", "."})
in
    CleanToNumbers,
 documentation = [
    Documentation.Name = "Function Name: fnCleanToNumberOnly", 
    Documentation.Description
    = " Purpose: Removes all characters except 0-9, period, and comma", 
    Documentation.LongDescription
      = "  Purpose: Removes all characters except 0-9, period, and comma", 
    Documentation.Category = "Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = "Input: Chocolate Candy1234 b!a@r#   ", Result = "Output: 1234"],[Description = "  ", Code = "Input: 947 Any Street   ", Result = "Output: 947"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))