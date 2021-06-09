table 50013 "Inventory Report By Period"
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
        field(2; "Period Start"; Date)
        {
            Caption = 'Period Start';
            DataClassification = ToBeClassified;
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
            //get from history table
        }
        field(8; "Report Level"; Code[20])
        {
            Caption = 'Code';
        }
        field(9; "Report Level Desc."; Text[150])
        {
            Caption = 'Description';
        }
        field(10; Indentation; Integer)
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
