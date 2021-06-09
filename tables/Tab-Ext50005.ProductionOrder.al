tableextension 50005 "Production Order" extends "Production Order"
{
    fields
    {
        field(50000; "FG Supplier No."; Code[20])
        {
            Caption = 'FG Supplier No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }
        field(50001; "Sole Supplier No."; Code[20])
        {
            Caption = 'Sole Supplier No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }

        field(50002; "DSM Code"; Code[20])
        {
            //TableRelation = Model.DSM where("Vendor No" = field("Sole Supplier No."));
            TableRelation = "Item Distributions"."DSM Code" where("Sole Supplier" = field("Sole Supplier No."));
            Caption = 'DSM Code';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                dsm: Record "DSM (Super Model)";
                OrdPlnHeader: Record "Order Planning Header";
            begin
                dsm.get("DSM Code");
                "DSM Name" := dsm."DSM Name";

            end;
        }
        field(50003; "DSM Name"; Text[50])
        {
            Caption = 'DSM Name';
            DataClassification = ToBeClassified;
        }
        field(50009; "Item No"; Code[20])
        {
            TableRelation = Item."No." where("FG DSM" = field("DSM Code"));

            trigger OnValidate()
            var
                item: Record Item;
            begin
                rec.Validate("Source No.", "Item No");
                TestField("DSM Code");
                if "Item No" <> '' then begin
                    item.get("Item No");
                    "Item Name" := item.Description;
                    CreatePurLines("Item No");
                end;

            end;
        }

        field(50010; "Item Name"; text[100])
        {

        }
        field(50011; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line".Quantity where("Prod. Order No." = field("No.")));
        }

        field(50012; "Remaining Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Prod. Order Line"."Remaining Quantity" where("Prod. Order No." = field("No.")));
        }

    }


    local procedure CreatePurLines(ItemNo: code[20])
    var
        ProdOrdLine: Record "Prod. Order Line";
        Model_Rec: Record Model;
        Size_Rec: Record Size;
        ItemDistributions: Record "Item Distributions";
        lineNo: Integer;

    begin
        Model_Rec.SetRange(DSM, "DSM Code");
        Model_Rec.FindFirst();
        Size_Rec.SetRange("Size Group", Model_Rec."Size Group");
        Size_Rec.FindFirst();

        ItemDistributions.SetRange("Item No", ItemNo);
        //ItemDistributions.SetRange("Model No", Model_Rec.Model);
        ItemDistributions.SetRange("Sole Supplier", "Sole Supplier No.");
        ItemDistributions.FindFirst();
        //create line
        ProdOrdLine.Reset();
        ProdOrdLine.SetRange("Prod. Order No.", "No.");
        if ProdOrdLine.FindLast() then begin
            if Confirm('Prod. Order Lines found, Do you want to change Item No? \Existing lines will be deleted and new lines will be created.') then
                ProdOrdLine.DeleteAll()
            else
                exit;
        end;

        lineNo := 10000;

        repeat
            ProdOrdLine.Init();
            ProdOrdLine.Validate(Status, Rec.Status);
            ProdOrdLine.Validate("Prod. Order No.", "No.");
            ProdOrdLine.Validate("Line No.", lineNo);
            ProdOrdLine.Validate("Item No.", itemNo);
            ProdOrdLine.Insert();

            ProdOrdLine.Validate("Shortcut Dimension 1 Code", Size_Rec."Global Dimension 1 Code"); //Size
            Size_Rec.CreateItemVariant(ItemNo, Size_Rec."Global Dimension 1 Code");
            ProdOrdLine.Validate("Variant Code", Size_Rec."Global Dimension 1 Code");   //Size-Variant

            ProdOrdLine.Validate("Unit Cost", ItemDistributions."Item Price");
            ProdOrdLine.Modify();
            lineNo := ProdOrdLine."Line No." + 10000;
        until Size_Rec.Next() = 0;
    end;


}
