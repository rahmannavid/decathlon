table 50024 "LC Informations"
{
    Caption = 'LC Informations';

    fields
    {
        field(1; "LC No."; Code[20])
        {
            Caption = 'LC No.';
        }
        field(2; "Issued By (FG)"; Code[20])
        {
            Caption = 'Issued By';
            TableRelation = Location.Code;

        }
        field(3; "Issued To (Sole)"; Code[20])
        {
            Caption = 'Issued To';
            TableRelation = Location.Code;

        }
        field(4; "LC Amount"; Decimal)
        {
            Caption = 'LC Amount';
        }
    }
    keys
    {
        key(PK; "LC No.")
        {
            Clustered = true;
        }
    }

}
