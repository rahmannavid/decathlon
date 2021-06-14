page 50034 "LC Informations"
{

    ApplicationArea = All;
    Caption = 'LC Informations';
    PageType = List;
    SourceTable = "LC Informations";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("LC No."; Rec."LC No.")
                { }
                field("Issued By (FG)"; Rec."Issued By (FG)")
                {
                    Caption = 'Issued By';
                }
                field("Issued To (Sole)"; Rec."Issued To (Sole)")
                {
                    Caption = 'Issued To';
                }
                field("LC Amount"; Rec."LC Amount")
                { }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        userSetup: Record "User Setup";
        ItemDist: Record "Item Distributions";
        vendor: Record Vendor;
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."Vendor No." <> '' then begin
                if vendor.Get(userSetup."Vendor No.") then;
                rec.SetRange("Issued By (FG)", vendor."Location Code");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    ItemDist.Reset();
                    ItemDist.SetFilter("Sole Supplier", userSetup."Sole Supplier");
                    ItemDist.FindFirst();
                    if vendor.Get(userSetup."Vendor No.") then;
                    rec.SetFilter("Issued To (Sole)", vendor."Location Code");
                    Rec.FilterGroup(2);
                end;
        end;

    end;

}
