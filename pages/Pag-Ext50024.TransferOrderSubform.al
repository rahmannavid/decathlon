pageextension 50024 "Transfer Order Subform" extends "Transfer Order Subform"
{

    layout
    {

        addafter(Quantity)
        {
            field("Unit Cost"; Rec."Unit Cost")
            {
                ApplicationArea = all;
            }
            field("Line Amount"; Rec."Line Amount")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }

        addafter("Line Amount")
        {
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                trigger OnValidate()
                var
                    TransHeader: Record "Transfer Header";
                begin
                    TransHeader.Get(Rec."Document No.");
                    TransHeader.testfield("Order Status", TransHeader."Order Status"::Open);
                end;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
            }
        }


        moveafter(Quantity; "Unit of Measure Code")

        //moveafter(Description; "Shortcut Dimension 1 Code")

        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Variant Code1"; Rec."Variant Code")
            {

            }
        }
        addafter("Quantity Received")
        {
            field("Outstanding Quantity"; Rec."Outstanding Quantity")
            {
                ApplicationArea = all;
            }
        }

        modify("Qty. to Receive")
        {
            Visible = false;
        }
        modify("Qty. to Ship")
        {
            Visible = false;
        }
        modify("Reserved Quantity Inbnd.")
        {
            Visible = false;
        }
        modify("Reserved Quantity Shipped")
        {
            Visible = false;
        }
        modify("Reserved Quantity Outbnd.")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Receipt Date")
        {
            Visible = false;
        }

    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        transHeader: Record "Transfer Header";
    begin
        transHeader.SetRange("No.", Rec."Document No.");
        transHeader.FindFirst();
        if transHeader."Item No." = '' then
            Error('Please select Item in the Header Section.');
    end;
}
