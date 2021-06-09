page 50004 "DPP List"
{

    ApplicationArea = All;
    Caption = 'DPP List';
    PageType = List;
    SourceTable = "DPP List";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DPP Code"; Rec."DPP Code")
                {
                    ApplicationArea = All;
                }
                field("DPP Name"; Rec."DPP Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
