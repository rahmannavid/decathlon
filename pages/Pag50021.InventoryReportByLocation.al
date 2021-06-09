page 50021 "Inventory Report By Location"
{

    Caption = 'Inventory Report By Location';
    PageType = ListPart;
    SourceTable = "Inventory Report By Location";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = All;
                }
                field("Gross Requirement"; Rec."Gross Requirement")
                {
                    ApplicationArea = All;
                }
                field("Firmed Order"; Rec."Firmed Order")
                {
                    ApplicationArea = All;
                }
                field("Planned Order"; Rec."Planned Order")
                {
                    ApplicationArea = All;
                }
                field("Shceduled Order"; Rec."Shceduled Order")
                {
                    ApplicationArea = All;
                }
                field("Projected Available Balance"; Rec."Projected Available Balance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
