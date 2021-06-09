tableextension 50023 "Posted Whse. Shipment Header" extends "Posted Whse. Shipment Header"
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
            CalcFormula = lookup("Posted Whse. Shipment Line"."Source No." where("No." = field("No.")));
        }
    }
}
