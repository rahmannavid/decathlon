table 50001 "DSM (Super Model)"
{
    Caption = 'DSM (Super Model)';
    DataClassification = ToBeClassified;
    LookupPageId = 50001;
    DrillDownPageId = 50001;

    fields
    {
        field(1; "DSM Code"; Code[20])
        {
            Caption = 'DSM Code';
            DataClassification = ToBeClassified;
        }
        field(2; "DSM Name"; Text[60])
        {
            Caption = 'DSM Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "DSM Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "DSM Code", "DSM Name")
        {

        }
    }

}
