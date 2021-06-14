pageextension 50015 "Finished Production Orders" extends "Finished Production Orders"
{
    layout
    {
        addafter(Description)
        {
            field("DSM Code65294"; Rec."DSM Code")
            {
                ApplicationArea = All;
            }
            field("DSM Name33673"; Rec."DSM Name")
            {
                ApplicationArea = All;
            }
            field("Item No15543"; Rec."Item No")
            {
                ApplicationArea = All;
            }
            field("Item Name37258"; Rec."Item Name")
            {
                ApplicationArea = All;
            }
            field("Location Code71295"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Starting Date-Time")
        {
            Visible = false;
        }
        modify("Ending Date-Time")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }

    }

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."location Code" <> '' then begin
                rec.SetFilter("Location Code", userSetup."location Code");
                Rec.FilterGroup(2);
            end else
                Error('You do not have permission to view this page');
        end;
    end;
}
