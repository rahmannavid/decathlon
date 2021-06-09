page 50018 "Inventory Report By Period"
{

    Caption = 'Inventory Report By Period';
    PageType = ListPart;
    SourceTable = "Inventory Report By Period";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Rec.Indentation;
                IndentationControls = "Report Level";
                ShowAsTree = true;

                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                }
                field("Report Level"; Rec."Report Level")
                {
                    ApplicationArea = All;
                }
                field("Report Level Desc."; Rec."Report Level Desc.")
                {
                    ApplicationArea = all;
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
                    Caption = 'Balance On  Period';
                    ApplicationArea = All;
                }
            }
        }
    }

}
