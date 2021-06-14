pageextension 50021 "Sales Order" extends "Sales Order"
{
    Caption = 'Sole Utilization';
    layout
    {
        addafter(General)
        {
            group(Item)
            {
                ShowCaption = false;

                field("FG Supplier No."; Rec."FG Supplier No.")
                {
                    Caption = 'Vendor No';
                    ApplicationArea = All;
                    Editable = FieldEditable;

                }
                field("DSM Code"; Rec."DSM Code")
                {
                    Caption = 'DSM Code';
                    ApplicationArea = All;
                }
                field("DSM Name"; Rec."DSM Name")
                {
                    Caption = 'DSM Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                }
                field("Item Name"; Rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        modify("Sell-to Contact")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Requested Delivery Date")
        {
            Visible = false;
        }
        modify("Sell-to Address")
        {
            Visible = false;
        }
        modify("Sell-to Address 2")
        {
            Visible = false;
        }
        modify("Sell-to City")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Sell-to Phone No.")
        {
            Visible = false;
        }
        modify(SellToMobilePhoneNo)
        {
            Visible = false;
        }
        modify("Sell-to E-Mail")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Document Date")
        {
            Visible = false;
        }
        modify("External Document No.")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Your Reference")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(WorkDescription)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
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
        SalesSetup: Record "Sales & Receivables Setup";
        locationVar: Record Location;
        vendorVar: Record Vendor;
    begin
        userSetup.Get(UserId());
        SalesSetup.Get();

        Rec.Validate("Sell-to Customer No.", SalesSetup."Default Customer");

        if not userSetup."Admin User" then begin
            SalesSetup.TestField("Default Customer");
            if vendorVar.Get(userSetup."Vendor No.") then
                Rec.Validate("FG Supplier No.", userSetup."Vendor No.");
            if locationVar.Get(userSetup."location Code") then
                Rec.validate("Location Code", userSetup."location Code");
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;
}
