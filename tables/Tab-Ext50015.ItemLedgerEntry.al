tableextension 50015 "Item Ledger Entry" extends "Item Ledger Entry"
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
        // field(50003; "DMS No."; Code[20])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Item Distributions"."DSM Code" where("Item No" = field("Item No.")));
        // }
        // field(50004; "DSM Name"; Text[60])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup("Item Distributions"."DSM Name" where("Item No" = field("Item No.")));
        // }

        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item_Rec: Record Item;
            begin
                Item_Rec.Get("Item No.");
                "Process No." := Item_Rec.Process;
            end;

        }
    }
}
