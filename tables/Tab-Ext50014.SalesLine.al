tableextension 50014 "Sales Line" extends "Sales Line"
{
    fields
    {
        field(50002; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;
        }

        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                Size_Rec: Record Size;
            begin
                Size_Rec.CreateItemVariant(Rec."No.", Rec."Shortcut Dimension 1 Code");
                Rec.Validate("Variant Code", "Shortcut Dimension 1 Code");
            end;
        }
    }
}
