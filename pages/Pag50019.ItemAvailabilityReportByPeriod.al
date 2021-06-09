page 50019 "Item Avail. Report By Period"
{

    Caption = 'Item Availability Report By Period';
    PageType = Card;
    SourceTable = "Item Avail. Report Header";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
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
                field("Item Filter"; Rec."Item Filter")
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
                field("Size Filter"; Rec."Size Filter")
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
                    Editable = FGFieldEditable;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }
                field("Sole Location Filter"; Rec."Sole Location Filter")
                {
                    ApplicationArea = All;
                    Editable = SoleFieldEditable;
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

            part(ItemAvailLocLines; "Inventory Report By Period")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Refresh)
            {
                Image = Refresh;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    ReportGenaration();
                end;
            }
        }
    }

    var
        FGFieldEditable: Boolean;
        SoleFieldEditable: Boolean;

    local procedure ReportGenaration()
    var
        lineNo: Integer;
        InventoryReportByPeriod: Record "Inventory Report By Period";
        FirstWeekDate: Date;
        LastWeekDate: Date;
        LineDate: Date;
        DSM: Record "DSM (Super Model)";
        Process_Rec: Record Process;
        Item_Rec: Record Item;
        Size_Rec: Record Size;
        Supplier: Record Vendor;
    begin

        if (Rec."From Date" = 0D) OR (Rec."To Date" = 0D) OR (Rec."From Date" > Rec."To Date") then
            Error('Invalid Date');

        InventoryReportByPeriod.Reset();
        if InventoryReportByPeriod.FindFirst() then
            InventoryReportByPeriod.DeleteAll();

        FirstWeekDate := CALCDATE('<CW>', Rec."From Date");
        LastWeekDate := CALCDATE('<CW>', Rec."To Date");

        LineDate := FirstWeekDate;
        lineNo := 1;

        repeat
            InventoryReportByPeriod.Init();
            InventoryReportByPeriod."Entry No." := lineNo;
            InventoryReportByPeriod."Period Start" := LineDate;
            InventoryReportByPeriod."Report Level" := 'Total';
            InventoryReportByPeriod.Indentation := 0;
            InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, '');
            InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, '');
            InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, '');
            InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, '');
            InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                        - InventoryReportByPeriod."Firmed Order"
                                                                        - InventoryReportByPeriod."Planned Order"
                                                                        - InventoryReportByPeriod."Shceduled Order";
            if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                InventoryReportByPeriod.Insert();


            lineNo += 1;

            if (Rec."Report Level" = Rec."Report Level"::DSM) then begin
                if Rec."DSM Filter" <> '' then
                    DSM.SetRange("DSM Code", Rec."DSM Filter");
                DSM.FindFirst();
                repeat
                    InventoryReportByPeriod.Init();
                    InventoryReportByPeriod."Entry No." := lineNo;
                    InventoryReportByPeriod."Period Start" := LineDate;
                    InventoryReportByPeriod."Report Level" := DSM."DSM Code";
                    InventoryReportByPeriod."Report Level Desc." := DSM."DSM Name";
                    InventoryReportByPeriod.Indentation := 1;

                    InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                    InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                    InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                    InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                    InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                - InventoryReportByPeriod."Firmed Order"
                                                                                - InventoryReportByPeriod."Planned Order"
                                                                                - InventoryReportByPeriod."Shceduled Order";

                    if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                        InventoryReportByPeriod.Insert();
                    lineNo += 1;
                until DSM.Next() = 0;
            end else
                if (Rec."Report Level" = Rec."Report Level"::Process) then begin
                    if Rec."Process Filter" <> '' then
                        Process_Rec.SetRange("Process Code", Rec."Process Filter");
                    Process_Rec.FindFirst();
                    repeat
                        InventoryReportByPeriod.Init();
                        InventoryReportByPeriod."Entry No." := lineNo;
                        InventoryReportByPeriod."Period Start" := LineDate;
                        InventoryReportByPeriod."Report Level" := Process_Rec."Process Code";
                        InventoryReportByPeriod."Report Level Desc." := Process_Rec."Process Name";
                        InventoryReportByPeriod.Indentation := 1;

                        InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                        InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                        InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                        InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                        InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                    - InventoryReportByPeriod."Firmed Order"
                                                                                    - InventoryReportByPeriod."Planned Order"
                                                                                    - InventoryReportByPeriod."Shceduled Order";
                        if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                            InventoryReportByPeriod.Insert();
                        lineNo += 1;
                    until Process_Rec.Next() = 0;
                end else
                    if (Rec."Report Level" = Rec."Report Level"::Item) then begin
                        if Rec."Item Filter" <> '' then
                            Item_Rec.SetRange("No.", Rec."Item Filter");
                        Item_Rec.FindFirst();
                        repeat
                            InventoryReportByPeriod.Init();
                            InventoryReportByPeriod."Entry No." := lineNo;
                            InventoryReportByPeriod."Period Start" := LineDate;
                            InventoryReportByPeriod."Report Level" := Item_Rec."No.";
                            InventoryReportByPeriod."Report Level Desc." := Item_Rec.Description;
                            InventoryReportByPeriod.Indentation := 1;
                            InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                            InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                            InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                            InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                            InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                        - InventoryReportByPeriod."Firmed Order"
                                                                                        - InventoryReportByPeriod."Planned Order"
                                                                                        - InventoryReportByPeriod."Shceduled Order";
                            if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                                InventoryReportByPeriod.Insert();
                            lineNo += 1;
                        until Item_Rec.Next() = 0;
                    end else
                        if (Rec."Report Level" = Rec."Report Level"::Size) then begin
                            if Rec."Size Filter" <> '' then
                                Size_Rec.SetRange("Global Dimension 1 Code", Rec."Size Filter");
                            Size_Rec.FindFirst();
                            repeat
                                InventoryReportByPeriod.SetRange("Period Start", LineDate);
                                InventoryReportByPeriod.SetRange("Report Level", Size_Rec."Global Dimension 1 Code");
                                if not InventoryReportByPeriod.FindFirst() then begin
                                    InventoryReportByPeriod.Init();
                                    InventoryReportByPeriod."Entry No." := lineNo;
                                    InventoryReportByPeriod."Period Start" := LineDate;
                                    InventoryReportByPeriod."Report Level" := Size_Rec."Global Dimension 1 Code";
                                    InventoryReportByPeriod.Indentation := 1;
                                    InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                                - InventoryReportByPeriod."Firmed Order"
                                                                                                - InventoryReportByPeriod."Planned Order"
                                                                                                - InventoryReportByPeriod."Shceduled Order";
                                    if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                                        InventoryReportByPeriod.Insert();
                                    lineNo += 1;
                                end;
                            until Size_Rec.Next() = 0;
                        end else
                            if (Rec."Report Level" = Rec."Report Level"::"FG Supplier") then begin
                                Supplier.Reset();
                                Supplier.SetFilter("No.", 'FG*');
                                Supplier.FindFirst();
                                repeat
                                    InventoryReportByPeriod.Init();
                                    InventoryReportByPeriod."Entry No." := lineNo;
                                    InventoryReportByPeriod."Period Start" := LineDate;
                                    InventoryReportByPeriod."Report Level" := Supplier."No.";
                                    InventoryReportByPeriod."Report Level Desc." := Supplier.Name;
                                    InventoryReportByPeriod.Indentation := 1;
                                    InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                                    InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                                - InventoryReportByPeriod."Firmed Order"
                                                                                                - InventoryReportByPeriod."Planned Order"
                                                                                                - InventoryReportByPeriod."Shceduled Order";
                                    if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                                        InventoryReportByPeriod.Insert();
                                    lineNo += 1;
                                until Supplier.Next() = 0;
                            end else
                                if (Rec."Report Level" = Rec."Report Level"::"Sole Supplier") then begin
                                    Supplier.Reset();
                                    Supplier.SetFilter("No.", 'SS*');
                                    Supplier.FindFirst();
                                    repeat
                                        InventoryReportByPeriod.Init();
                                        InventoryReportByPeriod."Entry No." := lineNo;
                                        InventoryReportByPeriod."Period Start" := LineDate;
                                        InventoryReportByPeriod."Report Level" := Supplier."No.";
                                        InventoryReportByPeriod."Report Level Desc." := Supplier.Name;
                                        InventoryReportByPeriod."Gross Requirement" := Rec.CalcGrossRequirement(LineDate, InventoryReportByPeriod."Report Level");
                                        InventoryReportByPeriod."Firmed Order" := Rec.CalcFirmedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                        InventoryReportByPeriod."Planned Order" := Rec.CalcPlannedOrder(LineDate, InventoryReportByPeriod."Report Level");
                                        InventoryReportByPeriod."Shceduled Order" := Rec.CalcShceduledOrder(LineDate, InventoryReportByPeriod."Report Level");
                                        InventoryReportByPeriod."Projected Available Balance" := InventoryReportByPeriod."Gross Requirement"
                                                                                                    - InventoryReportByPeriod."Firmed Order"
                                                                                                    - InventoryReportByPeriod."Planned Order"
                                                                                                    - InventoryReportByPeriod."Shceduled Order";
                                        if InventoryReportByPeriod."Projected Available Balance" <> 0 then
                                            InventoryReportByPeriod.Insert();
                                        lineNo += 1;
                                    until Supplier.Next() = 0;
                                end;
            LineDate := CalcDate('+1W', LineDate);
        until LineDate > LastWeekDate;
        CurrPage.ItemAvailLocLines.Page.Update();
    end;

    trigger OnOpenPage()
    var

    begin
        if not Rec.FindFirst() then begin
            Rec.Init();
            Rec."Entry No." := 1;
            Rec.Insert();
        end;
    end;

    trigger OnAfterGetRecord()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Admin User" then begin
            if UserSetup."Vendor No." <> '' then begin
                Rec."FG Location Filter" := UserSetup."location Code";
                FGFieldEditable := false;
            end
            else
                if UserSetup."Sole Supplier" <> '' then begin
                    Rec."Sole Location Filter" := UserSetup."location Code";
                    SoleFieldEditable := false;
                end;
            Rec.Modify();
        end else begin
            FGFieldEditable := true;
            SoleFieldEditable := true;
        end;

        ReportGenaration();
    end;

}
