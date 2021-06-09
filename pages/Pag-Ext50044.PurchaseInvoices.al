pageextension 50044 "Purchase Invoices" extends "Purchase Invoices"
{
    layout
    {
        addafter("Location Code")
        {
            field("Order Status"; Rec."Order Status")
            { }
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
    }

    actions
    {
        modify(PostSelected)
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(PostBatch)
        {
            Visible = false;
        }
    }
}
