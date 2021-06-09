page 50036 "Mold Inventory Subform"
{

    Caption = 'Mold Inventory Subform';
    PageType = ListPart;
    SourceTable = "Sole Mold Inventory Line";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Mold Set Code"; Rec."Mold Set Code")
                {
                    ToolTip = 'Specifies the value of the Mold Set Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mold Set Description"; Rec."Mold Set Description")
                {
                    ToolTip = 'Specifies the value of the Mold Set Description field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mold Sub Set Code"; Rec."Mold Sub Set Code")
                {
                    ToolTip = 'Specifies the value of the Mold Sub Set Code field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mold Sub Set Description"; Rec."Mold Sub Set Description")
                {
                    ToolTip = 'Specifies the value of the Mold Sub Set Description field';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Mold No"; Rec."Mold No")
                {
                    ToolTip = 'Specifies the value of the Mold No field';
                    ApplicationArea = All;
                }
                field("Mold Description"; Rec."Mold Description")
                {
                    ToolTip = 'Specifies the value of the Mold Description field';
                    ApplicationArea = All;
                }
                field("Mold Provider"; Rec."Mold Provider")
                {
                    ToolTip = 'Specifies the value of the Mold Provider field';
                    ApplicationArea = All;
                }
                field("Mold Location"; Rec."Mold Location")
                {
                    ToolTip = 'Specifies the value of the Mold Location field';
                    ApplicationArea = All;
                }
                field("Ownership of Mold"; Rec."Ownership of Mold")
                {
                    ToolTip = 'Specifies the value of the Ownership of Mold field';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        checkAdmin();
                    end;
                }
                field("Mold Set No"; Rec."Mold Set No")
                {
                    ToolTip = 'Specifies the value of the Mold Set No field';
                    ApplicationArea = All;
                }
                field(Size; Rec.Size)
                {
                    ToolTip = 'Specifies the value of the Size field';
                    ApplicationArea = All;
                }
                field("Mold Sub Set ID"; Rec."Mold Sub Set ID")
                {
                    ToolTip = 'Specifies the value of the Mold Sub Set ID field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Ext. MIC"; Rec."Ext. MIC")
                {
                    ToolTip = 'Specifies the value of the Ext. MIC field';
                    ApplicationArea = All;
                }
                field(Active; Rec.Active)
                {
                    trigger OnValidate()
                    begin
                        checkAdmin();
                    end;
                }
            }
        }
    }

    var
        UserErrorText: TextConst ENU = 'You donot have permission to edit this text';

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        Rec."Ownership of Mold" := userSetup."location Code";
    end;

    trigger OnModifyRecord(): Boolean
    begin
        if Rec.Active then
            Error('Active line cannot be modified.');
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if Rec.Active then
            Error('Active line cannot be deleted.');
    end;

    procedure SetLocationFilter(LocationCode: Code[20])
    begin
        Rec.SetRange("Mold Location", LocationCode);
        Rec.FilterGroup(2);
    end;

    local procedure checkAdmin()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Error(UserErrorText);
        end;
    end;

}
