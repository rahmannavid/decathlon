pageextension 50025 "Posted Transfer Shipment Lines" extends "Posted Transfer Shipment Lines"
{
    layout
    {
        addbefore(Quantity)
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
