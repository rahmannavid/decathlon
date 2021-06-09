pageextension 50049 "Posted Whse. Shipment List" extends "Posted Whse. Shipment List"
{
    layout
    {
        addafter("No.")
        {
            field("PO No."; Rec."PO No.")
            { }
        }
    }
}
