tableextension 50019 "Warehouse Shipment Header" extends "Warehouse Shipment Header"
{
    fields
    {
        field(50001; "Delay Reason"; Text[100])
        {
            TableRelation = "Delay Reasons";
            ValidateTableRelation = true;
        }

        field(50006; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';

        }

        field(50007; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

        }

        field(50008; "PO No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Warehouse Shipment Line"."Source No." where("No." = field("No.")));
        }

        // modify("External Document No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         PWhShipmentLine: Record "Posted Whse. Shipment Line";
        //         PWhShipmeentHeader: Record "Posted Whse. Shipment Header";
        //         WhShipmentLine: Record "Warehouse Shipment Line";
        //         PrvNo: Code[20];
        //     begin
        //         WhShipmentLine.Reset();
        //         WhShipmentLine.SetRange("No.", Rec."No.");

        //         PWhShipmentLine.Reset();
        //         PWhShipmentLine.SetRange("Source No.", WhShipmentLine."Source No.");
        //         if PWhShipmentLine.FindFirst() then
        //             repeat

        //                 if PrvNo <> PWhShipmentLine."No." then begin

        //                     PWhShipmeentHeader.SetRange("No.", PWhShipmentLine."No.");
        //                     if PWhShipmeentHeader.FindFirst() then
        //                         if StrPos(Rec."External Document No.", PWhShipmeentHeader."External Document No.") = 0 then
        //                             Rec."External Document No." += ',' + PWhShipmeentHeader."External Document No.";
        //                 end;

        //                 PrvNo := PWhShipmentLine."No.";

        //             until PWhShipmentLine.Next() = 0;
        //         Rec.Modify();
        //     end;
        // }
    }
}
