codeunit 50003 "Order Planning Create PO Batch"
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
        ItemDistributions: Record "Item Distributions";

        OrdPlnMgt: Codeunit "Order Planning Management";
        MATRIX_CurrentColumnOrdinal: Integer;
        ThisWeekDate: Date;
    begin
        ThisWeekDate := DWY2Date(1, Date2DWY(Today(), 2), Date2DWY(Today(), 3));
        SetColumns(SetWanted::First);

        OrdPlnHeader.SetRange(Status, OrdPlnHeader.Status::Active);
        if OrdPlnHeader.FindFirst() then
            repeat

                //Create PO by item
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnHeader."No.");
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Item");
                if OrdPlnLine_rec.FindFirst() then
                    repeat
                        ItemDistributions.SetRange("DSM Code", OrdPlnHeader.DSM);
                        ItemDistributions.SetRange("Item No", OrdPlnLine_rec."Item No.");
                        ItemDistributions.SetRange("Supplier Type", ItemDistributions."Supplier Type"::"Sole Supplier");
                        if ItemDistributions.FindFirst() then
                            repeat
                                OrdPlnMgt.CreatePO(OrdPlnHeader."No.", ThisWeekDate, OrdPlnLine_rec."Item No.", ItemDistributions);
                            until ItemDistributions.Next() = 0;

                        OrdPlnMgt.CreateFrimedOrders(OrdPlnHeader."No.", ThisWeekDate, OrdPlnLine_rec."Item No.");
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
