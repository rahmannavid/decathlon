table 50015 "Inventory Report By Location"
{
    Caption = 'Inventory Report By Period';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Location"; Code[10])
        {
            Caption = 'Location';
            TableRelation = Location;

        }
        field(3; "Gross Requirement"; Decimal)
        {
            Caption = 'Gross Requirement';

        }
        field(4; "Firmed Order"; Decimal)
        {
            Caption = 'Schedule Receipt';

        }
        field(5; "Planned Order"; Decimal)
        {
            Caption = 'Planned Order';
        }
        field(6; "Projected Available Balance"; Decimal)
        {

        }
        field(7; "Shceduled Order"; Decimal)
        {

        }
        field(8; Inventory; Decimal)
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
