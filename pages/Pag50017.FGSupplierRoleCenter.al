page 50017 "FG Vendor Role Center"
{

    Caption = 'FG Vendor Role Center';
    PageType = RoleCenter;
    layout
    {
        area(RoleCenter)
        {
            part(Control1; "FG Role Center Cue")
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
                //     ;
                //     RunObject = page "Purchase Order List";
                // }
                action("Transfer Orders")
                {
                    Caption = 'Purchase Order';
                    ApplicationArea = all;
                    RunObject = page "Transfer Orders";
                }
                action("Warehouse Receipts")
                {
                    ApplicationArea = All;
                    RunObject = page "Warehouse Receipts";
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
