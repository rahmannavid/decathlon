page 50024 "DC Role Center Cue"
{

    Caption = 'Activity';
    PageType = CardPart;
    SourceTable = "DC Role Center Cue";

    layout
    {
        area(content)
        {
            cuegroup(Orders)
            {
                field("Open Orders"; Rec."Open Purchase Orders")
                {
                    Caption = 'Open Orders';
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }
                field("Released Orders"; Rec."Released Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }
                field("Rejected Orders"; Rec."Rejected Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }
                field("Appeptance Pending"; Rec."Acceptance Pending")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }
                field("Accepted Orders"; Rec."Accepted Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }
                field("In Progress Orders"; Rec."In Progress Orders")
                {
                    Caption = 'In Progress';
                    ApplicationArea = All;
                    DrillDownPageId = "Transfer Orders";
                }


            }

            cuegroup(Production)
            {
                field("Production Orders"; Rec."Production Orders")
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Released Production Orders";
                }
                // field("Finished Prod. Order"; Rec."Finished Prod. Order")
                // {
                //     ApplicationArea = All;
                //     DrillDownPageId = "Finished Production Orders";
                // }
                field("Open Sales Orders"; Rec."Open Sales Orders")
                {
                    Caption = 'Open Utilizations';
                    ApplicationArea = All;
                    DrillDownPageID = "Sales Order List";
                }

            }
            cuegroup(Payments)
            {
                field("Pending payment"; Rec."Payment Pending Orders")
                {
                    Caption = 'Pending payment';
                    ApplicationArea = All;
                    DrillDownPageID = "Transfer Orders";
                }
                field("Payment in Progress"; Rec."Payment in Progress")
                {
                    Caption = 'Payment in Progress';
                    ApplicationArea = All;
                    DrillDownPageID = "Transfer Orders";
                }
            }
            cuegroup("Lead Time")
            {
                field("Last Week Realized Lead Time"; Rec."Last Week Realized Lead Time")
                {
                    Caption = 'Realized LT W-1';
                    DecimalPlaces = 1;
                }
                field("YTD Realized Lead Time"; Rec."YTD Realized Lead Time")
                {
                    Caption = 'Realized LT YTD';
                    DecimalPlaces = 1;
                }
                field("Future Lead Time"; Rec."Future Lead Time")
                {
                    Caption = 'Future LT';
                    DecimalPlaces = 1;
                }

                field("YTD Combined Lead Time"; Rec."YTD Combined Lead Time")
                {
                    Caption = 'Piloted LT';
                    DecimalPlaces = 1;
                }

                field("Last Week Combined Lead Time"; Rec."Last Week Combined Lead Time")
                {
                    Caption = 'Last Week Combined LT';
                    DecimalPlaces = 1;
                    Visible = false;
                }
            }

            cuegroup("On Time")
            {
                field("Last week DOT%"; Rec."Last week DOT%")
                {
                    Caption = 'DOT% W-1';
                    DecimalPlaces = 1;
                }
                field("YTD DOT%"; Rec."YTD DOT%")
                {
                    Caption = 'DOT% YTD';
                    DecimalPlaces = 1;
                }
                field("Future DOT%"; Rec."Future DOT%")
                {
                    DecimalPlaces = 1;
                }

            }
            cuegroup("Handover Reliability")
            {
                field("Last week HOT"; Rec."Last week HOT%")
                {
                    Caption = 'HOT% W-1';
                    DecimalPlaces = 1;
                }
                field("YTD HOT%"; Rec."YTD HOT%")
                {
                    Caption = 'HOT% YTD';
                    DecimalPlaces = 1;
                }
                field("Future HOT%"; Rec."Future HOT%")
                {
                    DecimalPlaces = 1;
                    Visible = false;
                }
            }
        }


    }

    trigger OnOpenPage()
    var

    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        getLeadTimeYTD();
        getLeadTimeLW();
    end;

    local procedure getLeadTimeYTD()
    var
        PerformanceReportHeader: Record "Performance Report Header";
        PerformanceReportLines: Record "Performance Report Lines";
        LineStartDate: Date;
        LineEndDate: Date;
    begin
        PerformanceReportHeader.DeleteAll();
        PerformanceReportHeader.Init();
        PerformanceReportHeader.Insert();

        LineStartDate := DMY2Date(1, 1, Date2DMY(Today, 3));
        LineEndDate := Today;

        PerformanceReportHeader."From Date" := LineStartDate;
        PerformanceReportHeader."To Date" := LineEndDate;
        PerformanceReportHeader."DOT Calc. Days" := PerformanceReportHeader."DOT Calc. Days"::"+3 Days";

        PerformanceReportLines.Init();
        PerformanceReportLines."Entry No." := 1;
        PerformanceReportLines.Indentation := 0;
        PerformanceReportLines."Period Start" := LineStartDate;
        PerformanceReportLines."Period End" := LineEndDate;
        PerformanceReportLines."Order Quantity" := PerformanceReportHeader.CalcOrderQty(LineStartDate, LineEndDate, '');
        PerformanceReportLines."Shipment Quantity" := PerformanceReportHeader.CalcShipmentQty(LineStartDate, LineEndDate, '');
        PerformanceReportLines."Lead Time" := PerformanceReportHeader.CalcLeadTime(LineStartDate, LineEndDate, '',
                                                                PerformanceReportLines."Shipment Quantity",
                                                                PerformanceReportLines);
        PerformanceReportLines."Future Lead Time" := PerformanceReportHeader.CalcFutureLeadTime(LineStartDate, LineEndDate, '',
                                                            PerformanceReportLines."Order Quantity",
                                                            PerformanceReportLines);
        if PerformanceReportLines."Order Quantity" > 0 then
            PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                / PerformanceReportLines."Order Quantity";

        Rec."YTD Realized Lead Time" := PerformanceReportLines."Lead Time";
        Rec."Future Lead Time" := PerformanceReportLines."Future Lead Time";
        Rec."YTD Combined Lead Time" := PerformanceReportLines."Combined Lead Time";

        PerformanceReportLines."HOT %" := PerformanceReportHeader.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines);
        PerformanceReportLines."Future HOT %" := PerformanceReportHeader.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);
        PerformanceReportLines."DOT %" := PerformanceReportHeader.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines);
        PerformanceReportLines."Future DOT%" := PerformanceReportHeader.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

        Rec."YTD HOT%" := PerformanceReportLines."HOT %";
        Rec."Future HOT%" := PerformanceReportLines."Future HOT %";
        Rec."YTD DOT%" := PerformanceReportLines."DOT %";
        Rec."Future DOT%" := PerformanceReportLines."Future DOT%";

        Rec.Modify();
    end;

    local procedure getLeadTimeLW()
    var
        PerformanceReportHeader: Record "Performance Report Header";
        PerformanceReportLines: Record "Performance Report Lines";
        LineStartDate: Date;
        LineEndDate: Date;
    begin
        PerformanceReportHeader.DeleteAll();
        PerformanceReportHeader.Init();
        PerformanceReportHeader.Insert();

        LineStartDate := CalcDate('CW', (Today - 7)) - 7;
        LineEndDate := CalcDate('CW', Today) - 8;

        PerformanceReportHeader."From Date" := LineStartDate;
        PerformanceReportHeader."To Date" := LineEndDate;
        PerformanceReportHeader."DOT Calc. Days" := PerformanceReportHeader."DOT Calc. Days"::"+3 Days";

        PerformanceReportLines.Init();
        PerformanceReportLines."Entry No." := 1;
        PerformanceReportLines.Indentation := 0;
        PerformanceReportLines."Period Start" := LineStartDate;
        PerformanceReportLines."Period End" := LineEndDate;
        PerformanceReportLines."Order Quantity" := PerformanceReportHeader.CalcOrderQty(LineStartDate, LineEndDate, '');
        PerformanceReportLines."Shipment Quantity" := PerformanceReportHeader.CalcShipmentQty(LineStartDate, LineEndDate, '');
        PerformanceReportLines."Lead Time" := PerformanceReportHeader.CalcLeadTime(LineStartDate, LineEndDate, '',
                                                                PerformanceReportLines."Shipment Quantity",
                                                                PerformanceReportLines);
        PerformanceReportLines."Future Lead Time" := PerformanceReportHeader.CalcFutureLeadTime(LineStartDate, LineEndDate, '',
                                                            PerformanceReportLines."Order Quantity",
                                                            PerformanceReportLines);
        if PerformanceReportLines."Order Quantity" > 0 then
            PerformanceReportLines."Combined Lead Time" := (PerformanceReportLines.TotalRemLead + PerformanceReportLines.TotalShipLead)
                                                                / PerformanceReportLines."Order Quantity";

        Rec."Last Week Realized Lead Time" := PerformanceReportLines."Lead Time";
        Rec."Last Week Combined Lead Time" := PerformanceReportLines."Combined Lead Time";

        PerformanceReportLines."HOT %" := PerformanceReportHeader.CalcHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines);
        PerformanceReportLines."Future HOT %" := PerformanceReportHeader.CalcFutureHOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);
        PerformanceReportLines."DOT %" := PerformanceReportHeader.CalcDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", 0, PerformanceReportLines);
        PerformanceReportLines."Future DOT%" := PerformanceReportHeader.CalcFutureDOT(LineStartDate, LineEndDate, PerformanceReportLines."Report Level", PerformanceReportLines);

        Rec."Last week HOT%" := PerformanceReportLines."HOT %";
        Rec."Last week DOT%" := PerformanceReportLines."DOT %";

        Rec.Modify();
    end;

}
