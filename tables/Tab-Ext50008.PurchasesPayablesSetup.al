tableextension 50008 "Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purchase Planning Nos."; Code[20])
        {
            Caption = 'Purchase Planning Nos.';
            TableRelation = "No. Series";
        }
        field(50001; "Sole Mold Inventory Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }

        field(50002; "Sole Model Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
}
