tableextension 50003 "Dimension Value" extends "Dimension Value"
{
    fields
    {
        field(50000; "Dimension For"; Option)
        {
            Caption = 'Dimension For';
            DataClassification = ToBeClassified;
            OptionMembers = " ","Size";
        }

        modify("Dimension Code")
        {
            trigger OnAfterValidate()
            var
                Dimension_Rec: Record Dimension;
            begin
                if "Dimension Code" <> '' then
                    Dimension_Rec.Get("Dimension Code");
                "Dimension For" := Dimension_Rec."Dimension For";
            end;
        }
    }


}
