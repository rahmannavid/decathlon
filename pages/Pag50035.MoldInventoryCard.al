page 50035 "Mold Inventory Card"
{

    Caption = 'Mold Inventory Card';
    PageType = Card;
    SourceTable = "Sole Mold Inventory Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the Mold Code field';
                    ApplicationArea = All;
                }
                field("Mold Description"; Rec."Mold Description")
                {
                    ToolTip = 'Specifies the value of the Mold Description field';
                    ApplicationArea = All;
                }

                field("Process Code"; Rec."Process Code")
                {
                    ToolTip = 'Specifies the value of the Process field';
                    ApplicationArea = All;
                }
                field("Process Name"; Rec."Process Name")
                {
                    ToolTip = 'Specifies the value of the Process Name field';
                    ApplicationArea = All;
                }
                field("Total No of Mold"; Rec."Total No of Mold")
                {
                    ToolTip = 'Specifies the value of the Total No of Mold field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total No Sub Set"; Rec."Total No Sub Set")
                {
                    ToolTip = 'Specifies the value of the Total No Sub Set field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the value of the Location field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ext. MMC"; Rec."Ext. MMC")
                {
                    ToolTip = 'Specifies the value of the Ext. MMC field';
                    ApplicationArea = All;
                    Visible = false;
                }
            }

            part(SoleMoldLines; "Mold Inventory Subform")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No."), "Ownership of Mold" = field(FILTER(Location));
                SubPageView = sorting("Mold Set No") order(ascending);

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                Image = Refresh;
                trigger OnAction()
                begin
                    MoldCounting();
                    AutoTextsUpdate();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        MoldInvLine: Record "Sole Mold Inventory Line";
    begin
        MoldInvLine.SetRange("Document No.", Rec."No.");
        if MoldInvLine.FindFirst() then
            MoldInvLine.DeleteAll();
    end;

    trigger OnAfterGetRecord()
    var
        userSetup: Record "User Setup";

    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Rec.Location := userSetup."location Code";
        end else
            Rec.Location := '';
    end;

    local procedure MoldCounting()
    var
        MoldInvLine: Record "Sole Mold Inventory Line";
        TotalMold: Integer;
        TotalMoldSet: Integer;
        PrevMold: Code[20];
        PrevMoldSet: Code[20];
    begin
        MoldInvLine.SetRange("Document No.", Rec."No.");
        if MoldInvLine.FindFirst() then begin
            MoldInvLine.SetCurrentKey("Mold Set Code");
            repeat
                if PrevMold <> MoldInvLine."Mold Set Code" then begin
                    TotalMold += 1;
                    PrevMold := MoldInvLine."Mold Set Code";
                end;
                if PrevMoldSet <> MoldInvLine."Mold Sub Set Code" then begin
                    TotalMoldSet += 1;
                    PrevMoldSet := MoldInvLine."Mold Sub Set Code";
                end;

            until (MoldInvLine.Next() = 0);
            Rec."Total No of Mold" := TotalMold;
            Rec."Total No Sub Set" := TotalMoldSet;
            Rec.Modify();
        end;
    end;

    local procedure AutoTextsUpdate()
    var
        MoldInvLine: Record "Sole Mold Inventory Line";
        Process: Record Process;
    begin
        MoldInvLine.SetRange("Document No.", Rec."No.");
        if MoldInvLine.FindFirst() then begin
            Process.Get(Rec."Process Code");
            Rec."Mold Description" := MoldInvLine."Mold No" + '-' + MoldInvLine."Mold Description" + '-[' + Process."Process Short Name" + ']';
            Rec.Modify();
            MoldInvLine.UpdateTexts(Rec);
        end;
    end;
}
