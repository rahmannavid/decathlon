pageextension 50047 "Warehouse Shipment List" extends "Warehouse Shipment List"
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
