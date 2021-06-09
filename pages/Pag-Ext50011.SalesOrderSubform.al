pageextension 50011 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Line Amount")
        {
            Visible = false;
        }
        moveafter("Unit of Measure Code"; "Location Code")
        modify("Qty. to Ship")
        {
            Visible = false;
        }
        modify("Quantity Shipped")
        {
            Visible = false;
        }
        modify("Qty. to Invoice")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Quantity Invoiced")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Planned Delivery Date")
        {
            Visible = false;
        }
        modify("Planned Shipment Date")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Variant Code1"; Rec."Variant Code")
            {

            }
        }

    }
}
