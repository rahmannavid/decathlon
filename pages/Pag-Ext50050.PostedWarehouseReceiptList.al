pageextension 50050 "Posted Whse. Receipt List" extends "Posted Whse. Receipt List"
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
