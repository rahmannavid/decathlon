table 50002 Process
{
    Caption = 'Process';
    DataClassification = ToBeClassified;
    LookupPageId = "Process List";

    fields
    {
        field(1; "Process Code"; Code[20])
        {
            Caption = 'Process Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Process Name"; Text[50])
        {
            Caption = 'Process Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Process Short Name"; Text[10])
        {

        }
    }
    keys
    {
        key(PK; "Process Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Process Code", "Process Name")
        {

        }
    }
}
