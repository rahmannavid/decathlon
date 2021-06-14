Page 50070 "Lookup Vendor Lists"
{
    SourceTable = Vendor;
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Selected then
                            InsertTempVend(Rec."No.")
                        else
                            DeleteUnselected(Rec."No.");
                    end;

                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Responsibility Center"; rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }



            }
        }

    }

    trigger OnAfterGetRecord()
    var
    begin
        Selected := CheckSelected(Rec."No.");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Clear(VendText);
        TempVendVar.Reset();
        if TempVendVar.Find('-') then
            repeat
                if VendText = '' then
                    VendText := TempVendVar."No."
                else
                    VendText += '|' + TempVendVar."No.";
            until TempVendVar.Next() = 0;
    end;

    var
        Selected: Boolean;
        VendVar: Record Vendor;
        TempVendVar: Record Vendor temporary;
        VendText: Text;

    procedure InsertTempVend(VendorText: Text)
    begin
        if VendorText = '' then
            exit;
        VendVar.Reset();
        VendVar.SetFilter("No.", VendorText);
        if VendVar.Find('-') then
            repeat
                TempVendVar.Init();
                TempVendVar."No." := VendVar."No.";
                TempVendVar.Insert();
            until VendVar.Next() = 0;
    end;

    local procedure CheckSelected(VendorText: Text): Boolean
    begin
        TempVendVar.Reset();
        TempVendVar.SetRange("No.", VendorText);
        if TempVendVar.FindFirst() then
            exit(true);
    end;

    local procedure DeleteUnselected(VendorText: Text)
    begin
        TempVendVar.Reset();
        TempVendVar.SetRange("No.", VendorText);
        if TempVendVar.FindFirst() then
            TempVendVar.Delete();
    end;

    procedure ReturnVendorText(): text
    begin
        exit(VendText);
    end;
}
