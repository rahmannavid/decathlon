page 50012 "Prod. Order Planning Lists"
{

    ApplicationArea = All;
    Caption = 'Purchase Planning Lists';
    PageType = List;
    SourceTable = "Order Planning Header";
    UsageCategory = Lists;
    CardPageId = "Prod. Order Planing Overview";
    Editable = false;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(DMS; Rec.DSM)
                {
                    ApplicationArea = All;
                }
                field("DSM Name"; Rec."DSM Name")
                {

                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }



            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(New)
            {
                ApplicationArea = All;
                Image = NewLotProperties;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Prod. Order Planing";
                RunPageMode = Create;
            }
            action(Edit)
            {
                ApplicationArea = All;
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Prod. Order Planing";
                RunPageLink = "No." = field("No.");
                RunPageMode = Edit;
            }
            action(Overview)
            {
                ApplicationArea = All;
                Image = FiledOverview;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Prod. Order Planing Overview";
                RunPageLink = "No." = field("No.");
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        userSetup: Record "User Setup";
        ItemDist: Record "Item Distributions";
        VendFilter: Text[200];
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."Vendor No." <> '' then begin
                rec.SetRange("Vendor No.", userSetup."Vendor No.");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    ItemDist.Reset();
                    ItemDist.SetRange("Sole Supplier", userSetup."Sole Supplier");
                    ItemDist.FindFirst();
                    rec.SetFilter("Vendor No.", ItemDist."Vendor No");
                    Rec.FilterGroup(2);
                end;
        end;

    end;

}
