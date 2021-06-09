pageextension 50048 "Warehouse Receipts" extends "Warehouse Receipts"
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
