pageextension 50019 "Transfer Lines" extends "Transfer Lines"
{
    layout
    {
        addbefore("Qty. in Transit")
        {
            field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
    }

    // trigger OnModifyRecord(): Boolean
    // var
    //     TransHeader: Record "Transfer Header";
    // begin
    //     TransHeader.SetRange("No.", Rec."Document No.");
    //     TransHeader.FindFirst();
    //     if TransHeader."Order Status" = TransHeader."Order Status"::"Acceptance Pending" then
    //         Error('Can not edit pending orders.');
    // end;
}
