pageextension 50009 "Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Receive")
        {
            Visible = false;
        }
        modify("Quantity Received")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
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
        moveafter("Return Reason Code"; "Shortcut Dimension 1 Code")
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        moveafter("Direct Unit Cost"; "Location Code")
        addafter("Direct Unit Cost")
        {
            field("Line Amount62967"; Rec."Line Amount")
            {
                ApplicationArea = All;
            }
        }
        modify("Invoice Discount Amount")
        {
            Visible = false;
        }
        modify("Invoice Disc. Pct.")
        {
            Visible = false;
        }
    }
}
