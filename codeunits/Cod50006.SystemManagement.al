codeunit 50006 "System Management"
{
    procedure VendorLookup(VendText: Text): Text
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

    procedure LocationLookUp(LocationText: Text): Text
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

    procedure ReturnVendorLocation(vendorText: text[100]; soleSupplierText: Text[100]): text[100]
    var
        vendorVar: Record Vendor;
        locationText: Text;
    begin
        vendorVar.Reset();
        if (vendorText <> '') and (soleSupplierText <> '') then
            vendorVar.SetFilter("No.", StrSubstNo('%1|%2', vendorText, soleSupplierText))
        else
            if vendorText <> '' then
                vendorVar.SetFilter("No.", vendorText)
            else
                if soleSupplierText <> '' then
                    vendorVar.SetFilter("No.", soleSupplierText)
                else
                    exit('');
        if vendorVar.Find('-') then
            repeat
                if vendorVar."Location Code" <> '' then begin
                    if locationText = '' then
                        locationText := vendorVar."Location Code"
                    else
                        locationText += '|' + vendorVar."Location Code";
                end;
            until vendorVar.Next() = 0;
        exit(locationText);
    end;
}
