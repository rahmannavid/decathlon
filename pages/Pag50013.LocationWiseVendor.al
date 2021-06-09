page 50013 "Location Wise Vendor"
{

    ApplicationArea = All;
    Caption = 'Location Wise Vendor';
    PageType = List;
    SourceTable = "Location Wise Vendor";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Location No."; Rec."Location No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
