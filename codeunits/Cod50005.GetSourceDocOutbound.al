codeunit 50005 "Get Source Doc. Outbound Ext"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Outbound", 'OnAfterGetSingleOutboundDoc', '', true, true)]
    local procedure OnAfterGetSingleOutboundDoc(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
        TOHeader: Record "Transfer Header";
    begin
        WarehouseShipmentLine.SetRange("No.", WarehouseShipmentHeader."No.");
        if WarehouseShipmentLine.FindFirst() then begin
            TOHeader.SetRange("No.", WarehouseShipmentLine."Source No.");
            if TOHeader.FindFirst() then begin
                WarehouseShipmentHeader."Requested Receipt Date" := TOHeader."Requested Receipt Date";
                WarehouseShipmentHeader."Promised Receipt Date" := TOHeader."Promised Receipt Date";
                WarehouseShipmentHeader.Modify();
                repeat
                    WarehouseShipmentLine.Validate("Item No.");
                    WarehouseShipmentLine.Modify();
                until WarehouseShipmentLine.Next() = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Get Source Doc. Inbound", 'OnAfterGetSingleInboundDoc', '', true, true)]
    local procedure OnAfterGetSingleInboundDoc(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        TOHeader: Record "Transfer Header";
    begin
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindFirst() then begin
            TOHeader.SetRange("No.", WarehouseReceiptLine."Source No.");
            if TOHeader.FindFirst() then begin
                WarehouseReceiptHeader."Requested Receipt Date" := TOHeader."Requested Receipt Date";
                WarehouseReceiptHeader."Promised Receipt Date" := TOHeader."Promised Receipt Date";
                WarehouseReceiptHeader.Modify();
                repeat
                    WarehouseReceiptLine.Validate("Item No.");
                    WarehouseReceiptLine.Modify();
                until WarehouseReceiptLine.Next() = 0;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnBeforePostedWhseShptHeaderInsert', '', true, true)]
    local procedure OnBeforePostedWhseShptHeaderInsert(var PostedWhseShipmentHeader: Record "Posted Whse. Shipment Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        PostedWhseShipmentHeader."Delay Reason" := WarehouseShipmentHeader."Delay Reason";
        PostedWhseShipmentHeader."Promised Receipt Date" := WarehouseShipmentHeader."Promised Receipt Date";
        PostedWhseShipmentHeader."Requested Receipt Date" := WarehouseShipmentHeader."Requested Receipt Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnCreatePostedShptLineOnBeforePostedWhseShptLineInsert', '', true, true)]
    local procedure OnCreatePostedShptLineOnBeforePostedWhseShptLineInsert(var PostedWhseShptLine: Record "Posted Whse. Shipment Line"; WhseShptLine: Record "Warehouse Shipment Line")
    begin
        PostedWhseShptLine."Process No." := WhseShptLine."Process No.";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostedWhseRcptHeaderInsert', '', true, true)]
    local procedure OnBeforePostedWhseRcptHeaderInsert(var PostedWhseReceiptHeader: Record "Posted Whse. Receipt Header"; WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    begin
        PostedWhseReceiptHeader."Promised Receipt Date" := WarehouseReceiptHeader."Promised Receipt Date";
        PostedWhseReceiptHeader."Requested Receipt Date" := WarehouseReceiptHeader."Requested Receipt Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnBeforePostedWhseRcptLineInsert', '', true, true)]
    local procedure OnBeforePostedWhseRcptLineInsert(var PostedWhseReceiptLine: Record "Posted Whse. Receipt Line"; WarehouseReceiptLine: Record "Warehouse Receipt Line")
    begin
        PostedWhseReceiptLine."Process No." := WarehouseReceiptLine."Process No.";
    end;

}
