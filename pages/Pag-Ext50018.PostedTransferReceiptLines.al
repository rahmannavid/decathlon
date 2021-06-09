pageextension 50018 "Posted Transfer Receipt Lines" extends "Posted Transfer Receipt Lines"
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
