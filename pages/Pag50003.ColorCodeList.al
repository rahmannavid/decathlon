page 50003 "Color Code List"
{

    ApplicationArea = All;
    Caption = 'Color Code List';
    PageType = List;
    SourceTable = "Color Code";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Color Name"; Rec."Color Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
