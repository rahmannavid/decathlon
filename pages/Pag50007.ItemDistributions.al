page 50007 "Item Distributions"
{

    ApplicationArea = All;
    Caption = 'Item Distributions';
    PageType = List;
    SourceTable = "Item Distributions";
    UsageCategory = Lists;
    //Editable = pageeditable;

    layout
    {

        area(content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Model No"; Rec."Model No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var

                    begin
                        CurrPage.Update();
                    end;
                }
                field("Model Name"; Rec."Model Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("DSM Code"; Rec."DSM Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DSM Name"; Rec."DSM Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = all;
                }
                field("Sharing Percentage"; Rec."Sharing Percentage")
                {
                    ApplicationArea = All;
                }
                field("Component Supplier"; Rec."Sole Supplier")
                {
                    ApplicationArea = All;
                }
                field("Sole Supplier Name"; Rec."Sole Supplier Name")
                {
                    ApplicationArea = All;
                }

                field("Supplier Type"; Rec."Supplier Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Item Price"; Rec."Item Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(Refresh)
            {
                Promoted = true;
                PromotedCategory = New;

                trigger OnAction()
                var
                    ItemRec: Record Item;
                    ItemNo: Code[20];
                begin
                    ItemNo := Rec.GetFilter("Item No");
                    ItemRec.Get(ItemNo);
                    Rec.CreateItemDistribution(ItemRec."FG DSM", ItemRec."No.");
                    CurrPage.Update();
                end;

            }

        }
    }

    var
        pageeditable: Boolean;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin

            pageeditable := false;

            if userSetup."Vendor No." <> '' then begin
                rec.SetRange("Vendor No", userSetup."Vendor No.");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    Rec.SetRange("Sole Supplier", userSetup."Sole Supplier");
                    rec.FilterGroup(2);
                end
                else
                    Error('You do not have permission to view this page');
        end else
            pageeditable := false;

    end;

    trigger OnDeleteRecord(): Boolean
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Error('You do not have permission');
        end;
    end;

}
