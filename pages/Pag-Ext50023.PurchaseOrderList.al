pageextension 50023 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addafter("Buy-from Vendor Name")
        {
            field("DSM Name"; Rec."DSM Name")
            {
                ApplicationArea = all;
            }
            field("Item No"; Rec."Item No.")
            {
                ApplicationArea = all;
                Width = 6;
            }
            field("Item Name"; rec."Item Name")
            {
                ApplicationArea = all;
            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = all;
            }

        }
        addafter("Document Date")
        {
            field("Order Status"; Rec."Order Status")
            {
                ApplicationArea = all;
            }

            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Caption = 'Expected Receipt Date';
                ApplicationArea = all;
            }
        }
        modify("Requested Receipt Date")
        {
            ApplicationArea = all;
            Visible = true;
        }
        modify("Buy-from Vendor No.")
        {
            Caption = 'Sole Supplier No.';
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Sole Supplier Name';
            Width = 17;
        }

        modify("Vendor Authorization No.")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Amount Including VAT")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("FG Supplier Name55294"; Rec."FG Supplier Name")
            {
                ApplicationArea = All;
                Width = 18;
            }
            field("DSM Code81099"; Rec."DSM Code")
            {
                ApplicationArea = All;
                Width = 11;
            }
        }
        addafter("Document Date")
        {
            field("Order Type63069"; Rec."Order Type")
            {
                ApplicationArea = All;
                Width = 8;
            }
        }
        moveafter("Total Quantity"; Amount)

    }

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."Vendor No." <> '' then begin
                rec.SetFilter("FG Supplier No.", userSetup."Vendor No.");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    Rec.SetFilter("Buy-from Vendor No.", userSetup."Sole Supplier");
                    rec.FilterGroup(2);
                end
                else
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
            if userSetup."Vendor No." <> '' then begin
                rec.SetFilter("FG Supplier No.", userSetup."Vendor No.");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    Rec.SetFilter("Buy-from Vendor No.", userSetup."Sole Supplier");
                    rec.FilterGroup(2);
                end
                else
                    Error('You do not have permission to view this page');
        end;
    end;
}
