page 50016 "Sole Supplier Role Center"
{

    Caption = 'Sole Supplier Role Center';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Control1; "Sole Role Center Cue")
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
            }
        }
    }

}
