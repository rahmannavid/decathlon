codeunit 50001 "Transfer Order Mod. Post"
{
    var
        Text000: Label '&Ship,&Receive';
        Text001: Label '&Ship';
        Text002: Label '&Receive';



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post (Yes/No)", 'OnBeforePost', '', true, true)]
    procedure ConditionalPosting(var TransHeader: Record "Transfer Header"; var IsHandled: Boolean)
    var
        TransLine: Record "Transfer Line";
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        DefaultNumber: Integer;
        Selection: Option " ",Shipment,Receipt;
        UserSetup: Record "User Setup";
    begin
        UserSetup.get(UserId);

        IsHandled := true;

        TransLine.SetRange("Document No.", TransHeader."No.");
        if TransLine.Find('-') then
            repeat
                if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                   (DefaultNumber = 0)
                then
                    DefaultNumber := 1;
                if (TransLine."Quantity Received" < TransLine.Quantity) and
                   (DefaultNumber = 0)
                then
                    DefaultNumber := 2;
            until (TransLine.Next = 0) or (DefaultNumber > 0);
        if TransHeader."Direct Transfer" then begin
            TransferPostShipment.Run(TransHeader);
            TransferPostReceipt.Run(TransHeader);
        end else begin
            if DefaultNumber = 0 then
                DefaultNumber := 1;

            if UserSetup."Admin User" then
                Selection := StrMenu(Text000, DefaultNumber)
            else
                if UserSetup."Sole Supplier" <> '' then begin
                    Selection := StrMenu(Text001, 1);
                    Selection := Selection::Shipment;
                end
                else
                    if UserSetup."Vendor No." <> '' then begin
                        Selection := StrMenu(Text002, 1);
                        Selection := Selection::Receipt;
                    end;

            case Selection of
                0:
                    exit;
                Selection::Shipment:
                    TransferPostShipment.Run(TransHeader);
                Selection::Receipt:
                    TransferPostReceipt.Run(TransHeader);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Receipt", 'OnBeforeDeleteOneTransferHeader', '', true, true)]
    procedure TOPostReceiptOnBeforeDeleteOneTransferHeader(TransferHeader: Record "Transfer Header"; var DeleteOne: Boolean)
    var
    begin
        TransferHeader."Receipt Date" := Today;
        TransferHeader.Modify();
        DeleteOne := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnBeforeDeleteOneTransferOrder', '', true, true)]
    procedure TOPostShipmentOnBeforeDeleteOneTransferHeader(TransferHeader: Record "Transfer Header"; var DeleteOne: Boolean)
    var
    begin
        TransferHeader."Shipment Date" := Today;
        TransferHeader.Modify();
        DeleteOne := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"TransferOrder-Post Shipment", 'OnAfterInsertTransShptHeader', '', true, true)]
    local procedure OnAfterInsertTransShptHeader(var TransferHeader: Record "Transfer Header"; var TransferShipmentHeader: Record "Transfer Shipment Header")
    begin
        TransferShipmentHeader."Delay Reason" := TransferHeader."Delay Reason";
        TransferShipmentHeader.Modify();
    end;

}
