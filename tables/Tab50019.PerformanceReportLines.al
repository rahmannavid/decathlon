table 50019 "Performance Report Lines"
{
    Caption = 'Performance Report Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Period Start"; Date)
        {
            Caption = 'Period Start';
            DataClassification = ToBeClassified;
        }
        field(3; "Period End"; Date)
        {
            Caption = 'Period End';
            DataClassification = ToBeClassified;
        }
        field(4; "Report Level"; Code[20])
        {
            Caption = 'Report Level';
            DataClassification = ToBeClassified;
        }
        field(5; "Report Level Desc."; Text[150])
        {
            Caption = 'Report Level Desc.';
            DataClassification = ToBeClassified;
        }
        field(6; "Order Quantity"; Decimal)
        {
            Caption = 'Order Quantity';
            DataClassification = ToBeClassified;
        }
        field(7; "Shipment Quantity"; Decimal)
        {
            Caption = 'Shipment Quantity';
            DataClassification = ToBeClassified;
        }
        field(8; "Lead Time"; Decimal)
        {
            Caption = 'Lead Time';
            DataClassification = ToBeClassified;
        }
        field(9; "Qty Ontime"; Decimal)
        {
        }
        field(10; "Qty Ontime 3 Days"; Decimal)
        {
        }
        field(11; "Qty Ontime 7 Days"; Decimal)
        {
        }

        field(12; "Delayed Quantity"; Decimal)
        {

        }
        field(13; "Delayed Quantity 3 Days"; Decimal)
        {

        }
        field(14; "Delayed Quantity 7 Days"; Decimal)
        {

        }
        field(15; "DOT %"; Decimal)
        {

        }
        field(16; "Future Ontime"; Decimal)
        {

        }
        field(17; "Future Lead Time"; Decimal)
        {

        }
        field(18; "Combined Lead Time"; Decimal)
        {

        }
        field(19; TotalShipLead; Decimal)
        {

        }
        field(20; TotalRemLead; Decimal)
        {

        }
        field(21; TotalRemQty; Decimal)
        {

        }
        field(22; Indentation; Integer)
        {

        }
        field(23; "Future Qty Ontime 3 Days"; Decimal)
        {
        }
        field(24; "Future Delayed Qty 3 Days"; Decimal)
        {
        }
        field(25; "Future DOT%"; Decimal)
        {
        }
        field(26; "HOT %"; Decimal)
        {

        }
        field(27; "Future HOT %"; Decimal)
        {

        }
        field(28; "Combined DOT %"; Decimal)
        {

        }
        field(29; "Combined HOT %"; Decimal)
        {

        }
        field(30; "Delivery Ontime"; Decimal)
        {

        }
        field(31; "Future Delivery Ontime"; Decimal)
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
