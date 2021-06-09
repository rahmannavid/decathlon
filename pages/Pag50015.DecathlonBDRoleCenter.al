page 50015 "Decathlon BD Role Center"
{

    Caption = 'Decathlon BD Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control1; "DC Role Center Cue")
            {
                ApplicationArea = All;
            }
            part(Control2; "Generic Chart")
            {
                ApplicationArea = All;

            }
            part(Control3; "My Items")
            {
                ApplicationArea = All;

            }
            chartpart("SotckChart"; "DCSTOCK")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Sections)
        {
            group("Group")
            {
                Caption = 'General';
                action("Purchase Plannings")
                {
                    ToolTip = 'Purchase Plannings';
                    ApplicationArea = All;
                    RunObject = page "Prod. Order Planning Lists";
                }

                // action("Purchase Orders")
                // {
                //     ToolTip = 'Purchase Order';
                //     ApplicationArea = All;
                //     Visible = false;
                //     RunObject = page "Purchase Order List";
                // }

                action("Transfer Orders")
                {
                    Caption = 'Purchase Orders';
                    //ToolTip = 'Transfer Orders';
                    ApplicationArea = All;
                    RunObject = page "Transfer Orders";
                }

                action("Warehouse Shipments")
                {
                    ApplicationArea = All;
                    RunObject = page "Warehouse Shipment List";
                }
                action("Warehouse Receipts")
                {
                    ApplicationArea = All;
                    RunObject = page "Warehouse Receipts";
                }
                action("Released Production Orders")
                {
                    ToolTip = 'Production Orders';
                    Caption = 'Production Orders';
                    ApplicationArea = All;
                    RunObject = page "Released Production Orders";
                }

                action("Sole Utilizations")
                {
                    ApplicationArea = all;
                    RunObject = page "Sales Order list";
                }
                action("Item List")
                {
                    ApplicationArea = all;
                    RunObject = page "Item List";
                }

                action("Output Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Output Journal";
                }
                action("Item Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Item Journal";
                }

                action("Purchase Invoices")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Purchase Invoices";
                }

                action("LC Informations")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "LC Informations";
                }
                action("Sole Mold Inventory")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Mold Inventory list";
                }
                action("Sole Molels")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Sole Model List";
                }

            }
            group("Group2")
            {
                Caption = 'Report & Analysis';
                action("Item Availability Report By Period")
                {
                    Caption = 'Availability By Period';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Item Avail. Report By Period";
                    RunPageMode = Edit;
                }

                action("Item Availability Report By Location")
                {
                    Caption = 'Availability By Location';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Item Avail. Report By Location";
                    RunPageMode = Edit;
                }
                action("Items by Location")
                {
                    Caption = 'Inventory by Location';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Items by Location";
                    RunPageMode = Edit;
                }
                action("Items by Size")
                {
                    Caption = 'Inventory by Size';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Items by Size";
                    RunPageMode = Edit;
                }
                action("Lead Time Report")
                {
                    Caption = 'Lead Time Report';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Lead Time Report";
                    RunPageMode = Edit;
                }
                action("DOT Report")
                {
                    Caption = 'DOT Report';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "DOT Report";
                    RunPageMode = Edit;
                }
            }

            group("Group3")
            {
                Caption = 'Archives';

                action("Posted Shipments")
                {
                    Caption = 'Posted Shipments';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Posted Whse. Shipment List";
                    RunPageMode = Edit;
                }
                action("Posted Receipts")
                {
                    Caption = 'Posted Receipts';
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Posted Whse. Receipt List";
                    RunPageMode = Edit;
                }
                action("Finished Production Orders")
                {
                    ToolTip = 'Finished Production Orders';
                    ApplicationArea = All;
                    RunObject = page "Finished Production Orders";
                }

                action("Posted Sole Utilization")
                {
                    ApplicationArea = All;
                    RunObject = page "Posted Sales Shipments";
                }
            }
            group("Group1")
            {
                Caption = 'Setup';

                action("Vendor List")
                {
                    ApplicationArea = all;
                    RunObject = page "Vendor List";
                }
                action("Model List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page Models;
                }
                action("DSM List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "DMS (Super Model)";
                }
                action("Process List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Process List";
                }
                action("Color Code List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Color Code List";
                }
                action("DPP List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "DPP List";
                }
                action("Size List")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Size List";
                }

                action(Location)
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Location List";
                }
                action("Item Distributions")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Item Distributions";
                }
                action("No. Series")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "No. Series";
                }
                action("Sales & Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Sales & Receivables Setup";
                }
                action("Purchases & Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Purchases & Payables Setup";
                }
                action("Inventory Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Inventory Setup";
                }

            }

        }
    }

}
