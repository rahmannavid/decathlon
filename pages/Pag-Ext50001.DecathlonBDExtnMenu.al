pageextension 50001 "Decathlon BD Extn Menu" extends "Order Processor Role Center"
{
    actions
    {
        addlast("Action76")
        {
            action("Purchase Plannings")
            {
                ToolTip = 'Purchase Plannings';
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = page "Prod. Order Planning Lists";
            }
        }
        addafter(SetupAndExtensions)
        {
            group("Decathlon BD Setup")
            {
                Caption = 'Decathlon BD Setup';

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

            }


        }

    }
}
