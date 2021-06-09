tableextension 50025 "Posted Whse. Receipt Header" extends "Posted Whse. Receipt Header"
{
    fields
    {

        field(50000; "Promised Receipt Date"; Date)
        {
            Caption = 'Promised Receipt Date';

        }

        field(50001; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';

        }

        field(50008; "PO No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Posted Whse. Receipt Line"."Source No." where("No." = field("No.")));
        }

    }
}
