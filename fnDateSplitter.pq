// Name: fnDateSplitter
// Purpose: Generate table columns for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date, or for each date in a table, by invoking a custom function
// Inputs: Date or DateTime value specified implicitly or explicitly
// Outputs: Expanded Table columns consisting of commonly used date/time transformations. 

let func = 

let
    Source = (optional UseDate as date ) =>

let
  
  DateInput = if Value.Is(UseDate, type datetime) then UseDate else DateTime.From(UseDate), // if no time value specified, time values will return as 12:00:00 a.m.

  FYStartDay ="10/01/", // Update per your Fiscal Year Start Day
  FYEndDay = "9/30/", // Update per your Fiscal Year End Day
   fnDateSplitter = Table.AddColumn(Table.FromValue(DateInput),".", each
    
     [
         CurrentDate = DateTime.LocalNow(),
		 		 
        TimeField =Time.From(DateInput),
        TimeHour = Time.Hour(DateInput),
        TimeMinute = Time.Minute(DateInput),
        TimeAMPM = if Text.EndsWith(Text.From(DateInput),"AM") = true then "AM" else "PM",
		 
        DayOfMonth=Date.Day(DateInput)as number,
       
      Last2Characters = Text.End( Number.ToText(DayOfMonth), 2 ),
      LastCharacter = Text.End( Number.ToText( DayOfMonth), 1 ),
       OrdinalSuffix = 
          if List.Contains( { "11", "12", "13" }, Last2Characters ) then Number.ToText(DayOfMonth) & "th"
          else if LastCharacter = "1" then Number.ToText(DayOfMonth) & "st"
          else if LastCharacter = "2" then Number.ToText(DayOfMonth) & "nd"
          else if LastCharacter = "3" then Number.ToText(DayOfMonth) & "rd"
          else Number.ToText(DayOfMonth) & "th",

        DayOfWeekNum=((Date.DayOfWeek(DateInput))),
        
        NextWorkDay = 
          if DayOfWeekNum = 5 then (Date.AddDays(DateInput,3)) else 
          if DayOfWeekNum = 6 then (Date.AddDays(DateInput,2)) else 
          Date.AddDays(DateInput,1),
        DayName=Date.DayOfWeekName((DateInput)),
        DayAbbr=Text.Start(Text.Upper(Date.DayOfWeekName((DateInput))),3) as text,
        DaysInMonth=Date.DaysInMonth(DateInput),
        DaysRemainingInMonth = DaysInMonth - DayOfMonth,
        DayOfYear=Date.DayOfYear(DateInput),
        DaysRemainingInYear =  Date.DayOfYear(Date.EndOfYear(DateTime.LocalNow()))-Date.DayOfYear(DateInput),
       
        DaysInYear = Date.DayOfYear(Date.EndOfYear(DateTime.LocalNow())),
        DaySorter=Text.From(Date.DayOfWeek(DateInput)) & "-" & Date.DayOfWeekName((DateInput)) as text , 


        startOfWeek = 1 ,
        Start = List.Min({Date.StartOfMonth(UseDate), Date.EndOfMonth(UseDate)}),
        End = List.Max({Date.StartOfMonth(UseDate), Date.EndOfMonth(UseDate)}),
        ListOfDates = List.Dates(Start, Number.From(End - UseDate) + 1,#duration(1,0,0,0)),
        TotalBizDays = List.Dates(Start, Number.From(End - Start) + 1,#duration(1,0,0,0)),
        DeleteWeekends = List.Select(ListOfDates, each Date.DayOfWeek(_, startOfWeek) < 5 ),
        DeleteWeekends2 = List.Select(TotalBizDays, each Date.DayOfWeek(_, startOfWeek) < 5 ),
        BusinessDaysRemaining = (List.Count(DeleteWeekends) -1   ),
        TotalBizDaysExclHolidays  = (List.Count(DeleteWeekends2) ),
        CurrentBusinessDay = TotalBizDaysExclHolidays - BusinessDaysRemaining ,


         WeekStart=Date.StartOfWeek(DateInput) as datetime,
         WeekEnd=Date.EndOfWeek(DateInput) as datetime,
         WeekInYear=Date.WeekOfYear(DateInput),
         WeeksRemainingInYear = 52-WeekInYear,
         WeekInMonth=Date.WeekOfMonth(DateInput),
         WeeksRemainingInMonth = Number.RoundUp(DaysInMonth/7) - WeekInMonth,

        

         MonthNum=Date.Month(DateInput),
         MonthName = Date.MonthName(DateInput),
         MonthAbbr=Text.Start(Text.Upper(Date.MonthName(DateInput)),3) as text,
         MonthStart = Date.StartOfMonth(DateInput),
         MonthEnd = Date.EndOfMonth(DateInput),
	       MonthSorter=Text.From(Date.Month(DateInput)) & "-" & Text.Start(Text.Upper(Date.MonthName(DateInput)),3) as text,

         Quarter=Date.QuarterOfYear(DateInput),
         QuarterStart = Date.StartOfQuarter(DateInput),
         QuarterEnd = Date.EndOfQuarter(DateInput),

        /////////////  Fiscal Year Section - If your FY is different than 1 October - 30 September, you can change

        FYDaysRemaining = if Date.Month(DateInput) >=10 then // if it is October or higher
              Number.From(

              Date.FromText(FYStartDay & 
                        Text.From(
                          Date.Year(
                              Date.AddYears(
                                  DateTime.LocalNow(),1
                                          )
                                  )
                                )
                              )  

                              - Date.StartOfYear(Date.FromText(FYStartDay & 
                        Text.From(
                          Date.Year(
                              Date.AddYears(
                                  DateTime.LocalNow(),1
                                          )
                                  )
                        ))
                              ) 

                          +            
                        Date.EndOfYear(DateInput) - (DateInput)     
              )
              

                  else  // date is before October 1st of the current year
                  
                  Date.DayOfYear(Date.FromText(FYEndDay & 
                      Text.From(
                          Date.Year(
                              DateTime.LocalNow()
                                  )
                                )
                              ))
                      - 
                        Date.DayOfYear(DateInput),
         FYDay = 365 - FYDaysRemaining,
         
        FYWeeksRemaining = if Date.Month(DateInput) >=10 then // if it is October or higher
              Number.From(
              Date.WeekOfYear(Date.FromText(FYStartDay & 
                        Text.From(
                          Date.Year(
                              Date.AddYears(
                                  DateTime.LocalNow(),1
                                          )
                                  )
                                )
                              )) )

                              - Date.WeekOfYear( Date.StartOfYear(Date.FromText(FYStartDay & 
                        Text.From(
                          Date.Year(
                              Date.AddYears(
                                  DateTime.LocalNow(),1
                                          )
                                  )
                        ))
                              ) )
                          + (52-Date.WeekOfYear(DateInput))   
          else 
      Date.WeekOfYear((Date.FromText(FYEndDay & 
                      Text.From(
                          Date.Year(
                              DateInput
                                  ))
                                )
                              ))
                      - 
                        Date.WeekOfYear(DateInput),
         FYWeekNum = 52-FYWeeksRemaining,

         FYQuarter = if MonthNum >= 10 and MonthNum <=13 then 1 
                else if MonthNum >= 1 and MonthNum<= 3 then 2 
                else if MonthNum >= 4 and MonthNum <= 6 then 3 
                else if MonthNum>= 7 and MonthNum <= 9 then 4 
                else 0,

        FYQuarterStart = if MonthNum >= 10 and MonthNum <=12 then #date(Date.Year(DateInput),10,1) 
              else if Date.Month(DateInput) >= 1 and Date.Month(DateInput) <= 3 then #date(Date.Year(DateInput),1,1)
              else if Date.Month(DateInput) >= 4 and Date.Month(DateInput) <= 6 then  #date(Date.Year(DateInput) ,4,1)
              else if Date.Month(DateInput) >= 7 and Date.Month(DateInput)<= 9 then #date(Date.Year(DateInput),7,1) 
              else #date(2099,1,1),
        FYQuarterEnd = if MonthNum >= 10 and MonthNum <=12 then #date(Date.Year(DateInput),12,31) 
              else if Date.Month(DateInput) >= 1 and Date.Month(DateInput) <= 3 then #date(Date.Year(DateInput),3,31)
              else if Date.Month(DateInput) >= 4 and Date.Month(DateInput) <= 6 then  #date(Date.Year(DateInput) ,6,30)
              else if Date.Month(DateInput) >= 7 and Date.Month(DateInput)<= 9 then #date(Date.Year(DateInput),9,30) 
              else #date(2099,1,1),
         
         FYYear = if Date.Month(DateInput) >9 then Date.Year(DateInput)+1 else Date.Year(DateInput), // yes, FYYear is redundant, it is to stick with the column naming of the other FY columns
         YearNum=Date.Year(DateInput),
         YearStart = Date.StartOfYear(DateInput),
         YearEnd = Date.EndOfYear(DateInput),
         FYStart =  Date.FromText(FYStartDay & Text.From(Date.Year(DateInput))),
         FYEnd =  Date.FromText(FYEndDay & Text.From(
           Date.Year(
             Date.AddYears(DateInput,1)
             ))),
		 //////////// End of FYSection


         IsYTD = if Date.IsInYearToDate(DateInput) = true then "Y" else "N",
         IsQTD = if DateInput <=DateTime.LocalNow() and DateInput <= Date.EndOfQuarter(DateTime.LocalNow()) then "Y" else "N",
         IsMTD = if DateInput >= Date.StartOfMonth(DateInput) and DateInput <= DateTime.LocalNow() then  "Y" else "N",

         1DayAgo = Date.AddDays(UseDate,-1),
         1MonthAgo = Date.AddMonths(UseDate,-1),
         1QuarterAgo = Number.From(Quarter) -1,
         1YearAgo = Date.AddYears(UseDate,-1)

                 
         
     ]),

    
   Expander = Table.ExpandRecordColumn(fnDateSplitter, ".", (

{"CurrentDate",	"TimeField",	"TimeHour",	"TimeMinute",	"TimeAMPM",	"DayOfMonth",	"OrdinalSuffix","DayOfWeekNum",	"DayName",	"NextWorkDay", "DayAbbr",	"DaysInMonth","DaysRemainingInMonth",	"DayOfYear",	"DaysRemainingInYear",	"DaysInYear",	"DaySorter",	
"CurrentBusinessDay", "BusinessDaysRemaining", "TotalBizDaysExclHolidays","WeekStart",	"WeekEnd",	"WeekInYear", "WeeksRemainingInYear",	"WeekInMonth", "WeeksRemainingInMonth",	"MonthNum",	"MonthName", "MonthAbbr",	"MonthStart",	"MonthEnd",	"MonthSorter",	"Quarter",	"QuarterStart",	"QuarterEnd", "YearNum",	"YearStart",	"YearEnd", 	"IsYTD",	"IsQTD",	"IsMTD", "FYDay", "FYDaysRemaining","FYWeekNum","FYWeeksRemaining","FYQuarter", "FYQuarterStart","FYQuarterEnd","FYYear", "FYStart","FYEnd", "1DayAgo", "1MonthAgo", "1QuarterAgo", "1YearAgo"
}), 

{"CurrentDate",	"TimeField",	"TimeHour",	"TimeMinute",	"TimeAMPM",	"DayOfMonth",	"OrdinalSuffix","DayOfWeekNum",	"DayName",	"NextWorkDay", "DayAbbr",	"DaysInMonth","DaysRemainingInMonth",	"DayOfYear",	"DaysRemainingInYear",	"DaysInYear",	"DaySorter",	
"CurrentBusinessDay", "BusinessDaysRemaining", "TotalBizDaysExclHolidays","WeekStart",	"WeekEnd",	"WeekInYear", "WeeksRemainingInYear",	"WeekInMonth", "WeeksRemainingInMonth",	"MonthNum",	"MonthName", "MonthAbbr",	"MonthStart",	"MonthEnd",	"MonthSorter",	"Quarter",	"QuarterStart",	"QuarterEnd", "YearNum",	"YearStart",	"YearEnd", 	"IsYTD",	"IsQTD",	"IsMTD", "FYDay", "FYDaysRemaining","FYWeekNum","FYWeeksRemaining","FYQuarter", "FYQuarterStart","FYQuarterEnd","FYYear", "FYStart","FYEnd", "1DayAgo", "1MonthAgo", "1QuarterAgo", "1YearAgo"
}),

 ChangeTypes = Table.TransformColumnTypes(Expander,{{"1YearAgo", type datetime}, {"1MonthAgo", type datetime}, {"1DayAgo", type datetime}, {"YearEnd", type datetime}, {"YearStart", type datetime}, {"QuarterEnd", type datetime}, {"QuarterStart", type datetime}, {"MonthEnd", type datetime}, {"MonthStart", type datetime}, {"WeekEnd", type datetime}, {"WeekStart", type datetime}, {"NextWorkDay", type date},{"CurrentDate", type datetime},{"TimeField", type time}, {"TimeHour", Int64.Type}, {"TimeMinute", Int64.Type}, {"DayOfMonth", Int64.Type}, {"CurrentBusinessDay", Int64.Type}, {"TotalBizDaysExclHolidays", Int64.Type}, {"BusinessDaysRemaining", Int64.Type}, {"DayOfWeekNum", Int64.Type}, {"DaysInMonth", Int64.Type}, {"DaysRemainingInMonth", Int64.Type}, {"DayOfYear", Int64.Type}, {"DaysRemainingInYear", Int64.Type}, {"DaysInYear", Int64.Type}, {"WeekInYear", Int64.Type}, {"WeeksRemainingInYear", Int64.Type}, {"WeekInMonth", Int64.Type}, {"WeeksRemainingInMonth", Int64.Type}, {"MonthNum", Int64.Type}, {"FYQuarter", Int64.Type},{"FYDay", Int64.Type}, {"FYDaysRemaining", Int64.Type}, {"FYWeekNum", Int64.Type}, {"FYWeeksRemaining", Int64.Type}, {"FYYear", Int64.Type}, {"FYQuarterStart", type date},{"FYQuarterEnd", type date},{"FYStart", type date}, {"FYEnd", type date},{"Quarter", Int64.Type}, {"1QuarterAgo", Int64.Type}, {"IsMTD", type text}, {"IsQTD", type text}, {"IsYTD", type text}, {"MonthSorter", type text}, {"MonthAbbr", type text}, {"DaySorter", type text}, {"DayAbbr", type text}, {"DayName", type text},{"MonthName", type text}, {"OrdinalSuffix", type text}, {"TimeAMPM", type text}, {"YearNum", Int64.Type}})
    

in ChangeTypes
in
    Source,

 documentation = [
    Documentation.Name = "Function Name: fnDateSplitter", 
    Documentation.Description
    = " Purpose: Generate table columns for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date, or for each date in a table, by invoking a custom function ", 
    Documentation.LongDescription
      = "  Purpose: Generate table columns for commonly used date parts in grouping/aggregating date information in Excel/PowerBI for a single date, or for each date in a table, by invoking a custom function  ", 
    Documentation.Category = " Date Calculations ", 
    Documentation.Source = "    ", 
    Documentation.Version = " 1.1 ", 
    Documentation.Author = " Jordan Murphy", 
    Documentation.Examples = {[Description = "  ", Code = " Input: 9/6/2024 7:17 PM ", Result = " Groupings of Time, Date, Month, Quarter, Year, and logical date checks"]}
  ]

in

 Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))


// End Function  