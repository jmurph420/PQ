// fnCleanSelectCharacters
// Name: fnCleanSelectCharacters
// Purpose: Removes all characters listed on SplitAny step
// Inputs: InputValue as text / CASE SENSITIVE - CharactersToRemove as text
// Outputs: Text string with no instances of Characters listed in InputValue parameter
// Example: Input: Chocolate Candy // CharactersToRemove: ca  //  Output: Choolte Cndy

let func = 

(InputValue as text, CharactersToRemove as text) =>

let
    
    Source = InputValue, 
   
    SplitAny = Text.SplitAny(Source,CharactersToRemove),
    ListRemover = List.RemoveNulls(SplitAny),  
    TextCombine = Text.Combine(SplitAny, "")

in
    TextCombine,
 documentation = [
    Documentation.Name = "Function Name: fnCleanSelectCharacters", 
    Documentation.Description
    = " Purpose: Removes all instances of characters listed in CharsToRemove from a string - CASE SENSITIVE ", 
    Documentation.LongDescription
      = "  Purpose: Removes all instances of characters listed in CharsToRemove from a string - CASE SENSITIVE  ", 
    Documentation.Category = " Data Cleansing ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " InputValue: Chocolate Candy // CharactersToRemove: ca  ", Result = "  Choolte Cndy"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))