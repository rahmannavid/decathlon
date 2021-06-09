pageextension 50003 Dimensions extends Dimensions
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
