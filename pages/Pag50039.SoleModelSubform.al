page 50039 "Sole Model Subform"
{

    Caption = 'Sole Model Subform';
    PageType = ListPart;
    SourceTable = "Sole Model Line";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("FG DSM"; Rec."FG DSM")
                {
                    ApplicationArea = All;
                }
                field("FG DSM Description"; Rec."FG DSM Description")
                {
                    ApplicationArea = All;
                }
                field("FG Location"; Rec."FG Location")
                {
                    ApplicationArea = All;
                }
                field("FG Model Code"; Rec."FG Model Code")
                {
                    ApplicationArea = All;
                }
                field("FG Model Description"; Rec."FG Model Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
