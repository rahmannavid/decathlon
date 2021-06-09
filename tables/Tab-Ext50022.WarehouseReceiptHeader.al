tableextension 50022 "Warehouse Receipt Header" extends "Warehouse Receipt Header"
{
    fields
    {
        field(50000; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
            DataClassification = ToBeClassified;
        }
        field(50001; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
            DataClassification = ToBeClassified;
        }
        field(50002; "External Document No."; Text[1000])
        {
            trigger OnLookup()
            var
                TransShipHeader: Record "Transfer Shipment Header";
                TransShipHeader2: Record "Transfer Shipment Header";
            begin

                Rec.CalcFields("PO No.");
                TransShipHeader.SetRange("Transfer-to Code", Rec."Location Code");
                TransShipHeader.SetRange("Transfer Order No.", Rec."PO No.");
                TransShipHeader.SetFilter("Warehouse Receipt No.", '%1', '');
                if TransShipHeader.FindFirst() then begin
                    if PAGE.RunModal(0, TransShipHeader) = ACTION::LookupOK THEN BEGIN

                        if Rec."Posted Shipment No." <> '' then begin
                            TransShipHeader2.SetRange("No.", "Posted Shipment No.");
                            TransShipHeader2.FindFirst();
                            TransShipHeader2."Warehouse Receipt No." := '';
                            TransShipHeader2.Modify();
                        end;

                        Rec."External Document No." := TransShipHeader."External Document No.";
                        Rec.Validate("Posted Shipment No.", TransShipHeader."No.");

                        TransShipHeader."Warehouse Receipt No." := Rec."No.";
                        TransShipHeader.Modify();

                        Rec.Modify();
                        Message('Receipt document updated successfully');
                    end;
                end else begin
                    if Rec."External Document No." = '' then
                        Rec."Posted Shipment No." := '';
                    Message('Shipment document not found');
                end;

            end;

            trigger OnValidate()
            var
                TransShipHeader2: Record "Transfer Shipment Header";
            begin
                if "External Document No." <> '' then
                    Error('Manual entry not allowed')
                else begin
                    if Rec."Posted Shipment No." <> '' then begin
                        TransShipHeader2.SetRange("No.", "Posted Shipment No.");
                        TransShipHeader2.FindFirst();
                        TransShipHeader2."Warehouse Receipt No." := '';
                        TransShipHeader2.Modify();
                        Rec."Posted Shipment No." := '';
                        Rec.Modify();
                    end;
                end;
            end;

        }
        field(50003; "PO No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Receipt Line"."Source No." where("No." = field("No.")));
        }
        field(50004; "Posted Shipment No."; Code[20])
        {
            trigger OnValidate()
            var
                WarehouseReceiptLine: Record "Warehouse Receipt Line";
                TransShipLine: Record "Transfer Shipment Line";
            begin
                WarehouseReceiptLine.SetRange("No.", Rec."No.");
                if WarehouseReceiptLine.FindFirst() then
                    repeat
                        TransShipLine.Reset();
                        TransShipLine.SetRange("Document No.", "Posted Shipment No.");
                        TransShipLine.SetRange("Item No.", WarehouseReceiptLine."Item No.");
                        TransShipLine.SetRange("Variant Code", WarehouseReceiptLine."Variant Code");
                        if TransShipLine.FindFirst() then begin
                            WarehouseReceiptLine.Validate("Qty. to Receive", TransShipLine.Quantity);
                            WarehouseReceiptLine.Modify();
                            // if WarehouseReceiptLine.Quantity > 0 then
                            //     WarehouseReceiptLine.Modify()
                            // else
                            //     WarehouseReceiptLine.Delete();
                        end else begin
                            WarehouseReceiptLine.Delete();
                        end;
                    until WarehouseReceiptLine.Next() = 0;


            end;
        }
    }
}
