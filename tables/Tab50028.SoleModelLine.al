table 50028 "Sole Model Line"
{
    Caption = 'Sole Mold Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "FG DSM"; Code[20])
        {
            Caption = 'FG DSM';
            DataClassification = ToBeClassified;
            TableRelation = Model.DSM;
        }
        field(4; "FG DSM Description"; Text[100])
        {
            Caption = 'FG DSM Description';
            DataClassification = ToBeClassified;
        }
        field(5; "FG Model Code"; Code[20])
        {
            Caption = 'FG Model Code';
            DataClassification = ToBeClassified;
        }
        field(6; "FG Model Description"; Text[100])
        {
            Caption = 'FG Model Description';
            DataClassification = ToBeClassified;
        }
        field(7; "FG Location"; Code[20])
        {
            Caption = 'FG Location';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
