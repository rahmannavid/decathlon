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
                Rec."Sole Supplier" := '';
            end;

            trigger OnLookup()
            var

            begin
                Validate("Vendor No.", VendorLookup("Vendor No."));
            end;
        }
        field(50006; "Sole Supplier"; Code[50])
        {
            Caption = 'Sole Supplier';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin

                Rec."Vendor No." := '';
            end;

            trigger OnLookup()
            var

            begin
                Validate("Sole Supplier", VendorLookup("Sole Supplier"));
            end;
        }
        field(50007; "location Code"; Code[50])
        {
            trigger OnLookup()
            begin
                Validate("location Code", LocationLookUp("location Code"));
            end;
        }
    }

    local procedure VendorLookup(VendText: Text): Text
    var
        Vendor: Record Vendor;
        PageVendorList: Page "Lookup Vendor Lists";
    begin
        Vendor.Reset();
        Clear(PageVendorList);
        PageVendorList.InsertTempVend(VendText);
        PageVendorList.SetRecord(Vendor);
        PageVendorList.SetTableView(Vendor);
        if PageVendorList.RunModal() = Action::OK then
            exit(PageVendorList.ReturnVendorText());
        exit(VendText);
    end;

    local procedure LocationLookUp(LocationText: Text): Text
    var
        Location: Record Location;
        PageLoacationList: Page "Lookup Location Lists";
    begin
        Location.Reset();
        Clear(PageLoacationList);
        PageLoacationList.InsertTempLocation(LocationText);
        PageLoacationList.SetRecord(Location);
        PageLoacationList.SetTableView(Location);
        if PageLoacationList.RunModal() = Action::OK then
            exit(PageLoacationList.ReturnLocationText());
        exit(LocationText);
    end;

}
