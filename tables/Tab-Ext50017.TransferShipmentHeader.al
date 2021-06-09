tableextension 50017 "Transfer Shipment Header" extends "Transfer Shipment Header"
{
    fields
    {
        field(50019; "Delay Reason"; Text[100])
        {
            TableRelation = "Delay Reasons";
            ValidateTableRelation = true;
        }

        field(50000; "Warehouse Receipt No."; Code[20])
        {

        }

    }

}
