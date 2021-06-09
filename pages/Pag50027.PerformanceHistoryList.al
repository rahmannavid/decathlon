page 50027 "Performance History List"
{

    ApplicationArea = All;
    Caption = 'Performance History List';
    PageType = List;
    SourceTable = "Performance History";
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
                field("Shipment No."; Rec."Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
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
                field("Shipment Quantity"; Rec."Shipment Quantity")
                {
                    ApplicationArea = All;
                }
                field("Lead Time"; Rec."Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Quantity Ontime"; Rec."Qty Ontime")
                {
                    Caption = 'Quantity Ontime';
                    ApplicationArea = All;
                }
                field("Quantity Ontime 3 Days"; Rec."Qty Ontime 3 Days")
                {
                    Caption = 'Quantity Ontime (3 Days)';
                    ApplicationArea = All;
                }
                field("Quantity Ontime 7 Days"; Rec."Qty Ontime 7 Days")
                {
                    Caption = 'Quantity Ontime (7 Days)';
                    ApplicationArea = All;
                }
                field("Delivery Ontime"; Rec."Delivery Ontime")
                {
                    Caption = 'Delivery Ontime';
                    ApplicationArea = All;
                }
            }
        }
    }

}
