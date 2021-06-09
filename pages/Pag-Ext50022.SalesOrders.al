pageextension 50022 "Sales Order List" extends "Sales Order List"
{
    Caption = 'Sole Utilizations';
    layout
    {
        addafter("No.")
        {
            field("Posting Date57840"; Rec."Posting Date")
            {
                ApplicationArea = All;
                Width = 9;
            }
            field("FG Supplier No.70713"; Rec."FG Supplier No.")
            {
                ApplicationArea = All;
                Width = 8;
            }
            field("DSM Code98741"; Rec."DSM Code")
            {
                ApplicationArea = All;
                Width = 10;
            }
            field("DSM Name20892"; Rec."DSM Name")
            {
                ApplicationArea = All;
                Width = 21;
            }
            field("Item No52886"; Rec."Item No")
            {
                ApplicationArea = All;
                Width = 6;
            }
            field("Item Name25081"; Rec."Item Name")
            {
                ApplicationArea = All;
            }
        }
        modify("Sell-to Customer No.")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("Sell-to Customer Name")
        {
            Width = 15;
        }
        modify("Completely Shipped")
        {
            Visible = false;
        }
        modify("Amt. Ship. Not Inv. (LCY) Base")
        {
            Visible = false;
        }
        modify("Amt. Ship. Not Inv. (LCY)")
        {
            Visible = false;
        }
        modify(Amount)
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
    }
    trigger OnOpenPage()
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

    trigger OnAfterGetCurrRecord()
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
