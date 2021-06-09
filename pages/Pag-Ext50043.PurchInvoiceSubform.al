pageextension 50043 "Purch. Invoice Subform" extends "Purch. Invoice Subform"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        addafter(Description)
        {
            field("Variant Code1"; Rec."Variant Code")
            {

            }
        }
        addbefore(Type)
        {
            field("PO No."; Rec."PO No.")
            { }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        PurLine: Record "Purchase Line";
        TransHeader: Record "Transfer Header";
    begin
        TransHeader.Get(Rec."PO No.");
        TransHeader."Invoice No." := '';
        TransHeader.Modify();

        PurLine.Reset();
        PurLine.SetRange("PO No.", Rec."PO No.");
        if PurLine.FindFirst() then
            PurLine.DeleteAll();

        Message('PO %1 has been deleted from this document.', TransHeader."No.");
    end;
}
