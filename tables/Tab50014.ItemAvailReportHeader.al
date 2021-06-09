table 50014 "Item Avail. Report Header"
{
    Caption = 'Item Availability Report Header';
    DataClassification = ToBeClassified;
    DataCaptionFields = "From Date", "To Date";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
        }
        field(2; "FG Location Filter"; Code[10])
        {
            Caption = 'FG Location Filter';
            TableRelation = Location;
        }
        field(9; "Sole Location Filter"; Code[10])
        {
            Caption = 'Sole Location Filter';
            TableRelation = Location;
        }
        field(3; "From Date"; Date)
        {
            Caption = 'From Date';

        }
        field(4; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(5; "Item Filter"; Code[20])
        {
            TableRelation = Item;
        }
        field(6; "Size Filter"; Code[20])
        {
            TableRelation = Size;
        }
        field(7; "Process Filter"; Code[20])
        {
            TableRelation = Process;
        }
        field(8; "Report Level"; Option)
        {
            OptionMembers = DSM,Process,Item,,Size,"FG Supplier","Sole Supplier";
        }
        field(10; "DSM Filter"; Code[20])
        {
            TableRelation = "DSM (Super Model)";
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }


    procedure CalcGrossRequirement(WeekDay: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        OrderPlanningHistory: Record "Order Planning History";
        SupplierRec: Record Vendor;
    begin

        TotalQuantity := 0;
        OrderPlanningHistory.Reset();

        if WeekDay <> 0D then
            OrderPlanningHistory.SetRange("Week Date", WeekDay, (CALCDATE('1W', WeekDay) - 1))
        else
            OrderPlanningHistory.SetRange("Week Date", "From Date", "To Date");

        if "Item Filter" <> '' then
            OrderPlanningHistory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            OrderPlanningHistory.SetRange("FG Location No", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            OrderPlanningHistory.SetRange("Sole Location No", "Sole Location Filter");
        if "Size Filter" <> '' then
            OrderPlanningHistory.SetRange("Size No.", "Size Filter");
        if "Process Filter" <> '' then
            OrderPlanningHistory.SetRange("Process No.", "Process Filter");
        if "DSM Filter" <> '' then
            OrderPlanningHistory.SetRange("DSM No.", "DSM Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                OrderPlanningHistory.SetRange("DSM No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                OrderPlanningHistory.SetRange("Process No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                OrderPlanningHistory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Size then
                OrderPlanningHistory.SetRange("Size No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("FG Location No", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("Sole Location No", SupplierRec."Location Code");
            end;
        end;

        if OrderPlanningHistory.FindFirst() then
            repeat
                TotalQuantity += OrderPlanningHistory."Need Quantity";
            until (OrderPlanningHistory.Next() = 0);

        exit(TotalQuantity);
    end;

    procedure CalcPlannedOrder(WeekDay: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        OrderPlanningHistory: Record "Order Planning History";
        SupplierRec: Record Vendor;
    begin

        TotalQuantity := 0;
        OrderPlanningHistory.Reset();

        if WeekDay <> 0D then
            OrderPlanningHistory.SetRange("Week Date", WeekDay, (CALCDATE('1W', WeekDay) - 1))
        else
            OrderPlanningHistory.SetRange("Week Date", "From Date", "To Date");

        if "Item Filter" <> '' then
            OrderPlanningHistory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            OrderPlanningHistory.SetRange("FG Location No", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            OrderPlanningHistory.SetRange("Sole Location No", "Sole Location Filter");
        if "Size Filter" <> '' then
            OrderPlanningHistory.SetRange("Size No.", "Size Filter");
        if "Process Filter" <> '' then
            OrderPlanningHistory.SetRange("Process No.", "Process Filter");
        if "DSM Filter" <> '' then
            OrderPlanningHistory.SetRange("DSM No.", "DSM Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                OrderPlanningHistory.SetRange("DSM No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                OrderPlanningHistory.SetRange("Process No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                OrderPlanningHistory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Size then
                OrderPlanningHistory.SetRange("Size No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("FG Location No", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("Sole Location No", SupplierRec."Location Code");
            end;
        end;

        if OrderPlanningHistory.FindFirst() then
            repeat
                TotalQuantity += OrderPlanningHistory."Planned Quantity";
            until (OrderPlanningHistory.Next() = 0);

        exit(TotalQuantity);
    end;

    procedure CalcFirmedOrder(WeekDay: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        POHeader: Record "Transfer Header";
        POLine: Record "Purchase Line";
        SupplierRec: Record Vendor;
    begin
        TotalQuantity := 0;
        POHeader.Reset();

        if WeekDay <> 0D then
            POHeader.SetRange("Document Date", WeekDay, (CALCDATE('1W', WeekDay) - 1))
        else
            POHeader.SetRange("Document Date", "From Date", "To Date");

        POHeader.SetFilter("Order Status", '<>%1&<>%2&<>%3',
                                POHeader."Order Status"::"Released",
                                POHeader."Order Status"::Open,
                                POHeader."Order Status"::"Rejected");

        if "Item Filter" <> '' then
            POHeader.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then begin
            SupplierRec.SetRange("Location Code", "FG Location Filter");
            // if SupplierRec.FindFirst() then
            //     POHeader.SetRange("Buy-from Vendor No.", SupplierRec."No.")
            // else
            //     POHeader.SetRange("Buy-from Vendor No.", '');
        end;
        if "Sole Location Filter" <> '' then begin
            SupplierRec.SetRange("Location Code", "Sole Location Filter");
            // if SupplierRec.FindFirst() then
            //     POHeader.SetRange("Buy-from Vendor No.", SupplierRec."No.")
            // else
            //     POHeader.SetRange("Buy-from Vendor No.", '');
        end;
        if "DSM Filter" <> '' then
            POHeader.SetRange(POHeader."DSM Code", "DSM Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                POHeader.SetRange("DSM Code", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                POHeader.SetRange("FG Supplier No.", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                //POHeader.SetRange("Buy-from Vendor No.", SupplierRec."Location Code");
            end;
        end;

        if POHeader.FindFirst() then
            repeat
                POLine.Reset();
                //POLine.SetRange("Document Type", POHeader."Document Type");
                POLine.SetRange("Document No.", POHeader."No.");

                if "Size Filter" <> '' then
                    POLine.SetRange("Shortcut Dimension 1 Code", "Size Filter");
                if "Process Filter" <> '' then
                    POLine.SetRange("Process No.", "Process Filter");

                if ReportLevelCode <> '' then begin
                    if "Report Level" = "Report Level"::Process then
                        POLine.SetRange("Process No.", ReportLevelCode);
                    if "Report Level" = "Report Level"::Item then
                        POLine.SetRange("No.", ReportLevelCode);
                    if "Report Level" = "Report Level"::Size then
                        POLine.SetRange("Shortcut Dimension 1 Code", ReportLevelCode);
                end;

                if POLine.FindFirst() then
                    repeat
                        TotalQuantity += POLine.Quantity;
                    until POLine.Next() = 0;
            until POHeader.Next() = 0;

        exit(TotalQuantity);
    end;


    procedure CalcShceduledOrder(WeekDay: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        OrderPlanningHistory: Record "Order Planning History";
        SupplierRec: Record Vendor;
    begin
        TotalQuantity := 0;
        TotalQuantity := 0;
        OrderPlanningHistory.Reset();

        if WeekDay <> 0D then
            OrderPlanningHistory.SetRange("Week Date", WeekDay, (CALCDATE('1W', WeekDay) - 1))
        else
            OrderPlanningHistory.SetRange("Week Date", "From Date", "To Date");

        if "Item Filter" <> '' then
            OrderPlanningHistory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            OrderPlanningHistory.SetRange("FG Location No", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            OrderPlanningHistory.SetRange("Sole Location No", "Sole Location Filter");
        if "Size Filter" <> '' then
            OrderPlanningHistory.SetRange("Size No.", "Size Filter");
        if "Process Filter" <> '' then
            OrderPlanningHistory.SetRange("Process No.", "Process Filter");
        if "DSM Filter" <> '' then
            OrderPlanningHistory.SetRange("DSM No.", "DSM Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                OrderPlanningHistory.SetRange("DSM No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                OrderPlanningHistory.SetRange("Process No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                OrderPlanningHistory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::Size then
                OrderPlanningHistory.SetRange("Size No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("FG Location No", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                OrderPlanningHistory.SetRange("Sole Location No", SupplierRec."Location Code");
            end;
        end;


        if OrderPlanningHistory.FindFirst() then
            repeat
                TotalQuantity += OrderPlanningHistory."Firmed Quantity";
            until (OrderPlanningHistory.Next() = 0);

        exit(TotalQuantity);
    end;

    // procedure CalcProjectedAvailableBalance(WeekDay: Date) TotalQuantity: Decimal
    // var
    //     POHeader: Record "Purchase Header";
    //     POLine: Record "Purchase Line";
    // begin
    //     TotalQuantity := 0;
    //     POHeader.Reset();

    //     if WeekDay <> 0D then
    //         POHeader.SetRange("Order Date", WeekDay, (CALCDATE('1W', WeekDay)-1))
    //     else
    //         POHeader.SetRange("Order Date", "From Date", "To Date");

    //     if POHeader.FindFirst() then
    //         repeat
    //             POLine.Reset();
    //             if "Item Filter" <> '' then
    //                 POLine.SetRange("No.", "Item Filter");
    //             // if "FG Location Filter" <> '' then
    //             //     POLine.SetRange("FG Location No", "FG Location Filter");
    //             // if "Sole Location Filter" <> '' then
    //             //     POLine.SetRange("Sole Location No", "Sole Location Filter");
    //             if "Size Filter" <> '' then
    //                 POLine.SetRange("Shortcut Dimension 1 Code", "Size Filter");
    //             if "Process Filter" <> '' then
    //                 POLine.SetRange("Process No.", "Process Filter");

    //             if POLine.FindFirst() then
    //                 repeat
    //                     TotalQuantity += POLine.Quantity;
    //                 until POLine.Next() = 0;
    //         until POHeader.Next() = 0;

    //     //exit(TotalQuantity - CalcGrossRequirement(WeekDay));
    // end;

    procedure CalcItemInventory() TotalQuantity: Decimal
    var
        ItemLedEntry: Record "Item Ledger Entry";
    begin
        TotalQuantity := 0;
        ItemLedEntry.Reset();

        ItemLedEntry.SetRange("Posting Date", "From Date", "To Date");

        if "Item Filter" <> '' then
            ItemLedEntry.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            ItemLedEntry.SetRange("Location Code", "FG Location Filter");
        if "Size Filter" <> '' then
            ItemLedEntry.SetRange("Global Dimension 1 Code", "Size Filter");
        if "Process Filter" <> '' then
            ItemLedEntry.SetRange("Process No.", "Process Filter");

        if ItemLedEntry.FindFirst() then
            repeat
                TotalQuantity += ItemLedEntry.Quantity;
            until ItemLedEntry.Next() = 0;

        exit(TotalQuantity);
    end;
}
