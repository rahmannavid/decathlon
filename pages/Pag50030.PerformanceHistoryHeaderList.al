page 50030 "Perf. History Header List"
{

    ApplicationArea = All;
    Caption = 'Performance History Header List';
    PageType = List;
    SourceTable = "Performance History Header";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Order type"; Rec."Order type")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order Date"; Rec."Purchase Order Date")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order No."; Rec."Transfer Order No.")
                {
                    ApplicationArea = All;
                }
                field("Transfer Order Date"; Rec."Transfer Order Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Date"; Rec."Expected Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                }
                field("FG Suplier Code"; Rec."FG Location Code")
                {
                    ApplicationArea = All;
                }
                field("Sole Suplier Code"; Rec."Sole Location Code")
                {
                    ApplicationArea = All;
                }
                field(DSM; Rec.DSM)
                {
                    ApplicationArea = All;
                }
                field(Process; Rec.Process)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Remaining Qty"; Rec."Remaining Qty")
                {
                    ApplicationArea = All;
                }
                field("Future Lead Time"; Rec."Future Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Future Qty Ontime 3 Days"; Rec."Future Qty Ontime 3 Days")
                {
                    ApplicationArea = All;
                }
                field("Delivery Ontime"; Rec."Future Delivery Ontime")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

}
