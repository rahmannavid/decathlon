table 50017 "Performance History"
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
        field(6; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.';
            DataClassification = ToBeClassified;
        }
        field(7; "Shipment Date"; Date)
        {
            Caption = 'Shipment Date';
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
        field(15; "Shipment Quantity"; Decimal)
        {
            Caption = 'Shipment Quantity';
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
        field(18; "Qty Ontime"; Decimal)
        {
        }
        field(19; "Qty Ontime 3 Days"; Decimal)
        {

        }
        field(20; "Qty Ontime 7 Days"; Decimal)
        {

        }
        field(21; Size; Code[10])
        {

        }
        field(22; "Delivery Ontime"; Decimal)
        {

        }
        field(23; "Requested Date"; Date)
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
