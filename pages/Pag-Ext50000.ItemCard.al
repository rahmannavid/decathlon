pageextension 50000 "Item Card" extends "Item Card"
{
    layout
    {
        addafter(Item)
        {
            group("Decathlon Ext. Fields")
            {
                field("Sole Model Code"; Rec."Sole Model Code")
                {
                    ApplicationArea = All;
                }
                field("Sole Model Description"; Rec."Sole Model Description")
                {
                    ApplicationArea = All;
                }
                field("Sole DSM"; rec."Sole DSM")
                {
                    ApplicationArea = All;
                }
                field("Sole DSM Name"; Rec."Sole DSM Name")
                {
                    ApplicationArea = all;
                }
                field("FG DSM"; Rec."FG DSM")
                {
                    ApplicationArea = all;
                }
                field("FG DSM Name"; Rec."FG DSM Name")
                {
                    ApplicationArea = all;
                }

                field("Process"; rec."Process")
                {
                    ApplicationArea = All;
                }
                field("Mold Name"; rec."Mold_Name")
                {
                    ApplicationArea = All;
                }
                field("Compound"; rec."Compound")
                {
                    ApplicationArea = All;
                }
                field("Color Code"; rec."Color Code")
                {
                    ApplicationArea = All;
                }
                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                }

            }
        }

        // Modifying the caption of the field 'Address 2'
        modify("Lead Time Calculation")
        {
            Caption = 'STR';
            ToolTip = '(Lead Time Calculation) Specifies a date formula for the amount of time it takes to replenish the item.';
        }

        modify(GTIN)
        {
            Visible = false;
        }
        modify("Item Category Code")
        {
            Importance = Additional;
        }
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }
        modify("Shelf No.")
        {
            Visible = false;
        }
        modify("Qty. on Purch. Order")
        {
            Visible = false;
        }
        modify("Qty. on Sales Order")
        {
            Visible = false;
        }
        modify("Unit Volume")
        {
            Visible = false;
        }
        modify("Standard Cost")
        {
            Visible = false;
        }
        modify("Unit Cost")
        {
            Importance = Additional;
        }
        modify("Net Invoiced Qty.")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Importance = Additional;
        }
        modify("Indirect Cost %")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Tariff No.")
        {
            Visible = false;
        }
        modify("Country/Region of Origin Code")
        {
            Visible = false;
        }
        modify("Sales Unit of Measure")
        {
            Importance = Additional;
        }
        modify("VAT Bus. Posting Gr. (Price)")
        {
            Visible = false;
        }
        modify(CalcUnitPriceExclVAT)
        {
            Visible = false;
        }
        modify("Profit %")
        {
            Importance = Additional;
        }
        modify("Item Disc. Group")
        {
            Visible = false;
        }
        modify("Allow Invoice Disc.")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Importance = Additional;
        }
        modify("Purch. Unit of Measure")
        {
            Importance = Additional;
        }
        modify("Vendor Item No.")
        {
            Importance = Additional;
        }
        modify("Manufacturing Policy")
        {
            Importance = Additional;
        }
        modify("Routing No.")
        {
            Importance = Additional;
        }
        modify("Production BOM No.")
        {
            Importance = Additional;
        }
        modify("Rounding Precision")
        {
            Visible = false;
        }
        modify("Flushing Method")
        {
            Importance = Additional;
        }
        modify("Overhead Rate")
        {
            Visible = false;
        }
        modify("Assembly Policy")
        {
            Importance = Additional;
        }
        modify(AssemblyBOM)
        {
            Importance = Additional;
        }
        modify("Reordering Policy")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Order Tracking Policy")
        {
            Visible = false;
        }
        modify("Stockkeeping Unit Exists")
        {
            Visible = false;
        }
        modify("Dampener Period")
        {
            Visible = false;
        }
        modify("Dampener Quantity")
        {
            Visible = false;
        }
        modify(Critical)
        {
            Visible = false;
        }
        modify("Safety Stock Quantity")
        {
            Visible = false;
        }
        modify("Include Inventory")
        {
            Visible = false;
        }
        modify("Lot Accumulation Period")
        {
            Visible = false;
        }
        modify("Rescheduling Period")
        {
            Visible = false;
        }
        modify("Reorder Point")
        {
            Visible = false;
        }
        modify("Reorder Quantity")
        {
            Visible = false;
        }
        modify("Maximum Inventory")
        {
            Visible = false;
        }
        modify("Overflow Level")
        {
            Visible = false;
        }
        modify("Time Bucket")
        {
            Visible = false;
        }
        modify("Order Multiple")
        {
            Visible = false;
        }
        modify("Item Tracking Code")
        {
            Importance = Additional;
        }
        modify("Lot Nos.")
        {
            Visible = false;
        }
        modify("Warehouse Class Code")
        {
            Visible = false;
        }
        modify("Special Equipment Code")
        {
            Visible = false;
        }
        modify("Put-away Template Code")
        {
            Visible = false;
        }
        modify("Put-away Unit of Measure Code")
        {
            Visible = false;
        }
        modify("Phys Invt Counting Period Code")
        {
            Visible = false;
        }
        moveafter(Description; "Base Unit of Measure")
        modify(Type)
        {
            Visible = false;
        }
        moveafter(Description; InventoryNonFoundation)
        modify("Qty. on Prod. Order")
        {
            Visible = false;
        }
        modify("Qty. on Component Lines")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Created From Nonstock Item")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Qty. on Service Order")
        {
            Visible = false;
        }
        modify("Qty. on Job Order")
        {
            Visible = false;
        }
        modify("Qty. on Assembly Order")
        {
            Visible = false;
        }
        modify("Qty. on Asm. Component")
        {
            Visible = false;
        }
        modify("Net Weight")
        {
            Visible = false;
        }
        modify("Gross Weight")
        {
            Visible = false;
        }
        modify("Costing Method")
        {
            Importance = Additional;
        }
        modify("Last Direct Cost")
        {
            Visible = false;
        }

        modify("Cost is Posted to G/L")
        {
            Visible = false;
        }
        // modify(SpecialPurchPricesAndDiscountsTxt)
        // {
        //     Visible = false;
        // }
        movefirst(InventoryGrp; "Lead Time Calculation")
    }

    actions
    {
        addafter("Va&riants")
        {
            action("Item Distributions")
            {
                ApplicationArea = all;
                Caption = 'Item Distributions';
                Image = DistributionGroup;
                RunObject = Page "Item Distributions";
                RunPageMode = View;
                RunPageLink = "Item No" = field("No.");
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        ItemDistributions: Record "Item Distributions";
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());

        if not userSetup."Admin User" then begin
            ItemDistributions.Reset();
            ItemDistributions.SetRange("Item No", Rec."No.");
            ItemDistributions.setrange("Vendor No", UserSetup."Vendor No.");
            if not ItemDistributions.FindFirst() then begin
                ItemDistributions.Reset();
                ItemDistributions.SetRange("Item No", Rec."No.");
                ItemDistributions.setrange("Sole Supplier", UserSetup."Sole Supplier");
                if not ItemDistributions.FindFirst() then
                    Error('You do not have permission to view this page');
            end;

            Rec.SetRange("Location Filter", UserSetup."location Code");

        end;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            CurrPage.Editable := false;
        end;
    end;

}
