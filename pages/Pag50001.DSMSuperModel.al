page 50001 "DMS (Super Model)"
{

    ApplicationArea = All;
    Caption = 'DSM (Super Model)';
    PageType = List;
    SourceTable = "DSM (Super Model)";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("DSM Code"; Rec."DSM Code")
                {
                    ApplicationArea = All;
                }
                field("DSM Name"; Rec."DSM Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
