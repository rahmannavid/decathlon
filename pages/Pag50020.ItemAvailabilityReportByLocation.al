page 50020 "Item Avail. Report By Location"
{

    Caption = 'Item Availability Report By Location';
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
                field("Process Filter"; Rec."Process Filter")
                {
                    ApplicationArea = All;
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
                field("Size Filter"; Rec."Size Filter")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ReportGenaration();
                    end;
                }

            }

            part(ItemAvailLocLines; "Inventory Report By Location")
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
        FieldEditable: Boolean;

    local procedure ReportGenaration()
    var
        lineNo: Integer;
        InventoryReportByLocation: Record "Inventory Report By Location";
        LocationRec: Record Location;
        TempLocationFilter: Code[10];
    begin

        if (Rec."From Date" = 0D) OR (Rec."To Date" = 0D) OR (Rec."From Date" > Rec."To Date") then
            Error('Invalid Date');

        InventoryReportByLocation.Reset();
        if InventoryReportByLocation.FindFirst() then
            InventoryReportByLocation.DeleteAll();

        lineNo := 1;
        TempLocationFilter := Rec."FG Location Filter";

        LocationRec.Reset();
        LocationRec.FindFirst();
        repeat

            Rec."FG Location Filter" := LocationRec.Code;
            Rec.Modify();

            InventoryReportByLocation.Init();
            InventoryReportByLocation."Entry No." := lineNo;
            InventoryReportByLocation.Location := LocationRec.Code;
            InventoryReportByLocation."Gross Requirement" := Rec.CalcGrossRequirement(0D, '');
            InventoryReportByLocation."Firmed Order" := Rec.CalcFirmedOrder(0D, '');
            InventoryReportByLocation."Planned Order" := Rec.CalcPlannedOrder(0D, '');
            InventoryReportByLocation."Shceduled Order" := Rec.CalcShceduledOrder(0D, '');
            InventoryReportByLocation."Projected Available Balance" := InventoryReportByLocation."Gross Requirement"
                                                                        - InventoryReportByLocation."Firmed Order"
                                                                        - InventoryReportByLocation."Planned Order"
                                                                        - InventoryReportByLocation."Shceduled Order";
            InventoryReportByLocation.Inventory := Rec.CalcItemInventory();
            InventoryReportByLocation.Insert();

            lineNo += 1;

        until LocationRec.Next() = 0;

        Rec."FG Location Filter" := TempLocationFilter;
        Rec.Modify();
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
        locationVar: Record Location;
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Admin User" then begin
            if locationVar.Get(UserSetup."location Code") then
                Rec."FG Location Filter" := UserSetup."location Code";
            Rec.Modify();
            FieldEditable := false;
        end else
            FieldEditable := true;

        ReportGenaration();

    end;

}
