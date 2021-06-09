pageextension 50004 "Dimension Values" extends "Dimension Values"
{
    layout
    {
        addafter(Blocked)
        {
            field("Dimension For"; Rec."Dimension For")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
}
