codeunit 50004 "Performance History Mgt."
{
    trigger OnRun()
    begin
        GeneratePerformanceHistoryData();
    end;


    local procedure GeneratePerformanceHistoryData()
    var
        TransShipHeader: Record "Transfer Shipment Header";
        TransShipLine: Record "Transfer Shipment Line";
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        POHeader: Record "Purchase Header";
        POLine: Record "Purchase Line";
        PerfHistoryHeader: Record "Performance History Header";
        PerfHistory: Record "Performance History";
        EntryNoHeader: Integer;
        EntryNo: Integer;
        item_rec: Record Item;
    begin
        if PerfHistory.FindLast() then
            EntryNo := PerfHistory."Entry No." + 1
        else
            EntryNo := 1;

        if PerfHistoryHeader.FindLast() then
            EntryNoHeader := PerfHistoryHeader."Entry No." + 1
        else
            EntryNoHeader := 1;


        TransHeader.Reset();
        TransHeader.SetFilter("Order Status", '<>%1', TransHeader."Order Status"::Closed);
        TransHeader.SetFilter("Accepted Date", '<>%1', 0D);
        if TransHeader.FindFirst() then
            repeat

                // POHeader.Reset();
                // POHeader.SetRange("Document Type", POHeader."Document Type"::Order);
                // POHeader.SetRange("No.", TransHeader."Purchase Order No.");
                // POHeader.FindFirst();

                item_rec.Get(TransHeader."Item No.");

                PerfHistoryHeader.Reset();
                PerfHistoryHeader.SetRange("Transfer Order No.", TransHeader."No.");
                if not PerfHistoryHeader.FindFirst() then begin
                    PerfHistoryHeader.Init();
                    PerfHistoryHeader."Entry No." := EntryNoHeader;
                    PerfHistoryHeader."Transfer Order No." := TransHeader."No.";
                    PerfHistoryHeader."Transfer Order Date" := TransHeader."Accepted Date";
                    //PerfHistoryHeader."Purchase Order No." := POHeader."No.";
                    PerfHistoryHeader."Purchase Order Date" := TransHeader."Accepted Date";
                    PerfHistoryHeader."Order type" := TransHeader."Order Type";
                    PerfHistoryHeader."Expected Date" := TransHeader."Promised Receipt Date";
                    PerfHistoryHeader."Requested Date" := TransHeader."Requested Receipt Date";
                    PerfHistoryHeader."Sole Location Code" := TransHeader."Transfer-from Code";
                    PerfHistoryHeader."FG Location Code" := TransHeader."Transfer-to Code";
                    PerfHistoryHeader.DSM := TransHeader."DSM Code";
                    PerfHistoryHeader.Process := item_rec.Process;
                    PerfHistoryHeader."Item No." := item_rec."No.";

                    TransHeader.CalcFields("Total Quantity", "Remaining Qty");
                    PerfHistoryHeader."Order Quantity" := TransHeader."Total Quantity";
                    PerfHistoryHeader."Remaining Qty" := TransHeader."Remaining Qty";

                    PerfHistoryHeader."Future Lead Time" := TransHeader."Promised Receipt Date" - TransHeader."Accepted Date";
                    if Today <= TransHeader."Promised Receipt Date" + 2 then
                        PerfHistoryHeader."Future Qty Ontime 3 Days" := PerfHistoryHeader."Remaining Qty";
                    if PerfHistoryHeader."Expected Date" <= PerfHistoryHeader."Requested Date" + 6 then
                        PerfHistoryHeader."Future Delivery Ontime" := PerfHistoryHeader."Remaining Qty";

                    PerfHistoryHeader.Insert();
                    EntryNoHeader += 1;
                end else begin
                    TransHeader.CalcFields("Total Quantity", "Remaining Qty");
                    PerfHistoryHeader."Order Quantity" := TransHeader."Total Quantity";
                    PerfHistoryHeader."Remaining Qty" := TransHeader."Remaining Qty";
                    if Today <= TransHeader."Promised Receipt Date" + 2 then
                        PerfHistoryHeader."Future Qty Ontime 3 Days" := PerfHistoryHeader."Remaining Qty";
                    if PerfHistoryHeader."Expected Date" <= PerfHistoryHeader."Requested Date" + 6 then
                        PerfHistoryHeader."Future Delivery Ontime" := PerfHistoryHeader."Remaining Qty";
                    PerfHistoryHeader.Modify();
                end;
            until TransHeader.Next() = 0;


        TransShipLine.Reset();
        TransShipLine.SetFilter("Performance Entry No.", '%1', 0);
        TransShipLine.SetFilter(Quantity, '<>%1', 0);
        if TransShipLine.FindFirst() then
            repeat
                TransShipHeader.Reset();
                TransShipHeader.SetRange("No.", TransShipLine."Document No.");
                TransShipHeader.FindFirst();

                TransHeader.Reset();
                TransHeader.SetRange("No.", TransShipLine."Transfer Order No.");
                TransHeader.FindFirst();

                TransLine.Reset();
                TransLine.SetRange("Document No.", TransShipLine."Transfer Order No.");
                TransLine.SetRange("Item No.", TransShipLine."Item No.");
                TransLine.SetRange("Shortcut Dimension 1 Code", TransShipLine."Shortcut Dimension 1 Code");
                TransLine.FindFirst();

                // POHeader.Reset();
                // POHeader.SetRange("Document Type", POHeader."Document Type"::Order);
                // POHeader.SetRange("No.", TransHeader."Purchase Order No.");
                // POHeader.FindFirst();

                // POLine.Reset();
                // POLine.SetRange("Document Type", POLine."Document Type"::Order);
                // POLine.SetRange("Document No.", POHeader."No.");
                // POLine.SetRange("No.", TransShipLine."Item No.");
                // POLine.SetRange("Shortcut Dimension 1 Code", TransLine."Shortcut Dimension 1 Code");
                // POLine.FindFirst();

                item_rec.Get(TransHeader."Item No.");

                PerfHistory.Init();
                PerfHistory."Entry No." := EntryNo;
                PerfHistory."Shipment No." := TransShipLine."Document No.";
                PerfHistory."Shipment Date" := TransShipHeader."Posting Date";
                PerfHistory."Transfer Order No." := TransHeader."No.";
                PerfHistory."Transfer Order Date" := TransHeader."Accepted Date";
                //PerfHistory."Purchase Order No." := POHeader."No.";
                PerfHistory."Purchase Order Date" := TransHeader."Accepted Date";
                PerfHistory."Order type" := TransHeader."Order Type";
                PerfHistory."Expected Date" := TransHeader."Promised Receipt Date";
                PerfHistory."Requested Date" := TransHeader."Requested Receipt Date";
                PerfHistory."Sole Location Code" := TransHeader."Transfer-from Code";
                PerfHistory."FG Location Code" := TransHeader."Transfer-to Code";
                PerfHistory.DSM := TransHeader."DSM Code";
                PerfHistory.Process := item_rec.Process;
                PerfHistory."Item No." := item_rec."No.";
                PerfHistory.Size := TransShipLine."Shortcut Dimension 1 Code";
                PerfHistory."Order Quantity" := POLine.Quantity;
                PerfHistory."Shipment Quantity" := TransShipLine.Quantity;
                PerfHistory."Lead Time" := TransShipHeader."Posting Date" - TransHeader."Accepted Date";
                if PerfHistory."Shipment Date" <= PerfHistory."Expected Date" then
                    PerfHistory."Qty Ontime" := PerfHistory."Shipment Quantity";
                if PerfHistory."Shipment Date" <= PerfHistory."Expected Date" + 2 then
                    PerfHistory."Qty Ontime 3 Days" := PerfHistory."Shipment Quantity";
                if PerfHistory."Shipment Date" <= PerfHistory."Expected Date" + 6 then
                    PerfHistory."Qty Ontime 7 Days" := PerfHistory."Shipment Quantity";
                if PerfHistory."Shipment Date" <= PerfHistory."Requested Date" + 6 then
                    PerfHistory."Delivery Ontime" := PerfHistory."Shipment Quantity";
                PerfHistory.Insert();

                TransShipLine."Performance Entry No." := EntryNo;
                TransShipLine.Modify();
                EntryNo += 1;
            until TransShipLine.Next() = 0;
    end;
}
