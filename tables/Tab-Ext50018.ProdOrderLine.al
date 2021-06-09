tableextension 50018 "Prod. Order Line" extends "Prod. Order Line"
{
    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                Size_Rec: Record Size;
            begin
                Size_Rec.CreateItemVariant(Rec."Item No.", Rec."Shortcut Dimension 1 Code");
                Rec.Validate("Variant Code", "Shortcut Dimension 1 Code");
            end;
        }
    }
}
