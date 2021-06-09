page 50000 Models
{

    ApplicationArea = All;
    Caption = 'Models';
    PageType = List;
    SourceTable = "Model";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field(Model_Name; Rec."Model Name")
                {
                    ApplicationArea = All;
                }
                field(DSM; Rec.DSM)
                {
                    ApplicationArea = All;
                }
                field("DSM Name"; Rec."DSM Name")
                {
                    ApplicationArea = All;
                }
                field("Size Group"; Rec."Size Group")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field(Conception; Rec.Conception)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Item Distributions")
            {
                ApplicationArea = All;
                Image = DistributionGroup;
                trigger OnAction()
                var
                    Pag_ItemDist: Page "Item Distributions";
                    Rec_ItemDist: Record "Item Distributions";
                begin
                    Rec_ItemDist.SetRange("Model No", Rec.Model);
                    if Rec_ItemDist.FindFirst() then begin
                        Pag_ItemDist.SetTableView(Rec_ItemDist);
                        Pag_ItemDist.Editable := false;
                        Pag_ItemDist.Run();
                    end;
                end;
            }
        }

    }

}
