let
    func = (Expression as any, Values as list, Results as list, optional Else as any) =>
        try Results{List.PositionOf(Values, Expression)} otherwise if Else = null then "Value not found" else Else,
    documentation = [
        Documentation.Name = " M.Switch
",
        Documentation.Description = " Evaluates an  <code>Expression</code>  against a list of  <code>Values</code>  and returns one or multiple possible  <code>Results</code>  expressions.
",
        Documentation.LongDescription = " Evaluates an  <code>Expression</code>  against a list of  <code>Values</code>  and returns one or multiple possible  <code>Results</code>  expressions.
",
        Documentation.Category = " Other
",
        Documentation.Source = " https://wp.me/p6lgsG-Oa .
",
        Documentation.Author = " Imke Feldmann: www.TheBIccountant.com .
",
        Documentation.Examples = {
            [
                Description = " see: https://wp.me/p6lgsG-Oa . 
",
                Code = " M.Switch(2, {1..3}, {""January"", ""February"", ""March""}, ""Unknown month number"")
 ",
                Result = " ""February""
"
            ]
        }
    ]
in
    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
