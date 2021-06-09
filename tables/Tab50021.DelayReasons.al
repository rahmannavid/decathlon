table 50021 "Delay Reasons"
{
    Caption = 'Delay Reasons';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Description)
        {
            Clustered = true;
        }
    }

}
