pageextension 50005 "Location Card" extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            field("Name 2"; Rec."Name 2")
            {
                ApplicationArea = All;
            }
            field("Default Vendor No."; Rec."Default Vendor No.")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter("&Location")
        {
            action("Location Wise Vendor")
            {
                ApplicationArea = All;
                Image = RelatedInformation;
                RunObject = Page "Location Wise Vendor";
                RunPageLink = "Location No." = field(Code);
            }
        }
    }
}

