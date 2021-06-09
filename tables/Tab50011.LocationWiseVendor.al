table 50011 "Location Wise Vendor"
{
    Caption = 'Location Wise Vendor';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Location No."; Code[20])
        {
            Caption = 'Location No.';
            DataClassification = ToBeClassified;
            TableRelation = Location;
            ValidateTableRelation = true;
        }
        field(2; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                vendor: Record Vendor;
            begin
                vendor.Get("Vendor No.");
                "Vendor Name" := vendor.Name;
            end;
        }
        field(3; "Vendor Name"; Text[60])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Location No.", "Vendor No.")
        {
            Clustered = true;
        }
    }

}
