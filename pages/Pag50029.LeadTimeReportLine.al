page 50029 "Lead Time Report Line"
{

    Caption = 'Lead Time Report Line';
    PageType = ListPart;
    SourceTable = "Performance Report Lines";

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
                    ApplicationArea = All;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shipment Quantity"; Rec."Shipment Quantity")
                {
                    ApplicationArea = All;
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    Caption = 'Realized Lead Time';
                    ApplicationArea = All;
                }
                field("Future Lead Time"; Rec."Future Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Combined Lead Time"; Rec."Combined Lead Time")
                {
                    Caption = 'Piloted Lead Time';
                    ApplicationArea = All;

                }

            }
        }
    }

}
