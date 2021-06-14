pageextension 50033 "Purchase Invoice" extends "Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("Financial Document No."; Rec."Financial Document No.")
            { }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {

            }
            field("Item No"; Rec."Item No.")
            {
                Editable = false;
                Visible = false;
            }
            field("Order Status"; Rec."Order Status")
            {
                Editable = false;
            }

        }
        addafter("Buy-from Vendor Name")
        {
            field("FG Supplier No."; Rec."FG Supplier No.")
            {
                Editable = FieldEditable;
            }
            field("FG Supplier Name"; Rec."FG Supplier Name")
            {
                Editable = false;
            }
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Sole Supplier';

        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Ship-to Contact")
        {
            Visible = false;
        }
        modify(BuyFromContactEmail)
        {
            Visible = false;
        }
        modify(BuyFromContactMobilePhoneNo)
        {
            Visible = false;
        }
        modify(BuyFromContactPhoneNo)
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }

    }

    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(PostAndNew)
        {
            Visible = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
        }
        modify(Approvals)
        {
            Visible = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
        }

        addlast(processing)
        {
            group("Change Order Status")
            {
                action("Issue")
                {
                    trigger OnAction()
                    var
                        PurLine: Record "Purchase Line";
                    begin
                        rec.TestField("Vendor Invoice No.");
                        Rec.validate("Order Status", Rec."Order Status"::Issued);
                        Rec.Modify();
                    end;
                }
                action(Accept)
                {
                    trigger OnAction()
                    var
                        PurLine: Record "Purchase Line";
                    begin
                        rec.TestField("Vendor Invoice No.");
                        Rec.validate("Order Status", Rec."Order Status"::Accepted);
                        Rec.Modify();
                    end;
                }
                action("Paid")
                {
                    trigger OnAction()
                    var
                        PurLine: Record "Purchase Line";
                    begin
                        if Rec."Order Status" <> Rec."Order Status"::Accepted then
                            Error('Invoice is not accepted.');

                        rec.TestField("Vendor Invoice No.");
                        Rec.validate("Order Status", Rec."Order Status"::Paid);
                        Rec.Modify();
                    end;
                }
                action("Re-Open")
                {
                    trigger OnAction()
                    var
                        PurLine: Record "Purchase Line";
                    begin
                        if Rec."Order Status" = Rec."Order Status"::Paid then
                            Error('Invoice is already paid.');
                        rec.TestField("Vendor Invoice No.");
                        Rec.validate("Order Status", Rec."Order Status"::New);
                        Rec.Modify();
                    end;
                }
            }
        }
    }

    var
        FieldEditable: Boolean;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        Rec."Order Date" := Today;

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
        locationVar: Record Location;
        vendorVar: Record Vendor;
    begin
        Rec."Order Date" := Today;

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if vendorVar.get(userSetup."Vendor No.") then
                Rec.Validate("FG Supplier No.", userSetup."Vendor No.");
            if locationVar.Get(userSetup."location Code") then
                rec.validate("Location Code", userSetup."location Code");
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

}
