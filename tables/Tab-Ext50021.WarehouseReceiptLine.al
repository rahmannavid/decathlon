tableextension 50021 "Warehouse Receipt Line" extends "Warehouse Receipt Line"
{
    fields
    {
        field(50001; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
            begin
                ItemRec.Get("Item No.");
                "Process No." := ItemRec.Process;
                //getChalanNos();
            end;
        }
    }

    procedure getChalanNos()
    var
        TransShipHeader: Record "Transfer Shipment Header";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        PrvNo: Code[20];
        PrevCalan: Text;
    begin
        WarehouseReceiptHeader.Reset();
        WarehouseReceiptHeader.SetRange("No.", Rec."No.");
        WarehouseReceiptHeader.FindFirst();

        TransShipHeader.Reset();
        TransShipHeader.SetRange("Transfer Order No.", Rec."Source No.");
        if TransShipHeader.FindFirst() then
            repeat
                if WarehouseReceiptHeader."External Document No." = '' then
                    WarehouseReceiptHeader."External Document No." := TransShipHeader."External Document No."
                else
                    WarehouseReceiptHeader."External Document No." += ',' + TransShipHeader."External Document No.";

            until TransShipHeader.Next() = 0;
        WarehouseReceiptHeader.Modify();
    end;
}
