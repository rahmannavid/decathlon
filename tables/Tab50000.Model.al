table 50000 Model
{
    Caption = 'Model';
    DataClassification = ToBeClassified;
    LookupPageId = 50000;
    DrillDownPageId = 50000;

    fields
    {
        field(1; Model; Code[20])
        {
            Caption = 'Model';
            DataClassification = ToBeClassified;

        }
        field(2; "Model Name"; Text[60])
        {
            Caption = 'Model Name';
            DataClassification = ToBeClassified;

        }
        field(3; Conception; Text[20])
        {
            Caption = 'Conception';
            DataClassification = ToBeClassified;
        }
        field(4; DSM; Code[20])
        {
            Caption = 'DSM';
            DataClassification = ToBeClassified;
            TableRelation = "DSM (Super Model)";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DSM_Rec: Record "DSM (Super Model)";
            begin
                if DSM <> '' then
                    DSM_Rec.Get(DSM);
                "DSM Name" := DSM_Rec."DSM Name";
            end;

        }
        field(5; "DSM Name"; Text[60])
        {
            Caption = 'DSM Name';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(6; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Vendor_Rec: Record Vendor;
            begin
                Vendor_Rec.Get("Vendor No");
                "Vendor Name" := Vendor_Rec.Name;
            end;
        }
        field(7; "Vendor Name"; Text[60])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Size Group"; Code[20])
        {
            Caption = 'Size Group';
            DataClassification = ToBeClassified;
            TableRelation = Size."Size Group";
        }
        field(9; "Sharing Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; Model, "Vendor No", DSM)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Model, "Model Name", DSM, "DSM Name", "Vendor No", "Vendor Name")
        {

        }

    }

}
