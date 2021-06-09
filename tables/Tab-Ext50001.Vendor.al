tableextension 50001 Vendor extends Vendor
{
    fields
    {
        field(50000; CNUF; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; Supplier; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Supplier Full Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Supplier Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "DPP Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DPP List";

            trigger OnValidate()
            var
                DPP_Rec: Record "DPP List";
            begin
                DPP_Rec.Get("DPP Code");
                "DPP Name" := DPP_Rec."DPP Name";
            end;
        }
        field(50005; "DPP Name"; Text[60])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50006; "Responsible"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
    }
}
