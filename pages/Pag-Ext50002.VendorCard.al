pageextension 50002 "Vendor Card" extends "Vendor Card"
{
    layout
    {
        addafter(General)
        {
            group("Decathlon Ext. Fields")
            {
                field("CNUF"; Rec."CNUF")
                {
                    ApplicationArea = All;
                }
                field("Supplier"; Rec."Supplier")
                {
                    ApplicationArea = All;
                }
                field("Supplier Full Name"; Rec."Supplier Full Name")
                {
                    ApplicationArea = All;
                }
                field("Supplier Code"; Rec."Supplier Code")
                {
                    ApplicationArea = All;
                }
                field("DPP Code"; Rec."DPP Code")
                {
                    ApplicationArea = All;
                }
                field("DPP Name"; Rec."DPP Name")
                {
                    ApplicationArea = All;
                }
                field("Responsible"; Rec."Responsible")
                {
                    ApplicationArea = All;
                }
            }
        }
        modify("Shipment Method Code")
        {
            ApplicationArea = all;
        }
    }
    actions
    {
        addlast("Ven&dor")
        {
            action("Related Parties")
            {
                ApplicationArea = All;
                Caption = 'Related Parties';
                Image = RelatedInformation;
                RunObject = Page "Related Parties List";
                RunPageLink = "Vendor No." = field("No.");

                trigger OnAction()
                begin

                end;
            }
        }
    }
}
