pageextension 50010 "Released Prod. Order Lines" extends "Released Prod. Order Lines"
{
    layout
    {
        modify("Starting Date-Time")
        {
            Visible = false;
        }
        modify("Ending Date-Time")
        {
            Visible = false;
        }
        modify("Finished Quantity")
        {
            Visible = false;
        }
        modify("Remaining Quantity")
        {
            Visible = false;
        }
        addafter("Cost Amount")
        {
            field("Location Code18457"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        // addafter("Ending Date")
        // {
        //     field("Variant Code51207"; Rec."Variant Code")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        modify("Due Date")
        {
            Visible = false;
        }
        moveafter("Unit of Measure Code"; "Ending Date-Time")
        moveafter("Unit of Measure Code"; "Starting Date-Time")
        addafter("Ending Date")
        {
            field("Shortcut Dimension 1 Code70569"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Width = 9;
            }
        }
    }
}
