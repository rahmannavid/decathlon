table 50018 "Performance Report Header"
{
    Caption = 'Performance Report Header';
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
        field(6; "Order Filter"; Code[20])
        {
            TableRelation = "Transfer Header";
        }
        field(7; "Process Filter"; Code[20])
        {
            TableRelation = Process;
        }
        field(8; "Report Level"; Option)
        {
            OptionMembers = DSM,Process,Item,"FG Supplier","Sole Supplier","Orders";
        }
        field(10; "DSM Filter"; Code[20])
        {
            TableRelation = "DSM (Super Model)";
        }
        field(11; "Order type"; Option)
        {
            OptionMembers = "All","Manual","Auto";
        }
        field(12; "DOT Calc. Days"; Option)
        {
            OptionMembers = "0 Days","+3 Days","+7 Days";
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure CalcOrderQty(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        PerformHisory: Record "Performance History Header";
        SupplierRec: Record Vendor;
    begin
        TotalQuantity := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                TotalQuantity += PerformHisory."Order Quantity";
            until (PerformHisory.Next() = 0);

        exit(TotalQuantity);

    end;

    procedure CalcShipmentQty(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]) TotalQuantity: Decimal
    var
        PerformHisory: Record "Performance History";
        SupplierRec: Record Vendor;
    begin
        TotalQuantity := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                TotalQuantity += PerformHisory."Shipment Quantity";
            until (PerformHisory.Next() = 0);

        exit(TotalQuantity);

    end;

    procedure CalcLeadTime(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; TotalShipment: Decimal; var PerformanceReportLines: Record "Performance Report Lines") LTA: Decimal
    var
        PerformHisory: Record "Performance History";
        SupplierRec: Record Vendor;
        ShipLead: Decimal;
        TotalShipLead: Decimal;
    begin
        LTA := 0;
        TotalShipLead := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                ShipLead := PerformHisory."Shipment Quantity" * PerformHisory."Lead Time";
                TotalShipLead += ShipLead;
            until (PerformHisory.Next() = 0);

        PerformanceReportLines.TotalShipLead := TotalShipLead;
        if TotalShipment > 0 then
            LTA := TotalShipLead / TotalShipment;
        exit(LTA);
    end;

    procedure CalcFutureLeadTime(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; TotalOrder: Decimal; var PerformanceReportLines: Record "Performance Report Lines") LTA: Decimal
    var
        PerformHisory: Record "Performance History Header";
        SupplierRec: Record Vendor;
        RemLead: Decimal;
        TotalRemLead: Decimal;
        TotalRemQty: Decimal;
    begin
        LTA := 0;
        TotalRemLead := 0;
        TotalRemQty := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                RemLead := PerformHisory."Future Lead Time" * PerformHisory."Remaining Qty";
                TotalRemLead += RemLead;
                TotalRemQty += PerformHisory."Remaining Qty";
            until (PerformHisory.Next() = 0);

        PerformanceReportLines.TotalRemLead := TotalRemLead;
        PerformanceReportLines.TotalRemQty := TotalRemQty;
        if TotalOrder > 0 then
            LTA := TotalRemLead / TotalRemQty;
        exit(LTA);
    end;

    procedure CalcHOT(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; DayOption: Integer; var PerformanceReportLines: Record "Performance Report Lines") DOT: Decimal
    var
        PerformHisory: Record "Performance History";
        SupplierRec: Record Vendor;
        TotalShipQty: Decimal;
    begin
        TotalShipQty := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                if PerformHisory."Qty Ontime" > 0 then
                    PerformanceReportLines."Qty Ontime" += PerformHisory."Qty Ontime"
                else
                    PerformanceReportLines."Delayed Quantity" += PerformHisory."Shipment Quantity";

                if PerformHisory."Qty Ontime 3 Days" > 0 then
                    PerformanceReportLines."Qty Ontime 3 Days" += PerformHisory."Qty Ontime 3 Days"
                else
                    PerformanceReportLines."Delayed Quantity 3 Days" += PerformHisory."Shipment Quantity";

                if PerformHisory."Qty Ontime 7 Days" > 0 then
                    PerformanceReportLines."Qty Ontime 7 Days" += PerformHisory."Qty Ontime 7 Days"
                else
                    PerformanceReportLines."Delayed Quantity 7 Days" += PerformHisory."Shipment Quantity";
            until (PerformHisory.Next() = 0);


        if PerformanceReportLines."Shipment Quantity" > 0 then
            if DayOption = 0 then
                DOT := PerformanceReportLines."Qty Ontime" / PerformanceReportLines."Shipment Quantity"
            else
                if DayOption = 3 then
                    DOT := PerformanceReportLines."Qty Ontime 3 Days" / PerformanceReportLines."Shipment Quantity"
                else
                    if DayOption = 7 then
                        DOT := PerformanceReportLines."Qty Ontime 7 Days" / PerformanceReportLines."Shipment Quantity";
        exit(DOT * 100);
    end;

    procedure CalcFutureHOT(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; var PerformanceReportLines: Record "Performance Report Lines") DOT: Decimal
    var
        PerformHisory: Record "Performance History Header";
        SupplierRec: Record Vendor;
        TotalShipQty: Decimal;
    begin
        TotalShipQty := 0;
        PerformanceReportLines.TotalRemQty := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                if PerformHisory."Future Qty Ontime 3 Days" > 0 then
                    PerformanceReportLines."Future Qty Ontime 3 Days" += PerformHisory."Future Qty Ontime 3 Days"
                else
                    PerformanceReportLines."Future Delayed Qty 3 Days" += PerformHisory."Remaining Qty";
                PerformanceReportLines.TotalRemQty += PerformHisory."Remaining Qty";
            until (PerformHisory.Next() = 0);
        if PerformanceReportLines.TotalRemQty > 0 then
            DOT := PerformanceReportLines."Future Qty Ontime 3 Days" / PerformanceReportLines.TotalRemQty;

        exit(DOT * 100);
    end;

    procedure CalcDOT(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; DayOption: Integer; var PerformanceReportLines: Record "Performance Report Lines") DOT: Decimal
    var
        PerformHisory: Record "Performance History";
        SupplierRec: Record Vendor;
        TotalShipQty: Decimal;
    begin
        TotalShipQty := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                PerformanceReportLines."Delivery Ontime" += PerformHisory."Delivery Ontime";
            until (PerformHisory.Next() = 0);

        if PerformanceReportLines."Shipment Quantity" > 0 then
            DOT := PerformanceReportLines."Delivery Ontime" / PerformanceReportLines."Shipment Quantity";

        exit(DOT * 100);
    end;

    procedure CalcFutureDOT(FromDate: Date; ToDate: Date; ReportLevelCode: Code[20]; var PerformanceReportLines: Record "Performance Report Lines") DOT: Decimal
    var
        PerformHisory: Record "Performance History Header";
        SupplierRec: Record Vendor;
        TotalShipQty: Decimal;
    begin
        TotalShipQty := 0;
        PerformanceReportLines.TotalRemQty := 0;

        PerformHisory.SetRange("Requested Date", FromDate, ToDate);

        if "Item Filter" <> '' then
            PerformHisory.SetRange("Item No.", "Item Filter");
        if "FG Location Filter" <> '' then
            PerformHisory.SetRange("FG Location Code", "FG Location Filter");
        if "Sole Location Filter" <> '' then
            PerformHisory.SetRange("Sole Location Code", "Sole Location Filter");
        if "Process Filter" <> '' then
            PerformHisory.SetRange("Process", "Process Filter");
        if "DSM Filter" <> '' then
            PerformHisory.SetRange("DSM", "DSM Filter");
        if "Order Filter" <> '' then
            PerformHisory.SetRange("Transfer Order No.", "Order Filter");

        if ReportLevelCode <> '' then begin
            if "Report Level" = "Report Level"::DSM then
                PerformHisory.SetRange("DSM", ReportLevelCode);
            if "Report Level" = "Report Level"::Process then
                PerformHisory.SetRange("Process", ReportLevelCode);
            if "Report Level" = "Report Level"::Item then
                PerformHisory.SetRange("Item No.", ReportLevelCode);
            if "Report Level" = "Report Level"::"FG Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("FG Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::"Sole Supplier" then begin
                SupplierRec.Get(ReportLevelCode);
                PerformHisory.SetRange("Sole Location Code", SupplierRec."Location Code");
            end;
            if "Report Level" = "Report Level"::Orders then
                PerformHisory.SetRange("Transfer Order No.", ReportLevelCode);
        end;

        if PerformHisory.FindFirst() then
            repeat
                PerformanceReportLines."Future Delivery Ontime" += PerformHisory."Future Delivery Ontime";
                PerformanceReportLines.TotalRemQty += PerformHisory."Remaining Qty";
            until (PerformHisory.Next() = 0);

        if PerformanceReportLines.TotalRemQty > 0 then
            DOT := PerformanceReportLines."Future Delivery Ontime" / PerformanceReportLines.TotalRemQty;

        exit(DOT * 100);
    end;

}
