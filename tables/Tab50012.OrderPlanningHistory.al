table 50012 "Order Planning History"
{
    Caption = 'Order Planning History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Week Date"; Date)
        {
            Caption = 'Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(4; "DSM No."; Code[20])
        {
            Caption = 'DSM No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Size No."; Code[20])
        {
            Caption = 'Size No.';
            DataClassification = ToBeClassified;
        }
        field(6; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
        }
        field(7; "FG Location No"; Code[20])
        {
            Caption = 'FG Location No';
        }
        field(13; "Sole Location No"; Code[20])
        {
            Caption = 'Sole Location No';
        }
        field(10; "Need Quantity"; Decimal)
        {
            Caption = 'Need Quantity';
            DataClassification = ToBeClassified;
        }
        field(11; "Planned Quantity"; Decimal)
        {
            Caption = 'Planned Quantity';
            DataClassification = ToBeClassified;
        }
        field(12; "Firmed Quantity"; Decimal)
        {
            Caption = 'Firmed Quantity';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
