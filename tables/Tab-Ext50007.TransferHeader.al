tableextension 50007 "Transfer Header" extends "Transfer Header"
{
    DataCaptionFields = "Purchase Order No.";

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
        field(50004; "Order Planning No."; Code[20])
        {
            Caption = 'Order Planning No.';
            TableRelation = "Order Planning Header"."No.";
            DataClassification = ToBeClassified;
        }
        field(50005; "Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            TableRelation = "Purchase Header"."No.";
            DataClassification = ToBeClassified;
        }

        field(50006; "Promised Receipt Date"; Date)
        {
            Caption = 'Expected Date';

            trigger OnValidate()
            var
                TransferLine: Record "Transfer Line";
            begin
                TestStatusOpen();

                if "Promised Receipt Date" <> 0D then begin
                    if Rec."Order Status" <> Rec."Order Status"::"Released" then
                        Error('Order status must be Released');

                    if Rec."Requested Receipt Date" > Rec."Promised Receipt Date" then
                        Error('Please enter a valid date.');
                end;

                Rec.validate("Posting Date", "Promised Receipt Date");
                Rec.Validate("Shipment Date", "Promised Receipt Date");
                Rec.Validate("Receipt Date", "Promised Receipt Date");

                TransferLine.SetRange("Document No.", Rec."No.");
                if TransferLine.FindFirst() then
                    TransferLine.ModifyAll("Promised Receipt Date", Rec."Promised Receipt Date", false);
            end;
        }

        field(50007; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Date';

            trigger OnValidate()
            var
                TransferLine: Record "Transfer Line";
            begin
                TestStatusOpen();
                Rec.TestField("Item No.");

                Rec.Validate("Shipment Date", "Requested Receipt Date");
                Rec.Validate("Receipt Date", "Requested Receipt Date");

                if Rec."Promised Receipt Date" = 0D then
                    Rec."Promised Receipt Date" := Rec."Requested Receipt Date";

                TransferLine.SetRange("Document No.", Rec."No.");
                if TransferLine.FindFirst() then begin
                    TransferLine.ModifyAll("Requested Receipt Date", Rec."Requested Receipt Date", false);
                    TransferLine.ModifyAll("Promised Receipt Date", Rec."Requested Receipt Date", false);
                end;


            end;
        }

        field(50008; "Order Status"; Option)
        {
            OptionMembers = "Open","Released","Accepted","Rejected","Closed","Acceptance Pending";
        }
        field(50009; "Accepted Date"; Date)
        {

        }

        field(50010; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line".Quantity where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }

        field(50011; "Shipment Status"; Option)
        {
            OptionMembers = "Not Shipped","Partially Shipped","Completely Shipped";
            //FieldClass = FlowField;
        }

        field(50012; "Received Status"; Option)
        {
            OptionMembers = "Not Received","Partially Received","Completely Received";
        }
        field(50013; "Quantity Shipped"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Quantity Shipped" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }
        field(50014; "Quantity Received"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Quantity Received" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }
        field(20015; "Total Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Line Amount" where("Document No." = field("No."), "Derived From Line No." = const(0)));
        }
        field(50016; "Item No."; Code[20])
        {
            TableRelation = Item."No." where("FG DSM" = field("DSM Code"));

            trigger OnValidate()
            var
                item: Record Item;
                InTransLocation: Record Location;
            begin

                TestField("DSM Code");

                if Rec."In-Transit Code" = '' then begin
                    InTransLocation.SetRange("Use As In-Transit", true);
                    InTransLocation.FindFirst();
                    Rec.validate("In-Transit Code", InTransLocation.Code);
                    Rec.Modify();
                end;

                if "Item No." <> '' then begin
                    item.get("Item No.");
                    "Item Name" := item.Description;
                    "Process No." := item.Process;
                    CreatePurLines("Item No.");
                end;

            end;
        }
        field(50017; "Item Name"; Text[100])
        {
        }
        field(50018; "Remaining Qty"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Transfer Line"."Outstanding Quantity" where("Document No." = field("No.")));
        }
        field(50019; "Delay Reason"; Text[100])
        {
            TableRelation = "Delay Reasons";
            ValidateTableRelation = true;
            trigger OnValidate()
            begin
                if "Posting Date" < "Promised Receipt Date" then
                    Error('Order not delayed.');
            end;
        }
        field(50022; "Order Type"; Option)
        {
            OptionMembers = "Manual","Auto";
        }

        field(50023; "Document Date"; Date)
        {

        }
        field(50024; "Order Tag"; Option)
        {
            OptionMembers = "Replenishment","Implantation","Other";
        }
        field(50025; "Process No."; Code[20])
        {
            Caption = 'Process No.';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;
        }
        field(50026; "Invoice No."; Code[20])
        {
            TableRelation = "Purchase Header"."No.";
        }

        field(50027; "Financial Document No."; Code[20])
        {
            TableRelation = "LC Informations"."LC No." where("Issued By (FG)" = field("Transfer-to Code")
                                                            , "Issued To (Sole)" = field("Transfer-from Code"));
        }

        field(50028; "Chalan Nos"; Text[500])
        {

        }

        modify("Transfer-to Code")
        {
            trigger OnAfterValidate()
            var
                Location: Record Location;
                TransferRoute: Record "Transfer Route";
                InTransLocation: Record Location;
            begin
                if Location.Get("Transfer-from Code") then begin
                    "Transfer-from Name" := Location.Name;
                    "Transfer-from Name 2" := Location."Name 2";
                    "Transfer-from Address" := Location.Address;
                    "Transfer-from Address 2" := Location."Address 2";
                    "Transfer-from Post Code" := Location."Post Code";
                    "Transfer-from City" := Location.City;
                    "Transfer-from County" := Location.County;
                    "Trsf.-from Country/Region Code" := Location."Country/Region Code";
                    "Transfer-from Contact" := Location.Contact;
                end;

                Location.Get("Transfer-to Code");
                Rec.Validate("FG Supplier No.", Location."Default Vendor No.");

                if Rec."In-Transit Code" = '' then begin
                    InTransLocation.SetRange("Use As In-Transit", true);
                    InTransLocation.FindFirst();

                    Rec.Validate("Document Date", Today);
                    Rec.Validate("In-Transit Code", InTransLocation.Code);
                end;
            end;
        }

        modify("Transfer-from Code")
        {
            trigger OnAfterValidate()
            var
                InTransLocation: Record Location;
            begin
                if Rec."In-Transit Code" = '' then begin
                    InTransLocation.SetRange("Use As In-Transit", true);
                    InTransLocation.FindFirst();

                    Rec.Validate("Document Date", Today);
                    Rec.Validate("In-Transit Code", InTransLocation.Code);
                end;
            end;
        }
    }

    trigger OnDelete()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId);
        if userSetup."Admin User" then begin
            if "Order Status" <> Rec."Order Status"::Open then
                Error('Order status must be Open.');
        end else
            Error('You do not have permission to delete this record');
    end;

    trigger OnInsert()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId);
        if userSetup."Sole Supplier" <> '' then begin
            Error('You donot have permission to create transfer order.');
        end;
    end;

    local procedure CreatePurLines(ItemNo: code[20])
    var
        TransferLine: Record "Transfer Line";
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
        TransferLine.Reset();
        TransferLine.SetRange("Document No.", "No.");
        if TransferLine.FindLast() then begin
            if Confirm('Purchase lines found, Do you want to change Item No? \Existing lines will be deleted and new lines will be created.') then
                TransferLine.DeleteAll()
            else
                exit;
        end;

        lineNo := 10000;

        repeat
            TransferLine.Init();
            TransferLine.Validate("Document No.", "No.");
            TransferLine.Validate("Line No.", lineNo);
            TransferLine.Validate("Item No.", itemNo);
            TransferLine.Validate("Process No.", Item_Rec.Process);
            TransferLine.Validate("Unit Cost", ItemDistributions."Item Price");

            TransferLine.Validate("Shortcut Dimension 1 Code", Size_Rec."Global Dimension 1 Code"); //Size
            Size_Rec.CreateItemVariant(ItemNo, Size_Rec."Global Dimension 1 Code");
            TransferLine.Validate("Variant Code", Size_Rec."Global Dimension 1 Code");  //Size-Variant

            TransferLine.Insert();
            lineNo := TransferLine."Line No." + 10000;
        until Size_Rec.Next() = 0;
    end;

}
