page 50009 "Order Planing Line"
{

    Caption = 'Order Planning Line';
    PageType = ListPart;
    SourceTable = "Order Planning Line";
    DelayedInsert = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Line Type";
                ShowCaption = false;
                FreezeColumn = "Process No.";
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line Type"; Rec."Line Type")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = Emphasize;
                }
                field(Initial; Rec.Initial)
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    DecimalPlaces = 0;
                }

                field(Column1; MATRIX_CellData[1])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(1);
                    end;
                }
                field(Column2; MATRIX_CellData[2])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[2];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(2);
                    end;
                }
                field(Column3; MATRIX_CellData[3])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[3];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(3);
                    end;
                }

                field(Column4; MATRIX_CellData[4])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[4];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(4);
                    end;
                }
                field(Column5; MATRIX_CellData[5])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[5];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(5);
                    end;
                }
                field(Column6; MATRIX_CellData[6])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[6];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(6);
                    end;
                }
                field(Column7; MATRIX_CellData[7])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[7];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(7);
                    end;
                }
                field(Column8; MATRIX_CellData[8])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[8];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(8);
                    end;
                }
                field(Column9; MATRIX_CellData[9])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[9];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(9);
                    end;
                }
                field(Column10; MATRIX_CellData[10])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[10];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(10);
                    end;
                }
                field(Column11; MATRIX_CellData[11])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[11];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(11);
                    end;
                }
                field(Column12; MATRIX_CellData[12])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }
                field(Column13; MATRIX_CellData[13])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[12];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(13);
                    end;
                }
                field(Column14; MATRIX_CellData[14])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[14];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(14);
                    end;
                }
                field(Column15; MATRIX_CellData[15])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[15];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(15);
                    end;
                }
                field(Column16; MATRIX_CellData[16])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[16];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(16);
                    end;
                }
                field(Column17; MATRIX_CellData[17])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[17];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(17);
                    end;
                }
                field(Column18; MATRIX_CellData[18])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[18];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(18);
                    end;
                }
                field(Column19; MATRIX_CellData[19])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[19];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(19);
                    end;
                }
                field(Column20; MATRIX_CellData[20])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[20];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(20);
                    end;
                }
                field(Column21; MATRIX_CellData[21])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[21];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(21);
                    end;
                }
                field(Column22; MATRIX_CellData[22])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[22];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(22);
                    end;
                }
                field(Column23; MATRIX_CellData[23])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[23];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(23);
                    end;
                }
                field(Column24; MATRIX_CellData[24])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[24];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(24);
                    end;
                }
                field(Column25; MATRIX_CellData[25])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[25];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(25);
                    end;
                }
                field(Column26; MATRIX_CellData[26])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[26];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(26);
                    end;
                }
                field(Column27; MATRIX_CellData[27])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[27];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(27);
                    end;
                }
                field(Column28; MATRIX_CellData[28])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[28];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(28);
                    end;
                }
                field(Column29; MATRIX_CellData[29])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(29);
                    end;
                }
                field(Column30; MATRIX_CellData[30])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[29];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(30);
                    end;
                }
                field(Column31; MATRIX_CellData[31])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[31];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(31);
                    end;
                }
                field(Column32; MATRIX_CellData[32])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[32];
                    DecimalPlaces = 0;

                    trigger OnValidate()
                    begin
                        UpdateAmount(32);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        MATRIX_ReloadColumns();
        if (rec."Line Type" = Rec."Line Type"::"Need by DSM")
            OR (rec."Line Type" = Rec."Line Type"::"Need by Item") then
            Emphasize := true
        else
            Emphasize := false;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetFilter("Line Type", '<>%1&<>%2&<>%3&<>%4'
                                    , Rec."Line Type"::"Deployable Orders"
                                    , Rec."Line Type"::"Deployable Orders by Size"
                                    , Rec."Line Type"::"Projected Stock"
                                    , Rec."Line Type"::"Stock by Size");
    end;

    //Global Variables
    var
        MatrixRecords: array[32] of Record Date;
        CostBudgetEntry: Record "Cost Budget Entry";
        MatrixMgt: Codeunit "Matrix Management";
        CostCenterFilter: Code[20];
        CostObjectFilter: Code[20];
        BudgetFilter: Code[10];
        MATRIX_ColumnCaption: array[32] of Text[80];
        RoundingFactorFormatString: Text;
        AmtType: Option "Balance at Date","Net Change";
        RoundingFactor: Option "None","1","1000","1000000";
        MATRIX_CurrentNoOfMatrixColumn: Integer;
        MATRIX_CellData: array[32] of Decimal;
        [InDataSet]
        Emphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        CurrRegNo: Integer;
        OrdPlnMgt: Codeunit "Order Planning Management";

    local procedure MATRIX_ReloadColumns()
    var
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
            MATRIX_OnAfterGetRecord(MATRIX_CurrentColumnOrdinal);
        NameIndent := rec.Indentation;
    end;

    local procedure MATRIX_OnAfterGetRecord(ColumnID: Integer)
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", Rec."Document No.");
        DetailLine.SetRange("Line No", Rec."Line No");
        DetailLine.SetRange(Week, MatrixRecords[ColumnID]."Period Start");
        if DetailLine.FindFirst() then
            MATRIX_CellData[ColumnID] := DetailLine."Quantity"
        else
            MATRIX_CellData[ColumnID] := 0;
    end;

    local procedure UpdateAmount(ColumnID: Integer)
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", Rec."Document No.");
        DetailLine.SetRange("Line No", Rec."Line No");
        DetailLine.SetRange(Week, MatrixRecords[ColumnID]."Period Start");
        if DetailLine.FindFirst() then begin
            DetailLine.Quantity := MATRIX_CellData[ColumnID];
            DetailLine.Modify();
        end else begin
            DetailLine.Init();
            DetailLine."Document No." := Rec."Document No.";
            DetailLine."Line No" := Rec."Line No";
            DetailLine.Week := MatrixRecords[ColumnID]."Period Start";
            DetailLine.Quantity := MATRIX_CellData[ColumnID];
            DetailLine."Child Of" := Rec."Child Of";
            DetailLine.Insert();
        end;
    end;

    procedure Calcualte(ThisWeekDate: Date; DocumentNo: Code[20])
    var
        MATRIX_CurrentColumnOrdinal: Integer;
        OrdPlnLine_rec: Record "Order Planning Line";
    begin

        //Calculate Planned Order
        for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
            OrdPlnMgt.CalcuelateByWeek(DocumentNo, MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start");

        //Commit();

        //Firmed Order by size calc by item
        // OrdPlnLine_rec.Reset();
        // OrdPlnLine_rec.SetRange("Document No.", DocumentNo);
        // OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Item");
        // if OrdPlnLine_rec.FindFirst() then
        //     repeat
        //         OrdPlnMgt.CreateFrimedOrders(DocumentNo, ThisWeekDate, OrdPlnLine_rec."Item No.");
        //     until OrdPlnLine_rec.Next() = 0;

        // //Projected Stock calc
        // if OrdPlnLine_rec.FindFirst() then
        //     repeat
        //         for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
        //             OrdPlnMgt.CreatePO(DocumentNo, MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start", OrdPlnLine_rec."Item No.");
        //     until OrdPlnLine_rec.Next() = 0;

        //Projected Stock calc
        if OrdPlnLine_rec.FindFirst() then
            repeat
                for MATRIX_CurrentColumnOrdinal := 1 to MATRIX_CurrentNoOfMatrixColumn do
                    OrdPlnMgt.CalculateProjectedStock(DocumentNo, MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start", OrdPlnLine_rec."Item No.");
            until OrdPlnLine_rec.Next() = 0;
    end;

    procedure CreatePO(ThisWeekDate: Date; DocumentNo: Code[20]; DMS: Code[20])
    var
        OrdPlnLine_rec: Record "Order Planning Line";
        ItemDistributions: Record "Item Distributions";
    begin
        //Create PO by item
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", DocumentNo);
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Item");
        if OrdPlnLine_rec.FindFirst() then
            repeat

                ItemDistributions.SetRange("DSM Code", DMS);
                ItemDistributions.SetRange("Item No", OrdPlnLine_rec."Item No.");
                ItemDistributions.SetRange("Supplier Type", ItemDistributions."Supplier Type"::"Sole Supplier");
                if ItemDistributions.FindFirst() then
                    repeat
                        OrdPlnMgt.CreatePO(DocumentNo, ThisWeekDate, OrdPlnLine_rec."Item No.", ItemDistributions);
                    until ItemDistributions.Next() = 0;

                OrdPlnMgt.CreateFrimedOrders(DocumentNo, ThisWeekDate, OrdPlnLine_rec."Item No.");
            until OrdPlnLine_rec.Next() = 0;

    end;

    procedure Load(MatrixColumns1: array[32] of Text[80]; var
                                                              MatrixRecords1: array[32] of Record Date;
                                                              CurrentNoOfMatrixColumns: Integer;
                                                              CostCenterFilter1: Code[20];
                                                              CostObjectFilter1: Code[20];
                                                              BudgetFilter1: Code[10];
                                                              RoundingFactor1: Option "None","1","1000","1000000";
                                                              AmtType1: Option "Balance at Date","Net Change")
    var
        i: Integer;
    begin
        for i := 1 to 32 do begin
            if MatrixColumns1[i] = '' then
                MATRIX_ColumnCaption[i] := ' '
            else
                MATRIX_ColumnCaption[i] := MatrixColumns1[i];
            MatrixRecords[i] := MatrixRecords1[i];
        end;
        if MATRIX_ColumnCaption[1] = '' then; // To make this form pass preCAL test

        if CurrentNoOfMatrixColumns > ArrayLen(MATRIX_CellData) then
            MATRIX_CurrentNoOfMatrixColumn := ArrayLen(MATRIX_CellData)
        else
            MATRIX_CurrentNoOfMatrixColumn := CurrentNoOfMatrixColumns;
        CostCenterFilter := CostCenterFilter1;
        CostObjectFilter := CostObjectFilter1;
        BudgetFilter := BudgetFilter1;
        RoundingFactor := RoundingFactor1;
        AmtType := AmtType1;
        RoundingFactorFormatString := MatrixMgt.GetFormatString(RoundingFactor, false);
        CurrPage.Update(false);
    end;

    local procedure UpdatePOCreated(OrdPlnLine: Record "Order Planning Line"; WeekDay: Date)
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", OrdPlnLine."Document No.");
        DetailLine.SetRange("Line No", OrdPlnLine."Line No");
        DetailLine.SetRange(Week, WeekDay);
        if DetailLine.FindFirst() then begin
            DetailLine."PO Created" := true;
            DetailLine.Modify();
        end;
    end;

    local procedure GetPOCreated(OrdPlnLine: Record "Order Planning Line"; WeekDay: Date): Boolean
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", OrdPlnLine."Document No.");
        DetailLine.SetRange("Line No", OrdPlnLine."Line No");
        DetailLine.SetRange(Week, WeekDay);
        if DetailLine.FindFirst() then begin
            exit(DetailLine."PO Created");
        end;
        exit(false);
    end;
}
