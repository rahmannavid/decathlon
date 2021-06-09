table 50003 "Color Code"
{
    Caption = 'Color Code';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Color Name"; Text[50])
        {
            Caption = 'Color Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Color Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DrowpDown; "Color Code", "Color Name") { }
    }

}
