pageextension 50040 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addafter(Description)
        {
            // field("DMS No."; Rec."DMS No.")
            // {
            //     ApplicationArea = all;
            // }
            // field("DSM Name"; Rec."DSM Name")
            // {
            //     ApplicationArea = all;
            // }
        }

        modify("Document Type")
        {
            Visible = false;
        }
        modify("Invoiced Quantity")
        {
            Visible = false;
        }
        addafter("Location Code")
        {
            field("Global Dimension 1 Code72152"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
                Width = 5;
            }
        }
        modify("Sales Amount (Actual)")
        {
            Visible = false;
        }
        modify("Cost Amount (Actual)")
        {
            Visible = false;
        }
        modify("Cost Amount (Non-Invtbl.)")
        {
            Visible = false;
        }
        moveafter("Entry Type"; "Order Type")
        modify("Order Type")
        {
            Width = 14;
        }
        modify("Variant Code")
        {
            Visible = true;
            ApplicationArea = all;
        }
        addafter("Order Type")
        {
            field("Order No.67241"; Rec."Order No.")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."location Code" <> '' then begin
                rec.SetRange("Location Code", userSetup."location Code");
                Rec.FilterGroup(2);
            end else
                Error('You do not have permission to view this page');
        end;
    end;
}
