tableextension 50010 "Transfer Line" extends "Transfer Line"
{
    fields
    {
        field(50000; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            trigger OnValidate()
            begin
                "Line Amount" := "Unit Cost" * Quantity;
            end;
        }
        field(50001; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
        }
        field(50002; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;
        }

        field(50006; "Promised Receipt Date"; Date)
        {
            Caption = 'Expected Date';

            trigger OnValidate()
            var
                TransHeader: Record "Transfer Header";
            begin
                TestStatusOpen();

                if "Promised Receipt Date" <> 0D then begin
                    TransHeader.SetRange("No.", Rec."Document No.");
                    TransHeader.FindFirst();

                    if TransHeader."Order Status" <> TransHeader."Order Status"::"Released" then
                        Error('Order status must be Released');

                    if rec."Requested Receipt Date" > rec."Promised Receipt Date" then
                        Error('Please enter a valid date.');
                end;
            end;
        }

        field(50007; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Date';
            Editable = false;

            trigger OnValidate()
            var

            begin
                TestStatusOpen();
                "Promised Receipt Date" := "Requested Receipt Date";
            end;
        }

        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                "Line Amount" := "Unit Cost" * Quantity;
            end;
        }

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
