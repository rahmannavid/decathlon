pageextension 50046 "Source Documents" extends "Source Documents"
{

    layout
    {
        addafter("External Document No.")
        {
            field("Prev. Chalan Nos"; ChalanNos)
            {

            }
            field("Item Name"; ItemName)
            { }

        }
    }

    // actions
    // {
    //     addafter("&Line")
    //     {
    //         action("Show Chalan Nos")
    //         {
    //             Image = ViewDetails;
    //             trigger OnAction()
    //             var
    //                 TransShipHeader: Record "Transfer Shipment Header";
    //                 PrevCalan: Text;
    //             begin
    //                 TransShipHeader.Reset();
    //                 TransShipHeader.SetRange("Transfer Order No.", Rec."Source No.");
    //                 if TransShipHeader.FindFirst() then
    //                     repeat
    //                         if PrevCalan = '' then
    //                             PrevCalan += TransShipHeader."External Document No."
    //                         else
    //                             PrevCalan += ',' + TransShipHeader."External Document No.";
    //                     until TransShipHeader.Next() = 0;

    //                 if PrevCalan <> '' then
    //                     Message(PrevCalan)
    //                 else
    //                     Message('No previous chalan no found.');
    //             end;
    //         }
    //     }
    // }

    var
        ChalanNos: Text;
        ItemName: Text;

    trigger OnAfterGetRecord()
    var
        TransShipHeader: Record "Transfer Shipment Header";
        TransferHeader: Record "Transfer Header";
        Item: Record Item;
    begin
        ChalanNos := '';
        TransShipHeader.Reset();
        TransShipHeader.SetRange("Transfer Order No.", Rec."Source No.");
        if TransShipHeader.FindFirst() then
            repeat
                if Rec."External Document No." <> TransShipHeader."External Document No." then
                    if ChalanNos = '' then
                        ChalanNos += TransShipHeader."External Document No."
                    else
                        ChalanNos += ',' + TransShipHeader."External Document No.";
            until TransShipHeader.Next() = 0;

        if TransferHeader.Get(Rec."Source No.") then
            ItemName := TransferHeader."Item Name";
    end;
}
