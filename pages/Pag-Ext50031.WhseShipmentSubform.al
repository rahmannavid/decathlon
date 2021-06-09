pageextension 50031 "Whse. Shipment Subform" extends "Whse. Shipment Subform"
{
    layout
    {
        addafter(Description)
        {

        }
        modify("Variant Code")
        {
            Visible = true;
            ApplicationArea = all;
        }
        modify("Qty. per Unit of Measure")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        moveafter(Description; "Variant Code")
    }
}

