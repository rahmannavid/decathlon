codeunit 50002 "Order Planning Calc Batch"
{
    var
        MatrixRecords: array[32] of Record Date;
        CostCenterFilter: Text;
        CostObjectFilter: Text;
        BudgetFilter: Text;
        MatrixColumnCaptions: array[32] of Text[80];
        ColumnSet: Text[80];
        PKFirstRecInCurrSet: Text[80];
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        AmountType: Option "Balance at Date","Net Change";
        RoundingFactor: Option "None","1","1000","1000000";
        SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn;
        CurrSetLength: Integer;
        DateFilter: Text[20];
        FieldEditable: Boolean;

    trigger OnRun()
    var
        OrdPlnHeader: Record "Order Planning Header";
        OrdPlnLine_rec: Record "Order Planning Line";
        OrdPlnMgt: Codeunit "Order Planning Management";
        MATRIX_CurrentColumnOrdinal: Integer;
    begin
        SetColumns(SetWanted::First);

        OrdPlnHeader.SetRange(Status, OrdPlnHeader.Status::Active);
        if OrdPlnHeader.FindFirst() then
            repeat

                //Calculate Planned Order
                for MATRIX_CurrentColumnOrdinal := 1 to 32 do
                    OrdPlnMgt.CalcuelateByWeek(OrdPlnHeader."No.", MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start");

                //Projected Stock calc
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnHeader."No.");
                if OrdPlnLine_rec.FindFirst() then
                    repeat
                        for MATRIX_CurrentColumnOrdinal := 1 to 32 do
                            OrdPlnMgt.CalculateProjectedStock(OrdPlnHeader."No.", MatrixRecords[MATRIX_CurrentColumnOrdinal]."Period Start", OrdPlnLine_rec."Item No.");
                    until OrdPlnLine_rec.Next() = 0;



            until OrdPlnHeader.Next() = 0;
    end;

    procedure SetColumns(SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";

    begin

        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;
}
