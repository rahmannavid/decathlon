page 50002 "Process List"
{

    ApplicationArea = All;
    Caption = 'Process List';
    PageType = List;
    SourceTable = Process;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Process Code"; Rec."Process Code")
                {
                    ApplicationArea = All;
                }
                field("Process Name"; Rec."Process Name")
                {
                    ApplicationArea = All;
                }
                field("Process Shorit Name"; Rec."Process Short Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
