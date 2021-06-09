tableextension 50020 "Warehouse Shipment Line" extends "Warehouse Shipment Line"
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

        field(50002; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';
        }

        field(50003; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
            begin
                ItemRec.Get("Item No.");
                "Process No." := ItemRec.Process;
            end;
        }
    }
}
