page 50008 "Prod. Order Planing"
{

    Caption = 'Purchase Order Planning';
    PageType = Card;
    SourceTable = "Order Planning Header";
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = (Rec.Status = Rec.Status::New); //Temp Blocked
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = FieldEditable;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(DMS; Rec.DSM)
                {
                    Importance = Promoted;
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
            part(MatrixForm; "Order Planing Line")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = field("No.");
            }
        }
    }

    actions
    {
        // area(Navigation)
        // {
        //     action(Overview)
        //     {
        //         ApplicationArea = All;
        //         Image = FiledOverview;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;

        //         trigger OnAction()
        //         begin
        //             Page.Run(page::"Prod. Order Planing Overview", Rec);
        //         end;
        //     }
        // }
        area(Processing)
        {
            Group(Navigate)
            {
                action(PreviousSet)
                {
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
                    ApplicationArea = All;
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
            }


            action("Generate Lines")
            {
                ApplicationArea = All;
                Caption = 'Generate Lines';
                Image = LineDescription;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    OrderPlanningMgt: Codeunit "Order Planning Management";
                begin
                    Rec.TestField(Status, Rec.Status::Active);
                    if Confirm('All exixting line will be deleted. Do you want to proceed?', false) then
                        OrderPlanningMgt.GeneratePlanningLines(Rec)
                    else
                        Message('Process canceled');
                end;
            }

            action(Calculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = Calculate;

                trigger OnAction()
                var
                    ThisWeekDate: Date;
                    Pos: Integer;
                    Week: Integer;
                    Year: Integer;
                    window: Dialog;
                begin
                    Rec.TestField(Status, Rec.Status::Active);

                    window.Open('Calculating...Please Wait\Do not close this page.');

                    Pos := STRPOS(Rec."This Week", '.');
                    EVALUATE(Week, Format(COPYSTR(Rec."This Week", 1, Pos - 1)));
                    EVALUATE(Year, Format(COPYSTR(Rec."This Week", Pos + 1, StrLen(Rec."This Week"))));
                    ThisWeekDate := DWY2Date(1, Week, Year);

                    CurrPage.MatrixForm.PAGE.Calcualte(ThisWeekDate, Rec."No.");

                    window.Close();
                    Message('Calculation Completed Successfully');
                end;
            }

            action("Create PO")
            {
                ApplicationArea = All;
                Image = CreateDocument;

                trigger OnAction()
                var
                    ThisWeekDate: Date;
                    Pos: Integer;
                    Week: Integer;
                    Year: Integer;
                    window: Dialog;
                begin
                    Rec.TestField(Status, Rec.Status::Active);
                    window.Open('Creating PO...Please Wait\Do not close this page.');

                    Pos := STRPOS(Rec."This Week", '.');
                    EVALUATE(Week, Format(COPYSTR(Rec."This Week", 1, Pos - 1)));
                    EVALUATE(Year, Format(COPYSTR(Rec."This Week", Pos + 1, StrLen(Rec."This Week"))));
                    ThisWeekDate := DWY2Date(1, Week, Year);

                    CurrPage.MatrixForm.PAGE.CreatePO(ThisWeekDate, Rec."No.", Rec.DSM);

                    window.Close();
                    Message('Process Completed Successfully');
                end;
            }

            group("Change Status")
            {

                action(Active)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var

                    begin
                        Rec.TestField("Vendor No.");
                        Rec.TestField(DSM);
                        if Confirm('Do you want to active this DSM?') then begin
                            Rec.Status := Rec.Status::Active;
                            Rec.Modify();
                        end;

                    end;
                }
                action(Close)
                {
                    ApplicationArea = All;
                    trigger OnAction()
                    var

                    begin
                        if Confirm('Do you want to close this DSM?') then begin
                            Rec.Status := Rec.Status::Closed;
                            Rec.Modify();
                        end;
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            FieldEditable := false;
        end else
            FieldEditable := true;

        if userSetup."Sole Supplier" <> '' then
            Error('You do not have permission to edit order planning');

        PeriodType := PeriodType::Week;
        SetColumns(SetWanted::First);
        //BudgetFilter := GetFilter("Budget Filter");
        DateFilter := Format(WorkDate()) + '..' + Format(CalcDate('+32W', WorkDate()));
        MATRIX_GenerateColumnCaptions(SetWanted::First);
        UpdateMatrixSubform();


    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        Rec."This Week" := Format(Date2DWY(WorkDate(), 2)) + '.' + Format(Date2DWY(WorkDate(), 3));
        Rec.Modify(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        vendorVar: Record Vendor;
        userSetup: Record "User Setup";
    begin
        Rec."Order Date" := Today;

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if vendorVar.get(userSetup."Vendor No.") then
                Rec.Validate("Vendor No.", userSetup."Vendor No.");
            FieldEditable := false;
        end else
            FieldEditable := true;
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
        FieldEditable: Boolean;

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
