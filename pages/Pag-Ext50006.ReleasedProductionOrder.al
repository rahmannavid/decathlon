pageextension 50006 "Released Production Order" extends "Released Production Order"
{
    Caption = 'Production Order';

    layout
    {
        addlast(General)
        {
            field("FG Supplier No."; Rec."FG Supplier No.")
            {
                ApplicationArea = All;
                Caption = 'Vendor No.';
                Visible = false;
                //Visible = false;
            }
            field("Sole Supplier No."; Rec."Sole Supplier No.")
            {
                ApplicationArea = All;

            }
            field("DSM Code"; rec."DSM Code")
            {
                ApplicationArea = All;
            }
            field("DSM Name"; rec."DSM Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Item No"; rec."Item No")
            {
                ApplicationArea = All;
            }
            field("Item Name"; rec."Item Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = All;
            }
        }

        modify("Description 2")
        {
            Visible = false;
        }
        modify("Source Type")
        {
            Importance = Additional;
        }
        modify("Source No.")
        {
            Importance = Additional;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify(Quantity)
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Editable = FieldEditable;
        }

        moveafter(Description; "Location Code")
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        // addafter(Blocked)
        // {
        //     field("Location Code68054"; Rec."Location Code")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
        //moveafter("No."; "Sole Supplier No.")
        modify(Description)
        {
            Visible = false;
        }
    }
    //global variable
    var
        FieldEditable: Boolean;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Rec.validate("Location Code", userSetup."location Code");
            Rec."Sole Supplier No." := userSetup."Sole Supplier";
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;
}
