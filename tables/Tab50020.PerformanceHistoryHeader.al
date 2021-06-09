table 50020 "Performance History Header"
{
    Caption = 'Performance History';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Purchase Order Date"; Date)
        {
            Caption = 'Purchase Order Date';
            DataClassification = ToBeClassified;
        }
        field(4; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Transfer Order Date"; Date)
        {
            Caption = 'Transfer Order Date';
            DataClassification = ToBeClassified;
        }
        field(8; Process; Code[20])
        {
            Caption = 'Process';
            DataClassification = ToBeClassified;
        }
        field(9; DSM; Code[20])
        {
            Caption = 'DSM';
            DataClassification = ToBeClassified;
        }
        field(10; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = ToBeClassified;
        }
        field(11; "FG Location Code"; Code[20])
        {
            Caption = 'FG Suplier Code';
            DataClassification = ToBeClassified;
        }
        field(12; "Sole Location Code"; Code[20])
        {
            Caption = 'Sole Suplier Code';
            DataClassification = ToBeClassified;
        }
        field(13; "Order type"; Option)
        {
            Caption = 'Order type';
            DataClassification = ToBeClassified;
            OptionMembers = "Manual","Auto";
        }
        field(14; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(16; "Lead Time"; Integer)
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
        }
        field(17; "Expected Date"; Date)
        {
            Caption = 'Expected Date';
            DataClassification = ToBeClassified;
        }
        field(18; "Remaining Qty"; Decimal)
        {

        }
        field(19; "Future Lead Time"; Decimal)
        {

        }
        field(20; "Future Qty Ontime 3 Days"; Decimal)
        {

        }
        field(21; "Future Delivery Ontime"; Decimal)
        {

        }
        field(22; "Requested Date"; Date)
        {

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
