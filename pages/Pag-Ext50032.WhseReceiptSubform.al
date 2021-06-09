pageextension 50032 "Whse. Receipt Subform" extends "Whse. Receipt Subform"
{
    layout
    {
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Qty. to Cross-Dock")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Qty. per Unit of Measure")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        addafter("Bin Code")
        {
            field("Variant Code76254"; Rec."Variant Code")
            {
                ApplicationArea = All;
                Width = 12;
            }
        }

    }
}
