page 50100 "Active Session List"
{

    //ApplicationArea = All;
    Caption = 'Active Session List';
    PageType = ListPart;
    SourceTable = "Active Session";
    //UsageCategory = Lists;
    Permissions = TableData "Session" = rimd;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Client Computer Name"; Rec."Client Computer Name")
                {
                    ApplicationArea = All;
                }
                field("Client Type"; Rec."Client Type")
                {
                    ApplicationArea = All;
                }
                field("Database Name"; Rec."Database Name")
                {
                    ApplicationArea = All;
                }
                field("Login Datetime"; Rec."Login Datetime")
                {
                    ApplicationArea = All;
                }
                field("Server Computer Name"; Rec."Server Computer Name")
                {
                    ApplicationArea = All;
                }
                field("Server Instance ID"; Rec."Server Instance ID")
                {
                    ApplicationArea = All;
                }
                field("Server Instance Name"; Rec."Server Instance Name")
                {
                    ApplicationArea = All;
                }
                field("Session ID"; Rec."Session ID")
                {
                    ApplicationArea = All;
                }
                field("Session Unique ID"; Rec."Session Unique ID")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("User SID"; Rec."User SID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
