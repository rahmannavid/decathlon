page 50031 "DOT Report"
{

    Caption = 'Ontime Report';
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
                field("DOT Calc. Days"; Rec."DOT Calc. Days")
                {
                    Caption = 'HOT Calc. Days';
                    ApplicationArea = All;
                    Visible = FieldShowHide;
                    trigger OnValidate()
                    begin
                        if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days" then
                            CurrPage."DOT Report Line".Page.ShoHideColumn(0)
                        else
                            if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days" then
                                CurrPage."DOT Report Line".Page.ShoHideColumn(3)
                            else
                                if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days" then
                                    CurrPage."DOT Report Line".Page.ShoHideColumn(7);

                        CurrPage.Update();
                    end;
                }
            }

            part("DOT Report Line"; "DOT Report Line")
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
        FieldShowHide: Boolean;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        PerformanceReportLines: Record "Performance Report Lines";
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
                Rec."FG Location Filter" := UserSetup."location Code";
                Rec.Modify();
                FGEditable := false;
                SoleEditable := true;
            end else
                if UserSetup."Sole Supplier" <> '' then begin
                    Rec."Sole Location Filter" := UserSetup."location Code";
                    Rec.Modify();
                    FGEditable := true;
                    SoleEditable := false;
                end;
            FieldShowHide := false;
        end else begin
            FGEditable := true;
            SoleEditable := true;
            FieldShowHide := true;
        end;
        PerformanceReportLines.DeleteAll();
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days" then
            CurrPage."DOT Report Line".Page.ShoHideColumn(0)
        else
            if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days" then
                CurrPage."DOT Report Line".Page.ShoHideColumn(3)
            else
                if Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days" then
                    CurrPage."DOT Report Line".Page.ShoHideColumn(7);

        CurrPage.Update();
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

            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, '', 0, PerformanceReportLines)
            else
                if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                    PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, '', 3, PerformanceReportLines)
                else
                    if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                        PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, '', 7, PerformanceReportLines);

            PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, '', PerformanceReportLines);

            PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, '', 3, PerformanceReportLines);
            PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, '', PerformanceReportLines);

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

                    if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                        PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                    else
                        if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                            PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                        else
                            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                    PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                    PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                    PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

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

                        if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                            PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                        else
                            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                            else
                                if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                    PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                        PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                        PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                        PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

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

                            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                            else
                                if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                                    PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                                else
                                    if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                        PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                            PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                            PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                            PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                            if PerformanceReportLines."Order Quantity" > 0 then
                                PerformanceReportLines.Insert();

                            lineNo += 1;
                        until Item_Rec.Next() = 0;
                    end else
                        if (Rec."Report Level" = Rec."Report Level"::"FG Supplier") then begin
                            Supplier.Reset();
                            Supplier.SetFilter("No.", 'FG*');
                            if Rec."FG Location Filter" <> '' then
                                Supplier.SetRange("Location Code", Rec."FG Location Filter");

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

                                if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                                    PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                                else
                                    if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                                        PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                                    else
                                        if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                            PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                                PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                                PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                                PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                                if PerformanceReportLines."Order Quantity" > 0 then
                                    PerformanceReportLines.Insert();

                                lineNo += 1;
                            until Supplier.Next() = 0;
                        end else
                            if (Rec."Report Level" = Rec."Report Level"::"Sole Supplier") then begin
                                Supplier.Reset();
                                Supplier.SetFilter("No.", 'SS*');
                                if Rec."Sole Location Filter" <> '' then
                                    Supplier.SetRange("Location Code", Rec."Sole Location Filter");
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

                                    if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                                        PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                                    else
                                        if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                                            PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                                        else
                                            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                                    PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                                    PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                                    PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

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

                                        if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"0 Days") then
                                            PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines)
                                        else
                                            if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+3 Days") then
                                                PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines)
                                            else
                                                if (Rec."DOT Calc. Days" = Rec."DOT Calc. Days"::"+7 Days") then
                                                    PerformanceReportLines."HOT %" := Rec.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 7, PerformanceReportLines);

                                        PerformanceReportLines."Future HOT %" := Rec.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                                        PerformanceReportLines."DOT %" := Rec.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 3, PerformanceReportLines);
                                        PerformanceReportLines."Future DOT%" := Rec.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

                                        if PerformanceReportLines."Order Quantity" > 0 then
                                            PerformanceReportLines.Insert();

                                        lineNo += 1;
                                    until TransHeader.Next() = 0;
                                end;
            LineStartDate := CalcDate('+1W', LineStartDate);
        until LineStartDate > LastWeekDate;
    end;

}
