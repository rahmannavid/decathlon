pageextension 50017 "Output Journal" extends "Output Journal"
{
    layout
    {
        modify("Document No.")
        {
            Visible = false;
        }
        modify("Operation No.")
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = false;
        }
        modify("Run Time")
        {
            Visible = false;
        }
        modify("Cap. Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Scrap Quantity")
        {
            Visible = false;
        }
        addafter(Finished)
        {
            field("Location Code74441"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Variant Code1"; Rec."Variant Code")
            {
                ApplicationArea = all;
                trigger OnValidate()
                begin
                    if Rec."Shortcut Dimension 1 Code" <> Rec."Variant Code" then
                        Rec.Validate("Shortcut Dimension 1 Code", Rec."Variant Code");
                end;
            }
        }

        modify("Applies-to Entry")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }

    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
        locationVar: Record Location;
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if locationVar.Get(userSetup."location Code") then
                Rec."Location Code" := userSetup."location Code";
        end;
    end;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Rec.SetFilter("Location Code", userSetup."location Code");
            Rec.FilterGroup(2);
        end;
    end;

}
