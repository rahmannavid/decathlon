page 50072 "FG & Sole Supplier RoleCenter"
{

    Caption = 'FG & Sole Supplier RoleCenter';
    PageType = RoleCenter;


    layout
    {
        area(RoleCenter)
        {
            part(Control1; "Sole Role Center Cue")
            {
                ApplicationArea = All;
                Caption = 'Activity (Sole)';
            }
            part(Control2; "FG Role Center Cue")
            {
                ApplicationArea = All;
                Caption = 'Activity (FG)';
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
                    Caption = 'Purchase Order';
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

                action("Output Journal")
                {
                    ApplicationArea = all;
                    RunObject = page "Output Journal";
                }
                action("Sole Utilizations")
                {
                    ApplicationArea = all;
                    RunObject = page "Sales Order list";
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
                action("Finished Production Orders")
                {
                    ToolTip = 'Finished Production Orders';
                    ApplicationArea = All;
                    RunObject = page "Finished Production Orders";
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
            }
        }
    }

}
