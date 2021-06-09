pageextension 50029 "Warehouse Receipt" extends "Warehouse Receipt"
{
    layout
    {
        addlast(General)
        {
            field("External Document No."; Rec."External Document No.")
            {

            }
            field("PO No."; Rec."PO No.")
            { }
        }

        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Zone Code")
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
        modify("Sorting Method")
        {
            Visible = false;
        }
        modify("Assignment Time")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }

        moveafter("No."; "Document Status")
    }

    actions
    {
        modify("Post Receipt")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("External Document No.");
                CheckShipmentNo();
            end;

            trigger OnAfterAction()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
            begin
                WarehouseReceiptLine.SetRange("No.", Rec."No.");
                if WarehouseReceiptLine.FindFirst() then
                    WarehouseReceiptLine.DeleteAll();

                Rec."External Document No." := '';
                Rec."Posted Shipment No." := '';
                Rec.Modify();
            end;
        }
        modify("Post and &Print")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("External Document No.");
                CheckShipmentNo();
            end;

            trigger OnAfterAction()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
            begin
                WarehouseReceiptLine.SetRange("No.", Rec."No.");
                if WarehouseReceiptLine.FindFirst() then
                    WarehouseReceiptLine.DeleteAll();

                Rec."External Document No." := '';
                Rec."Posted Shipment No." := '';
                Rec.Modify();
            end;
        }
        modify("Post and Print P&ut-away")
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("External Document No.");
                CheckShipmentNo();
            end;

            trigger OnAfterAction()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
            begin
                WarehouseReceiptLine.SetRange("No.", Rec."No.");
                if WarehouseReceiptLine.FindFirst() then
                    WarehouseReceiptLine.DeleteAll();

                Rec."External Document No." := '';
                Rec."Posted Shipment No." := '';
                Rec.Modify();
            end;
        }

        modify("Get Source Documents")
        {
            trigger OnBeforeAction()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
                TransShipHeader: Record "Transfer Shipment Header";
            begin
                WarehouseReceiptLine.SetRange("No.", Rec."No.");
                if WarehouseReceiptLine.FindFirst() then
                    Error('Please delete all line first.');

                if Rec."Posted Shipment No." <> '' then begin
                    TransShipHeader.Get(Rec."Posted Shipment No.");
                    TransShipHeader."Warehouse Receipt No." := '';
                    TransShipHeader.Modify();

                    Rec."External Document No." := '';
                    Rec."Posted Shipment No." := '';
                    Rec.Modify();
                end;
            end;
        }
    }

    local procedure CheckShipmentNo()
    var
        TransShipHeader: Record "Transfer Shipment Header";
    begin

        if not TransShipHeader.Get(Rec."Posted Shipment No.") then
            Error('Please select correct External Document No.')
        else begin
            Rec.CalcFields("PO No.");
            if TransShipHeader."Transfer Order No." <> Rec."PO No." then
                Error('Please select correct External Document No.');
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        TransShipHeader: Record "Transfer Shipment Header";
    begin
        if Rec."Posted Shipment No." <> '' then begin
            TransShipHeader.Get(Rec."Posted Shipment No.");
            TransShipHeader."Warehouse Receipt No." := '';
            TransShipHeader.Modify();

            Rec."External Document No." := '';
            Rec."Posted Shipment No." := '';
            Rec.Modify();
        end;
    end;
}
