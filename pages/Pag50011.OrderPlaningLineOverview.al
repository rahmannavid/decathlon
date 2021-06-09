page 50011 "Order Planing Line Overview"
{

    Caption = 'Purchase Line Overview';
    PageType = ListPart;
    SourceTable = "Order Planning Line";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Line Type";
                ShowCaption = false;
                ShowAsTree = true;
                Editable = false;
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
                }

                field(Column1; MATRIX_CellData[1])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[1];

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

                    trigger OnValidate()
                    begin
                        UpdateAmount(12);
                    end;
                }

                field(Column13; MATRIX_CellData[13])
                {
                    ApplicationArea = CostAccounting;
                    BlankZero = true;
                    CaptionClass = '3,' + MATRIX_ColumnCaption[13];

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

    procedure ExpandAll(DocumentNo: Code[20])
    begin
        CopyLinesToTemp(false, DocumentNo);
    end;

    local procedure CopyLinesToTemp(OnlyRoot: Boolean; DocumentNo: Code[20])
    var
        OPL: Record "Order Planning Line";
    begin
        Rec.Reset;
        Rec.DeleteAll();
        Rec.SetCurrentKey("Document No.", "Line No");

        if OnlyRoot then begin
            OPL.SetRange("Document No.", DocumentNo);
            OPL.SetRange(Indentation, 0);
        end;
        if OPL.Find('-') then
            repeat
                Rec := OPL;
                Rec.Insert;
            until OPL.Next = 0;

        if Rec.FindFirst then;
    end;

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
        //SetDateFilter(ColumnID);
        //Rec.CalcFields("Quantity");
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
            DetailLine.Insert();
        end;

    end;

    procedure Load(MatrixColumns1: array[32] of Text[80]; var MatrixRecords1: array[32] of Record Date; CurrentNoOfMatrixColumns: Integer; CostCenterFilter1: Code[20]; CostObjectFilter1: Code[20]; BudgetFilter1: Code[10]; RoundingFactor1: Option "None","1","1000","1000000"; AmtType1: Option "Balance at Date","Net Change")
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
}
