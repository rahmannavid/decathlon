tableextension 50024 "Posted Whse. Shipment Line" extends "Posted Whse. Shipment Line"
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
            end;
        }
    }
}
