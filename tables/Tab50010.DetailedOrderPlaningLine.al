table 50010 "Detailed Order Planing Line"
{
    Caption = 'Detailed Order Planing Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Week; Date)
        {
            Caption = 'Week';
            DataClassification = ToBeClassified;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = ToBeClassified;
        }
        field(5; "Child Of"; Integer)
        {

        }
        field(6; "PO Created"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; Week, "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

}
