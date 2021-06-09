table 50006 "Related Parties"
{
    Caption = 'Related Parties (Vendor)';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }
        field(2; "Related Party Code"; Code[20])
        {
            Caption = 'Related Party Code';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Vendor_Rec: Record Vendor;
            begin
                if "Related Party Code" <> '' then begin
                    Vendor_Rec.Get("Vendor No.");
                    "Related Party Name" := Vendor_Rec.Name;
                end;

            end;
        }
        field(3; "Related Party Name"; Text[60])
        {
            Caption = 'Related Party Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Vendor No.", "Related Party Code")
        {
            Clustered = true;
        }
    }

}
