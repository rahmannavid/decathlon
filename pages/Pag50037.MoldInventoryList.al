page 50037 "Mold Inventory List"
{

    ApplicationArea = All;
    Caption = 'Mold Inventory List';
    PageType = List;
    SourceTable = "Sole Mold Inventory Header";
    UsageCategory = Lists;
    CardPageId = "Mold Inventory Card";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Mold Description"; Rec."Mold Description")
                {
                    ApplicationArea = All;
                }
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;
                }
                field("Process Name"; Rec."Process Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
