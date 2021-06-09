tableextension 50004 Location extends Location
{
    fields
    {
        field(50000; "Default Vendor No."; Code[20])
        {
            Caption = 'Default Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                VendorRec: Record Vendor;
            begin
                VendorRec.Get("Default Vendor No.");
                Rec.Name := VendorRec.Name;
                Rec."Name 2" := VendorRec."Name 2";
                Rec.Address := VendorRec.Address;
                Rec."Address 2" := VendorRec."Address 2";
                Rec."Phone No." := VendorRec."Phone No.";
                Rec."E-Mail" := VendorRec."E-Mail";
                Rec.City := VendorRec.City;
                Rec."Country/Region Code" := VendorRec."Country/Region Code";
                Rec."Post Code" := VendorRec."Post Code";
            end;
        }

        modify("Name 2")
        {
            Caption = 'Short Name';
        }
    }
}
