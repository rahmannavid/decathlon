page 50022 "Items by Size"
{
    Caption = 'Items by Size';
    DataCaptionExpression = '';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = ListPlus;
    SaveValues = true;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';

                field(Process; ProcessCode)
                {
                    ApplicationArea = All;
                    TableRelation = Process;
                    trigger OnValidate()
                    var
                        process_rec: Record Process;
                    begin
                        ShowInTransitOnAfterValidate;
                        if process_rec.Get(ProcessCode) then
                            ProcessName := process_rec."Process Name"
                        else
                            ProcessName := '';
                    end;
                }
                field("Process Name"; ProcessName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("DSM"; DSMCode)
                {
                    Caption = 'DSM';
                    ApplicationArea = All;
                    TableRelation = "DSM (Super Model)";
                    trigger OnValidate()
                    var
                        DSM: Record "DSM (Super Model)";
                    begin
                        ShowInTransitOnAfterValidate;
                        if DSM.Get(DSMCode) then
                            DSMName := DSM."DSM Name"
                        else
                            DSMName := '';
                    end;
                }
                field("DSM Name"; DSMName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Filter"; LocationCode)
                {
                    TableRelation = Location;
                    ApplicationArea = all;
                    Editable = FieldEditable;
                    trigger OnValidate()
                    begin
                        ShowInTransitOnAfterValidate;
                    end;
                }
                field("Item Filter"; ItemFilter)
                {
                    TableRelation = Item;
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        item: Record Item;
                    begin
                        ShowInTransitOnAfterValidate;
                        if item.Get(ItemFilter) then
                            ItemName := item.Description
                        else
                            ItemName := '';
                    end;
                }
                field("Item Name"; ItemName)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Size Filter"; SizeFilter)
                {
                    TableRelation = Size."Global Dimension 1 Code";
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        ShowInTransitOnAfterValidate;
                    end;
                }
            }
            part(MatrixForm; "Items by Size Matrix")
            {
                ApplicationArea = Location;
                ShowFilter = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Previous Set")
            {
                ApplicationArea = Location;
                Caption = 'Previous Set';
                Image = PreviousSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the previous set of data.';

                trigger OnAction()
                begin
                    SetColumns(MATRIX_SetWanted::Previous);
                end;
            }
            action("Next Set")
            {
                ApplicationArea = Location;
                Caption = 'Next Set';
                Image = NextSet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Go to the next set of data.';

                trigger OnAction()
                begin
                    SetColumns(MATRIX_SetWanted::Next);
                end;
            }
        }
    }

    trigger OnInit()
    begin
        TempMatrixLocation.GetLocationsIncludingUnspecifiedLocation();
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        SetColumns(MATRIX_SetWanted::Initial);
        UserSetup.Get(UserId);
        if not UserSetup."Admin User" then begin
            LocationCode := UserSetup."location Code";
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

    var
        ProcessCode: Code[20];
        ProcessName: Text[50];
        DSMCode: Code[20];
        DSMName: Text[100];
        LocationCode: Code[20];
        ItemFilter: Code[20];
        ItemName: Text[100];
        SizeFilter: Code[10];
        FieldEditable: Boolean;
        TempMatrixLocation: Record Size temporary;
        MatrixRecords: array[32] of Record Size;
        MatrixRecordRef: RecordRef;
        MATRIX_SetWanted: Option Initial,Previous,Same,Next;
        ShowColumnName: Boolean;
        MATRIX_CaptionSet: array[32] of Text[80];
        MATRIX_CaptionRange: Text;
        MATRIX_PKFirstRecInCurrSet: Text;
        MATRIX_CurrSetLength: Integer;
        UnspecifiedLocationCodeTxt: Label 'UNSPECIFIED', Comment = 'Code for unspecified location';


    procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next)
    var
        MatrixMgt: Codeunit "Matrix Management";
        CaptionFieldNo: Integer;
        CurrentMatrixRecordOrdinal: Integer;
    begin
        SetTempMatrixLocationFilters();

        Clear(MATRIX_CaptionSet);
        Clear(MatrixRecords);
        CurrentMatrixRecordOrdinal := 1;

        MatrixRecordRef.GetTable(TempMatrixLocation);
        MatrixRecordRef.SetTable(TempMatrixLocation);

        if ShowColumnName then
            CaptionFieldNo := TempMatrixLocation.FieldNo("Global Dimension 1 Code")
        else
            CaptionFieldNo := TempMatrixLocation.FieldNo("Global Dimension 1 Code");

        MatrixMgt.GenerateMatrixData(MatrixRecordRef, SetWanted, ArrayLen(MatrixRecords), CaptionFieldNo, MATRIX_PKFirstRecInCurrSet,
          MATRIX_CaptionSet, MATRIX_CaptionRange, MATRIX_CurrSetLength);

        if MATRIX_CaptionSet[1] = '' then begin
            MATRIX_CaptionSet[1] := UnspecifiedLocationCodeTxt;
            MATRIX_CaptionRange := StrSubstNo('%1%2', MATRIX_CaptionSet[1], MATRIX_CaptionRange);
        end;

        if MATRIX_CurrSetLength > 0 then begin
            TempMatrixLocation.SetPosition(MATRIX_PKFirstRecInCurrSet);
            TempMatrixLocation.Find;
            repeat
                MatrixRecords[CurrentMatrixRecordOrdinal].Copy(TempMatrixLocation);
                CurrentMatrixRecordOrdinal := CurrentMatrixRecordOrdinal + 1;
            until (CurrentMatrixRecordOrdinal > MATRIX_CurrSetLength) or (TempMatrixLocation.Next <> 1);
        end;

        UpdateMatrixSubform;
    end;

    local procedure SetTempMatrixLocationFilters()
    begin
        OnAfterSetTempMatrixLocationFilters(TempMatrixLocation);
    end;

    local procedure ShowColumnNameOnAfterValidate()
    begin
        SetColumns(MATRIX_SetWanted::Same);
    end;

    local procedure ShowInTransitOnAfterValidate()
    begin
        SetColumns(MATRIX_SetWanted::Initial);
    end;

    local procedure UpdateMatrixSubform()
    var
        ItemRec: Record Item;
    begin
        CurrPage.MatrixForm.PAGE.Load(MATRIX_CaptionSet, MatrixRecords, TempMatrixLocation, MATRIX_CurrSetLength, LocationCode, DSMCode, ProcessCode, ItemFilter, SizeFilter);
        CurrPage.MatrixForm.PAGE.SetRecord(Rec);
        CurrPage.Update(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetTempMatrixLocationFilters(var TempMatrixLocation: Record Size temporary);
    begin
    end;
}

