tableextension 50012 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50000; "Default Customer"; Code[20])
        {
            Caption = 'Default Customer';
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
    }
}
