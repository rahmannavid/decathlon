pageextension 50012 "User Setup" extends "User Setup"
{
    layout
    {
        addafter(PhoneNo)
        {
            field("Admin User"; Rec."Admin User")
            {
                ApplicationArea = all;
            }
            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = all;
            }
            field("Sole Supplier"; Rec."Sole Supplier")
            {
                ApplicationArea = all;
            }
            field("location Code"; Rec."location Code")
            {
                ApplicationArea = all;
            }

        }
        modify("Register Time")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }
    }
}
