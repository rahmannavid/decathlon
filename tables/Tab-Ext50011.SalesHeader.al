tableextension 50011 "Sales Header" extends "Sales Header"
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
        field(50002; "DSM Code"; Code[20])
        {
            TableRelation = Model.DSM where("Vendor No" = field("FG Supplier No."));
            Caption = 'DSM Code';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                dsm: Record "DSM (Super Model)";
                OrdPlnHeader: Record "Order Planning Header";
                userSetup: Record "User Setup";
            begin
                userSetup.get(UserId);
                dsm.get("DSM Code");
                "DSM Name" := dsm."DSM Name";
                Validate("Location Code", userSetup."location Code");
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
    }

    local procedure CreatePurLines(ItemNo: code[20])
    var
        SalesLine: Record "Sales Line";
        Model_Rec: Record Model;
        Size_Rec: Record Size;
        ItemDistributions: Record "Item Distributions";
        lineNo: Integer;
        userSetup: Record "User Setup";
        Item_Rec: Record Item;

    begin
        userSetup.Get(UserId);
        Item_Rec.Get(ItemNo);
        Model_Rec.SetRange(DSM, "DSM Code");
        Model_Rec.FindFirst();
        Size_Rec.SetRange("Size Group", Model_Rec."Size Group");
        Size_Rec.FindFirst();

        ItemDistributions.SetRange("Item No", ItemNo);
        //ItemDistributions.SetRange("Model No", Model_Rec.Model);
        ItemDistributions.SetRange("Vendor No", "FG Supplier No.");
        ItemDistributions.FindFirst();
        //create line
        SalesLine.Reset();
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."No.");
        if SalesLine.FindLast() then begin
            if Confirm('Prod. Order Lines found, Do you want to change Item No? \Existing lines will be deleted and new lines will be created.') then
                SalesLine.DeleteAll()
            else
                exit;
        end;

        lineNo := 10000;

        repeat
            SalesLine.Init();
            SalesLine.Validate("Document Type", Rec."Document Type");
            SalesLine.Validate("Document No.", "No.");
            SalesLine.Validate("Line No.", lineNo);
            SalesLine.validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", itemNo);
            SalesLine."Process No." := Item_Rec.Process;
            SalesLine.Insert(true);

            SalesLine.Validate("Shortcut Dimension 1 Code", Size_Rec."Global Dimension 1 Code"); //Size
            Size_Rec.CreateItemVariant(ItemNo, Size_Rec."Global Dimension 1 Code");
            SalesLine.Validate("Variant Code", Size_Rec."Global Dimension 1 Code");  //Size-Variant

            SalesLine.Validate("Unit Cost", ItemDistributions."Item Price");
            SalesLine.Validate("Location Code", userSetup."location Code");
            SalesLine.Modify();
            lineNo := SalesLine."Line No." + 10000;
        until Size_Rec.Next() = 0;
    end;
}
