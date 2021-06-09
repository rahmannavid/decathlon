pageextension 50041 "Item List" extends "Item List"
{
    layout
    {
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        addafter("No.")
        {
            field("FG DSM08217"; Rec."FG DSM")
            {
                ApplicationArea = All;
            }
            field("FG DSM Name49773"; Rec."FG DSM Name")
            {
                ApplicationArea = All;
            }
        }
        moveafter("No."; Description)
        addafter(Type)
        {
            field("Sole DSM69643"; Rec."Sole DSM")
            {
                ApplicationArea = All;
            }
            field("Sole DSM Name70759"; Rec."Sole DSM Name")
            {
                ApplicationArea = All;
            }
            field("Safety Lead Time75721"; Rec."Safety Lead Time")
            {
                ApplicationArea = All;
            }
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        moveafter(Description; InventoryField)
    }
    trigger OnAfterGetRecord()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId);
        if not userSetup."Admin User" then
            Rec.SetRange("Location Filter", userSetup."location Code");
    end;
}
