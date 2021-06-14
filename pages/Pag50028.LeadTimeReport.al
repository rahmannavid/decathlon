page 50028 "Lead Time Report"
{

    Caption = 'Lead Time Report';
    PageType = Card;
    SourceTable = "Performance Report Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."To Date" > Rec."From Date" then
                            ReportGenaration();
                    end;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."To Date" > Rec."From Date" then
                            ReportGenaration();
                    end;

                }
                field("DSM Filter"; Rec."DSM Filter")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Process Filter"; Rec."Process Filter")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Item Filter"; Rec."Item Filter")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("FG Location Filter"; Rec."FG Location Filter")
                {
                    ApplicationArea = All;
                    Editable = FGEditable;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Sole Location Filter"; Rec."Sole Location Filter")
                {
                    ApplicationArea = All;
                    Editable = SoleEditable;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Order type"; Rec."Order type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Order Filter"; Rec."Order Filter")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Report Level"; Rec."Report Level")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
            }

            part("Lead Time Report Line"; "Lead Time Report Line")
            {
                Caption = 'Lines';
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update History Data")
            {
                Image = History;
                trigger OnAction()
                var
                    PerformanceHistoryMgt: Codeunit "Performance History Mgt.";
                begin
                    if Confirm('Do you want to run the process?') then begin
                        PerformanceHistoryMgt.Run();
                        Message('History data updated successfully.');
                    end;

                end;
            }
            action(Refresh)
            {
                Image = Refresh;
                trigger OnAction()
                begin
                    ReportGenaration();
                end;
            }
        }
    }

    var
        FGEditable: Boolean;
        SoleEditable: Boolean;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        PerformanceReportLines: Record "Performance Report Lines";
        locationVar: Record Location;
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec."From Date" := DMY2Date(1, 1, Date2DMY(Today, 3));
            Rec."To Date" := Today;
            Rec.Insert;
        end;
        UserSetup.Get(UserId);
        if not UserSetup."Admin User" then begin
            if UserSetup."Vendor No." <> '' then begin
                if locationVar.Get(UserSetup."location Code") then
                    Rec."FG Location Filter" := UserSetup."location Code";
                Rec.Modify();
                FGEditable := false;
                SoleEditable := true;
            end else
                if UserSetup."Sole Supplier" <> '' then begin
                    if locationVar.Get(UserSetup."location Code") then
                        Rec."Sole Location Filter" := UserSetup."location Code";
                    Rec.Modify();
                    FGEditable := true;
                    SoleEditable := false;
                end;
        end else begin
            FGEditable := true;
            SoleEditable := true;
        end;
        PerformanceReportLines.DeleteAll();
    end;



    procedure ReportGenaration()
    var
        lineNo: Integer;
        LineStartDate: Date;
        LineEndDate: Date;
        FirstWeekDate: Date;
        LastWeekDate: Date;
        PerformanceReportLines: Record "Performance Report Lines";

        DSM: Record "DSM (Super Model)";
        Process_Rec: Record Process;
        Item_Rec: Record Item;
        Size_Rec: Record Size;
        Supplier: Record Vendor;
        TransHeader: Record "Transfer Header";

    begin
        if (Rec."From Date" = 0D) OR (Rec."To Date" = 0D) OR (Rec."From Date" > Rec."To Date") then
            Error('Invalid Date');

        FirstWeekDate := CALCDATE('<CW>', Rec."From Date");
        LastWeekDate := CALCDATE('<CW>', Rec."To Date");

        LineStartDate := FirstWeekDate;
        lineNo := 1;
        PerformanceReportLines.DeleteAll();
        repeat
            LineEndDate := (CALCDATE('1W', LineStartDate) - 1);

            PerformanceReportLines.Init();
            PerformanceReportLines."Entry No." := lineNo;
            PerformanceReportLines.Indentation := 0;
            PerformanceReportLines."Period Start" := LineStartDate;
            PerformanceReportLines."Period End" := LineEndDate;
            PerformanceReportLines."Report Level" := 'Total';
            PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, '');
            PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, '');
            PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, '',
                                                                    PerformanceReportLines."Shipment Quantity",
                                                                    PerformanceReportLines);
            PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, '',
                                                                PerformanceReportLines."Order Quantity",
                                                                PerformanceReportLines);
            if PerformanceReportLines."Order Quantity" > 0 then
                PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                    / PerformanceReportLines."Order Quantity";

            if PerformanceReportLines."Order Quantity" > 0 then
                PerformanceReportLines.Insert();

            lineNo += 1;

            if (Rec."Report Level" = Rec."Report Level"::DSM) then begin
                if Rec."DSM Filter" <> '' then
                    DSM.SetRange("DSM Code", Rec."DSM Filter");
                DSM.FindFirst();
                repeat
                    PerformanceReportLines.Init();
                    PerformanceReportLines."Entry No." := lineNo;
                    PerformanceReportLines.Indentation := 1;
                    PerformanceReportLines."Period Start" := LineStartDate;
                    PerformanceReportLines."Period End" := LineEndDate;
                    PerformanceReportLines."Report Level" := DSM."DSM Code";
                    PerformanceReportLines."Report Level Desc." := DSM."DSM Name";
                    PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                    PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                    PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                            PerformanceReportLines."Shipment Quantity",
                                                                            PerformanceReportLines);
                    PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                        PerformanceReportLines."Order Quantity",
                                                                        PerformanceReportLines);
                    if PerformanceReportLines."Order Quantity" > 0 then
                        PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                            / PerformanceReportLines."Order Quantity";

                    if PerformanceReportLines."Order Quantity" > 0 then
                        PerformanceReportLines.Insert();

                    lineNo += 1;
                until DSM.Next() = 0;
            end else
                if (Rec."Report Level" = Rec."Report Level"::Process) then begin
                    if Rec."Process Filter" <> '' then
                        Process_Rec.SetRange("Process Code", Rec."Process Filter");
                    Process_Rec.FindFirst();
                    repeat
                        PerformanceReportLines.Init();
                        PerformanceReportLines."Entry No." := lineNo;
                        PerformanceReportLines.Indentation := 1;
                        PerformanceReportLines."Period Start" := LineStartDate;
                        PerformanceReportLines."Period End" := LineEndDate;
                        PerformanceReportLines."Report Level" := Process_Rec."Process Code";
                        PerformanceReportLines."Report Level Desc." := Process_Rec."Process Name";
                        PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                        PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                        PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                PerformanceReportLines."Shipment Quantity",
                                                                                PerformanceReportLines);
                        PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                            PerformanceReportLines."Order Quantity",
                                                                            PerformanceReportLines);
                        if PerformanceReportLines."Order Quantity" > 0 then
                            PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                                / PerformanceReportLines."Order Quantity";

                        if PerformanceReportLines."Order Quantity" > 0 then
                            PerformanceReportLines.Insert();

                        lineNo += 1;
                    until Process_Rec.Next() = 0;
                end else
                    if (Rec."Report Level" = Rec."Report Level"::Item) then begin
                        if Rec."Item Filter" <> '' then
                            Item_Rec.SetRange("No.", Rec."Item Filter");
                        Item_Rec.FindFirst();
                        repeat
                            PerformanceReportLines.Init();
                            PerformanceReportLines."Entry No." := lineNo;
                            PerformanceReportLines.Indentation := 1;
                            PerformanceReportLines."Period Start" := LineStartDate;
                            PerformanceReportLines."Period End" := LineEndDate;
                            PerformanceReportLines."Report Level" := Item_Rec."No.";
                            PerformanceReportLines."Report Level Desc." := Item_Rec.Description;
                            PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                            PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                            PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                    PerformanceReportLines."Shipment Quantity",
                                                                                    PerformanceReportLines);
                            PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                PerformanceReportLines."Order Quantity",
                                                                                PerformanceReportLines);
                            if PerformanceReportLines."Order Quantity" > 0 then
                                PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                                    / PerformanceReportLines."Order Quantity";

                            if PerformanceReportLines."Order Quantity" > 0 then
                                PerformanceReportLines.Insert();

                            lineNo += 1;
                        until Item_Rec.Next() = 0;
                    end else
                        if (Rec."Report Level" = Rec."Report Level"::"FG Supplier") then begin
                            Supplier.Reset();
                            Supplier.SetFilter("No.", 'FG*');
                            Supplier.FindFirst();
                            repeat
                                PerformanceReportLines.Init();
                                PerformanceReportLines."Entry No." := lineNo;
                                PerformanceReportLines.Indentation := 1;
                                PerformanceReportLines."Period Start" := LineStartDate;
                                PerformanceReportLines."Period End" := LineEndDate;
                                PerformanceReportLines."Report Level" := Supplier."No.";
                                PerformanceReportLines."Report Level Desc." := Supplier.Name;
                                PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                        PerformanceReportLines."Shipment Quantity",
                                                                                        PerformanceReportLines);
                                PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                    PerformanceReportLines."Order Quantity",
                                                                                    PerformanceReportLines);
                                if PerformanceReportLines."Order Quantity" > 0 then
                                    PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                                        / PerformanceReportLines."Order Quantity";

                                if PerformanceReportLines."Order Quantity" > 0 then
                                    PerformanceReportLines.Insert();

                                lineNo += 1;
                            until Supplier.Next() = 0;
                        end else
                            if (Rec."Report Level" = Rec."Report Level"::"FG Supplier") then begin
                                Supplier.Reset();
                                Supplier.SetFilter("No.", 'SS*');
                                Supplier.FindFirst();
                                repeat
                                    PerformanceReportLines.Init();
                                    PerformanceReportLines."Entry No." := lineNo;
                                    PerformanceReportLines.Indentation := 1;
                                    PerformanceReportLines."Period Start" := LineStartDate;
                                    PerformanceReportLines."Period End" := LineEndDate;
                                    PerformanceReportLines."Report Level" := Supplier."No.";
                                    PerformanceReportLines."Report Level Desc." := Supplier.Name;
                                    PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                    PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                    PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                            PerformanceReportLines."Shipment Quantity",
                                                                                            PerformanceReportLines);
                                    PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                        PerformanceReportLines."Order Quantity",
                                                                                        PerformanceReportLines);
                                    if PerformanceReportLines."Order Quantity" > 0 then
                                        PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                                            / PerformanceReportLines."Order Quantity";

                                    if PerformanceReportLines."Order Quantity" > 0 then
                                        PerformanceReportLines.Insert();

                                    lineNo += 1;
                                until Supplier.Next() = 0;
                            end else
                                if (Rec."Report Level" = Rec."Report Level"::Orders) then begin
                                    if Rec."Order Filter" <> '' then
                                        TransHeader.SetRange("No.", Rec."Order Filter");
                                    TransHeader.SetRange("Accepted Date", Rec."From Date", Rec."To Date");
                                    TransHeader.FindFirst();
                                    repeat
                                        PerformanceReportLines.Init();
                                        PerformanceReportLines."Entry No." := lineNo;
                                        PerformanceReportLines.Indentation := 1;
                                        PerformanceReportLines."Period Start" := LineStartDate;
                                        PerformanceReportLines."Period End" := LineEndDate;
                                        PerformanceReportLines."Report Level" := TransHeader."No.";
                                        PerformanceReportLines."Report Level Desc." := TransHeader."Transfer-from Code" + ' to ' + TransHeader."Transfer-to Code";
                                        PerformanceReportLines."Order Quantity" := Rec.CalcOrderQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                        PerformanceReportLines."Shipment Quantity" := Rec.CalcShipmentQty(LineStartDate, LineEndDate, PerformanceReportLines."Report Level");
                                        PerformanceReportLines."Lead Time" := Rec.CalcLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                                PerformanceReportLines."Shipment Quantity",
                                                                                                PerformanceReportLines);
                                        PerformanceReportLines."Future Lead Time" := Rec.CalcFutureLeadTime(LineStartDate, LineEndDate, PerformanceReportLines."Report Level",
                                                                                            PerformanceReportLines."Order Quantity",
                                                                                            PerformanceReportLines);
                                        if PerformanceReportLines."Order Quantity" > 0 then
                                            PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                                                / PerformanceReportLines."Order Quantity";

                                        if PerformanceReportLines."Order Quantity" > 0 then
                                            PerformanceReportLines.Insert();

                                        lineNo += 1;
                                    until TransHeader.Next() = 0;
                                end;
            LineStartDate := CalcDate('+1W', LineStartDate);
        until LineStartDate > LastWeekDate;
        CurrPage.Update();
    end;

}
