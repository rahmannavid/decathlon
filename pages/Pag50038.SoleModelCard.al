page 50038 "Sole Model Card"
{

    Caption = 'Sole Model Card';
    PageType = Card;
    SourceTable = "Sole Model Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Sole Model Code"; Rec."Sole Model Code")
                {
                    ApplicationArea = All;
                }
                field("Sole Model Description"; Rec."Sole Model Description")
                {
                    ApplicationArea = All;
                }
                field("Mold Code"; Rec."Mold Code")
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
                field("EOL Date"; Rec."EOL Date")
                {
                    ApplicationArea = All;
                }
                field("EOL Status"; Rec."EOL Status")
                {
                    ApplicationArea = All;
                }
                field("Ext. Sole DSM"; Rec."Ext. Sole DSM")
                {
                    ApplicationArea = All;
                }
                field("Ext. Sole DSM Description"; Rec."Ext. Sole DSM Description")
                {
                    ApplicationArea = All;
                }
                field("FG DSM"; Rec."FG DSM")
                {
                    ApplicationArea = All;
                }
                field("FG DSM Desc"; Rec."FG DSM Desc")
                {
                    ApplicationArea = All;
                }
                field("Global Std Model"; Rec."Global Std Model")
                {
                    ApplicationArea = All;
                }
                field("Std Model SMV"; Rec."Std Model SMV")
                {
                    ApplicationArea = All;
                }
            }

            part(SoleMoldLines; "Sole Model Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("Sole Model Code");
            }
        }
    }

}
