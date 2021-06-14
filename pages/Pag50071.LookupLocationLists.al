page 50071 "Lookup Location Lists"
{

    Caption = 'Lookup Location Lists';
    PageType = List;
    SourceTable = Location;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Selected then
                            InsertTempLocation(rec.Code)
                        else
                            DeleteUnselected(rec.Code);
                    end;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        Selected := CheckSelected(Rec.Code);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        Clear(LocationText);
        TempLocationVar.Reset();
        if TempLocationVar.Find('-') then
            repeat
                if LocationText = '' then
                    LocationText := TempLocationVar.Code
                else
                    LocationText += '|' + TempLocationVar.Code;
            until TempLocationVar.Next() = 0;
    end;

    var
        Selected: Boolean;
        LocationVar: Record Location;
        TempLocationVar: Record Location temporary;
        LocationText: Text;

    procedure InsertTempLocation(LocationVarText: Text)
    begin
        if LocationVarText = '' then
            exit;
        LocationVar.Reset();
        LocationVar.SetFilter(Code, LocationVarText);
        if LocationVar.Find('-') then
            repeat
                TempLocationVar.Init();
                TempLocationVar.Code := LocationVar.Code;
                TempLocationVar.Insert();
            until LocationVar.Next() = 0;
    end;

    local procedure CheckSelected(LocationVarText: Text): Boolean
    begin
        TempLocationVar.Reset();
        TempLocationVar.SetRange(Code, LocationVarText);
        if TempLocationVar.FindFirst() then
            exit(true);
    end;

    local procedure DeleteUnselected(LocationVarText: Text)
    begin
        TempLocationVar.Reset();
        TempLocationVar.SetRange(Code, LocationVarText);
        if TempLocationVar.FindFirst() then
            TempLocationVar.Delete();
    end;

    procedure ReturnLocationText(): text
    begin
        exit(LocationText);
    end;
}
