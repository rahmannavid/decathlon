tableextension 50009 "User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "Admin User"; Boolean)
        {
            Caption = 'Admin User';
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor No."; Code[50])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Validate("location Code", SystemMgt.ReturnVendorLocation("Vendor No.", "Sole Supplier"));
            end;

            trigger OnLookup()
            var

            begin
                Validate("Vendor No.", SystemMgt.VendorLookup("Vendor No."));
            end;
        }
        field(50006; "Sole Supplier"; Code[50])
        {
            Caption = 'Sole Supplier';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                ;
                Validate("location Code", SystemMgt.ReturnVendorLocation("Vendor No.", "Sole Supplier"));
            end;

            trigger OnLookup()
            var

            begin
                Validate("Sole Supplier", SystemMgt.VendorLookup("Sole Supplier"));
            end;
        }
        field(50007; "location Code"; Code[50])
        {
            trigger OnLookup()
            begin
                Validate("location Code", SystemMgt.LocationLookUp("location Code"));
            end;
        }
    }
    var
        SystemMgt: Codeunit "System Management";

}
