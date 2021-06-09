tableextension 50009 "User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "Admin User"; Boolean)
        {
            Caption = 'Admin User';
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger OnValidate()
            begin
                Rec."Sole Supplier" := '';
            end;
        }
        field(50006; "Sole Supplier"; Code[20])
        {
            Caption = 'Sole Supplier';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            trigger OnValidate()
            begin
                Rec."Vendor No." := '';
            end;
        }
        field(50007; "location Code"; Code[20])
        {
            TableRelation = Location;
        }
    }
}
