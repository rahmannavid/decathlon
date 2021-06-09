tableextension 50006 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "FG Supplier No."; Code[20])
        {
            TableRelation = Vendor."No.";
            Caption = 'FG Supplier No.';
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                vendor: Record Vendor;
            begin
                vendor.get("FG Supplier No.");
                "FG Supplier Name" := vendor.Name;
                "Purchase Order No." := 'Select a PO';
            end;
        }
        field(50001; "FG Supplier Name"; Text[100])
        {
            Caption = 'FG Supplier Name';
            DataClassification = ToBeClassified;

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
            begin
                dsm.get("DSM Code");
                "DSM Name" := dsm."DSM Name";

                OrdPlnHeader.SetRange(DSM, "DSM Code");
                OrdPlnHeader.FindFirst();
                "Order Planning No." := OrdPlnHeader."No.";
            end;
        }
        field(50003; "DSM Name"; Text[50])
        {
            Caption = 'DSM Name';
            DataClassification = ToBeClassified;
        }
        field(50004; "Order Planning No."; Code[20])
        {
            Caption = 'Order Planning No.';
            TableRelation = "Order Planning Header"."No.";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                OrdPlnHeader: Record "Order Planning Header";

            begin
                if "Order Planning No." <> '' then
                    OrdPlnHeader.Get("Order Planning No.");

                "DSM Code" := OrdPlnHeader.DSM;
                "DSM Name" := OrdPlnHeader."DSM Name";
            end;
        }
        field(50005; "Order Status"; Option)
        {
            DataClassification = ToBeClassified;

            OptionMembers = New,Issued,Accepted,Paid;

            trigger OnValidate()
            var
                ReleasePurchDoc: Codeunit "Release Purchase Document";
            begin
                if "Order Status" = "Order Status"::Issued then
                    ReleasePurchDoc.PerformManualRelease(Rec)
                else
                    if "Order Status" = "Order Status"::New then
                        ReleasePurchDoc.PerformManualReopen(Rec);

            end;
        }
        field(50006; "Order Type"; Option)
        {
            OptionMembers = "Manual","Auto";
        }
        field(50007; "Order Tag"; Option)
        {
            OptionMembers = "Replenishment","Implantation","Other";
        }

        field(50008; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line".Quantity where("Document No." = field("No.")));
        }
        field(50009; "Item No."; Code[20])
        {
            TableRelation = Item."No." where("FG DSM" = field("DSM Code"));

            trigger OnValidate()
            var
                item: Record Item;
            begin

                TestField("DSM Code");
                if "Item No." <> '' then begin
                    item.get("Item No.");
                    "Item Name" := item.Description;
                    CreatePurLines("Item No.");
                end;

            end;
        }

        field(50010; "Item Name"; text[100])
        {

        }
        field(50011; "Accepted Date"; Date)
        {

        }
        field(50012; "Paied Date"; Date)
        {

        }
        field(50013; "Purchase Order No."; Code[20])   //Transfer Header
        {

            trigger OnLookup()
            var
                transHeader: Record "Transfer Header";
                vendor: Record Vendor;
            begin
                vendor.Get("Buy-from Vendor No.");
                transHeader.SetRange("Transfer-from Code", vendor."Location Code");
                transHeader.SetRange("Order Status", transHeader."Order Status"::Accepted);

                transHeader.CalcFields("Completely Received");
                transHeader.SetRange("Completely Received", true);

                Rec.TestField("Financial Document No.");
                transHeader.SetRange("Financial Document No.", Rec."Financial Document No.");

                transHeader.SetFilter("Invoice No.", '%1', '');
                if transHeader.FindFirst() then begin
                    if PAGE.RunModal(0, transHeader) = ACTION::LookupOK THEN BEGIN
                        Rec.Validate("Purchase Order No.", transHeader."No.");
                    end;
                end else
                    Message('Completed PO not found for current record.');
            end;

            trigger OnValidate()
            var
                transHeader: Record "Transfer Header";
            begin
                if "Purchase Order No." = '' then
                    exit;

                transHeader.Get("Purchase Order No.");
                transHeader."Invoice No." := Rec."No.";
                transHeader.Modify();

                CreateInvLines(transHeader."No.");

                Message('PO %1 has been selected for this invoice.', transHeader."No.");
                "Purchase Order No." := 'SELECT A PO';
            end;
        }
        field(50014; "Financial Document No."; Code[20])
        {
            TableRelation = "LC Informations"."LC No." where("Issued To (Sole)" = field("Location Code"));
        }

    }

    trigger OnDelete()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId);
        if userSetup."Admin User" then begin
            if "Order Status" <> Rec."Order Status"::New then
                Error('Order status must be Open.');
        end else
            Error('You do not have permission to delete this record');
    end;

    local procedure CreatePurLines(ItemNo: code[20])
    var
        PurchaseLine: Record "Purchase Line";
        Model_Rec: Record Model;
        Size_Rec: Record Size;
        ItemDistributions: Record "Item Distributions";
        lineNo: Integer;
        Item_Rec: Record Item;

    begin
        Model_Rec.SetRange(DSM, "DSM Code");
        Model_Rec.FindFirst();
        Size_Rec.SetRange("Size Group", Model_Rec."Size Group");
        Size_Rec.FindFirst();

        Item_Rec.Get(ItemNo);

        ItemDistributions.SetRange("Item No", ItemNo);
        //ItemDistributions.SetRange("Model No", Model_Rec.Model);
        ItemDistributions.SetRange("Vendor No", "FG Supplier No.");
        ItemDistributions.FindFirst();
        //create line
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", "No.");
        if PurchaseLine.FindLast() then begin
            if Confirm('Purchase lines found, Do you want to change Item No? \Existing lines will be deleted and new lines will be created.') then
                PurchaseLine.DeleteAll()
            else
                exit;
        end;

        lineNo := 10000;

        repeat
            PurchaseLine.Init();
            PurchaseLine.validate("Document Type", "Document Type"::Order);
            PurchaseLine.Validate("Document No.", "No.");
            PurchaseLine.Validate("Line No.", lineNo);
            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
            PurchaseLine.Validate("No.", itemNo);
            PurchaseLine.Validate("Process No.", Item_Rec.Process);
            PurchaseLine.Validate("Direct Unit Cost", ItemDistributions."Item Price");

            PurchaseLine.Validate("Shortcut Dimension 1 Code", Size_Rec."Global Dimension 1 Code"); //Size
            Size_Rec.CreateItemVariant(ItemNo, Size_Rec."Global Dimension 1 Code");
            PurchaseLine.Validate("Variant Code", Size_Rec."Global Dimension 1 Code");  //Size-Variant

            PurchaseLine.Insert();
            lineNo := PurchaseLine."Line No." + 10000;
        until Size_Rec.Next() = 0;
    end;


    local procedure CreateInvLines(PONo: code[20])
    var
        PurchaseLine: Record "Purchase Line";
        TransferLine: Record "Transfer Line";
        lineNo: Integer;
        Item_Rec: Record Item;

    begin

        TransferLine.Reset();
        TransferLine.SetRange("Document No.", PONo);
        TransferLine.FindFirst();

        //create line
        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document No.", "No.");
        if PurchaseLine.FindLast() then
            lineNo := PurchaseLine."Line No." + 10000
        else
            lineNo := 10000;

        repeat
            PurchaseLine.Init();
            PurchaseLine.validate("Document Type", "Document Type"::Invoice);
            PurchaseLine.Validate("Document No.", "No.");
            PurchaseLine.Validate("Line No.", lineNo);
            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
            PurchaseLine.Validate("No.", TransferLine."Item No.");
            PurchaseLine.Validate("Process No.", TransferLine."Process No.");
            PurchaseLine.Validate(Quantity, TransferLine.Quantity);
            PurchaseLine.Validate("Unit of Measure", TransferLine."Unit of Measure");
            PurchaseLine.Validate("Direct Unit Cost", TransferLine."Unit Cost");
            PurchaseLine.Validate("Shortcut Dimension 1 Code", TransferLine."Shortcut Dimension 1 Code");
            PurchaseLine.Validate("Variant Code", TransferLine."Shortcut Dimension 1 Code");  //Size-Variant
            PurchaseLine."PO No." := TransferLine."Document No.";
            PurchaseLine.Insert();
            lineNo := PurchaseLine."Line No." + 10000;
        until TransferLine.Next() = 0;
    end;
}
