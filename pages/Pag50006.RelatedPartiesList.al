page 50006 "Related Parties List"
{

    ApplicationArea = All;
    Caption = 'Related Parties List (Vendor)';
    PageType = List;
    SourceTable = "Related Parties";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Related Party Code"; Rec."Related Party Code")
                {
                    ApplicationArea = All;
                }
                field("Related Party Name"; Rec."Related Party Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
