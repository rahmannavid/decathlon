pageextension 50028 "Warehouse Shipment" extends "Warehouse Shipment"
{

    layout
    {
        addlast(General)
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                Caption = 'Requested Date';
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Caption = 'Expected Date';
            }
            field("PO No."; Rec."PO No.")
            { }
        }

        addafter(Shipping)
        {
            group(Posting)
            {
                field("Delay Reason"; Rec."Delay Reason")
                {

                }
            }
        }

        modify("Zone Code")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Assignment Date")
        {
            Visible = false;
        }
        modify("Assignment Time")
        {
            Visible = false;
        }
        modify("Sorting Method")
        {
            Visible = false;
        }
        modify("Document Status")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }

    }

    actions
    {
        modify("Post and &Print")
        {
            Visible = false;
        }
        modify("P&ost Shipment")
        {
            trigger OnBeforeAction()
            begin
                if Rec."Posting Date" <> Today then
                    Error('Posting date must be today.');
                if (Rec."Posting Date" > Rec."Promised Receipt Date") AND (Rec."Delay Reason" = '') then
                    Error('Please mention the delay reason');
                if Rec."External Document No." = '' then
                    Error('Please enter External Document No.');
            end;
        }
    }
    var
        FieldEditable: boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        userSetup.Get(UserId());
        SalesSetup.Get();

        if not userSetup."Admin User" then begin
            SalesSetup.TestField("Default Customer");
            Rec.validate("Location Code", userSetup."location Code");
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;
}
