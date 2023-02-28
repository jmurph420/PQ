// HolidayCalendar
let
    Source = OData.Feed("https://k2share.sharepoint.com/_api/web/lists/getbyid('c6026d52-58f2-47f6-b1fe-ef2a4a436c56')/items?$Select=Title,HolidayDate,OfficeNote,ID
", null, [Implementation="2.0"]),
    #"Changed Type" = Table.TransformColumnTypes(Source,{{"HolidayDate", type date}, {"Title", type text}, {"OfficeNote", type text}, {"ID", Int64.Type}, {"Id", Int64.Type}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type",{{"ID", "ID.1"}})
in
    #"Renamed Columns"