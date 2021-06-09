table 50004 "DPP List"
{
    Caption = 'DPP List';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "DPP Code"; Code[20])
        {
            Caption = 'DPP Code';
            DataClassification = ToBeClassified;
        }
        field(2; "DPP Name"; Text[60])
        {
            Caption = 'DPP Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "DPP Code")
        {
            Clustered = true;
        }
    }

}
