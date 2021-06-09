page 50101 "Session List"
{

    ApplicationArea = All;
    Caption = 'Session List';
    PageType = List;
    SourceTable = Session;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Application Name"; Rec."Application Name")
                {
                    ApplicationArea = All;
                }
                field("Connection ID"; Rec."Connection ID")
                {
                    ApplicationArea = All;
                }
                field("Database Name"; Rec."Database Name")
                {
                    ApplicationArea = All;
                }
                field("Host Name"; Rec."Host Name")
                {
                    ApplicationArea = All;
                }
                field("Login Date"; Rec."Login Date")
                {
                    ApplicationArea = All;
                }
                field("Login Time"; Rec."Login Time")
                {
                    ApplicationArea = All;
                }
                field("Login Type"; Rec."Login Type")
                {
                    ApplicationArea = All;
                }
                field("My Session"; Rec."My Session")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
