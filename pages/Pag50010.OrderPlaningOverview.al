page 50010 "Prod. Order Planing Overview"
{

    Caption = 'Purchase Planning Overview';
    PageType = Card;
    SourceTable = "Order Planning Header";
    ApplicationArea = All;
    UsageCategory = Documents;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = (Rec.Status = Rec.Status::New); //Temp Blocked
                field("Vendor No.";
                Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DMS; Rec.DSM)
                {
                    ApplicationArea = All;
                }
                field("DSM Name"; Rec."DSM Name")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }

                field(DPP; Rec.DPP)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("This Week"; rec."This Week")
                {
                    ApplicationArea = All;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(MatrixForm; "Order Planing Line Overview")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Edit)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Edit';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Prod. Order Planing";
                RunPageLink = "No." = field("No.");
            }
            action(PreviousSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::Previous);
                    UpdateMatrixSubform;
                end;
            }
            action(PreviousColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Previous Column';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the previous column.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::PreviousColumn);
                    UpdateMatrixSubform;
                end;
            }
            action(NextColumn)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Column';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next column.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::NextColumn);
                    UpdateMatrixSubform;
                end;
            }
            action(NextSet)
            {
                ApplicationArea = CostAccounting;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    MATRIX_GenerateColumnCaptions(SetWanted::Next);
                    UpdateMatrixSubform;
                end;
            }

            action("Generate Lines")
            {
                ApplicationArea = All;
                Caption = 'Generate Lines';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    OrderPlanningMgt: Codeunit "Order Planning Management";
                begin
                    if Confirm('All exixting line will be deleted. Do you want to proceed?', false) then
                        OrderPlanningMgt.GeneratePlanningLines(Rec)
                    else
                        Message('Process canceled');
                end;
            }


        }
    }

    trigger OnOpenPage()
    begin
        PeriodType := PeriodType::Week;
        SetColumns(SetWanted::First);
        //BudgetFilter := GetFilter("Budget Filter");
        DateFilter := Format(Today) + '..' + Format(CalcDate('+32W', Today));
        MATRIX_GenerateColumnCaptions(SetWanted::First);
        UpdateMatrixSubform();
    end;

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

    procedure SetColumns(SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";

    begin

        MatrixMgt.GeneratePeriodMatrixData(SetWanted, 32, false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;

    local procedure UpdateMatrixSubform()
    begin
        CurrPage.MatrixForm.PAGE.Load(MatrixColumnCaptions, MatrixRecords, CurrSetLength, CostCenterFilter,
          CostObjectFilter, BudgetFilter, RoundingFactor, AmountType);
        CurrPage.MatrixForm.PAGE.ExpandAll(Rec."No.");
    end;

    local procedure MATRIX_GenerateColumnCaptions(MATRIX_SetWanted: Option First,Previous,Same,Next,PreviousColumn,NextColumn)
    var
        MatrixMgt: Codeunit "Matrix Management";
    begin
        Clear(MatrixColumnCaptions);
        CurrSetLength := 32;

        MatrixMgt.GeneratePeriodMatrixData(
          MATRIX_SetWanted, CurrSetLength, false, PeriodType, '',
          PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;
}
