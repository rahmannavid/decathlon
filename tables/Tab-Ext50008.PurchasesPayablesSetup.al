tableextension 50008 "Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purchase Planning Nos."; Code[20])
        {
            Caption = 'Purchase Planning Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
