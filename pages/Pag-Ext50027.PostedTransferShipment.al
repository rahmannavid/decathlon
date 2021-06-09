pageextension 50027 "Posted Transfer Shipment" extends "Posted Transfer Shipment"
{
    layout
    {
        addlast(Shipment)
        {
            field("Delay Reason"; Rec."Delay Reason")
            {
                Editable = false;
            }
        }
    }
}
