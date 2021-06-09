tableextension 50013 "Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(50000; "Order Status"; Option)
        {
            OptionMembers = "Open","Release","Accepted","Rejected","Partially Shipped","Completely Shipped","Payment Pending","Paid","Closed";
            FieldClass = FlowField;
            CalcFormula = lookup("Purchase Header"."Order Status" where("Document Type" = field("Document Type"), "No." = field("Document No.")));
        }
        field(50002; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;
        }

        field(50003; "PO No."; Code[20])
        {
            TableRelation = "Transfer Header"."No.";
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                itemRec: Record Item;
            begin
                if itemRec.Get("No.") then
                    "Process No." := itemRec.Process;
            end;
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
