pageextension 50007 "Purchase Order" extends "Purchase Order"
{
    layout
    {

        addlast(General)
        {

            field("FG Supplier No."; Rec."FG Supplier No.")
            {
                Caption = 'Vendor No';
                ApplicationArea = All;
                Editable = FieldEditable;

            }
            field("FG Supplier Name"; Rec."FG Supplier Name")
            {
                Caption = 'Vendor Name';
                ApplicationArea = All;
                Editable = false;

            }
            field("DSM Code"; Rec."DSM Code")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    OrdPlnHeader: Record "Order Planning Header";
                begin
                    OrdPlnHeader.SetRange(DSM, Rec."DSM Code");
                    if OrdPlnHeader.FindFirst() then begin
                        Rec."Order Planning No." := OrdPlnHeader."No.";
                    end;
                end;

            }
            field("DSM Name"; Rec."DSM Name")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Item No"; Rec."Item No.")
            {
                ApplicationArea = All;
            }
            field("Item Name"; Rec."Item Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Tag"; rec."Order Tag")
            {
                ApplicationArea = All;
            }
            field("Order Planning No."; Rec."Order Planning No.")
            {
                ApplicationArea = All;

            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = All;
            }
            field("Order Status"; Rec."Order Status")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }

        //Move
        moveafter("Requested Receipt Date"; "Expected Receipt Date")
        moveafter("Order Status"; "Document Date")
        //moveafter("Total Quantity"; "Buy-from Contact")

        //Modify
        modify("Promised Receipt Date")
        {
            Caption = 'Expected eceipt Date';
        }
        modify("Buy-from Contact")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Editable = FieldEditable;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Sole Supplier';
        }

        modify("Vendor Invoice No.")
        {
            Importance = Additional;
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("VAT Bus. Posting Group")
        {
            Importance = Additional;
        }
        modify("Prices Including VAT")
        {
            Importance = Additional;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }

        modify("Shortcut Dimension 2 Code")
        {
            Importance = Additional;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Importance = Additional;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Entry Point")
        {
            Importance = Additional;
        }
        modify("Area")
        {
            Importance = Additional;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Compress Prepayment")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Visible = false;
        }
        modify("Prepayment Due Date")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Discount %")
        {
            Visible = false;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Vendor Cr. Memo No.")
        {
            Visible = false;
        }

        modify("Requested Receipt Date")
        {
            trigger OnAfterValidate()
            begin
                Rec."Promised Receipt Date" := Rec."Requested Receipt Date";
            end;
        }

    }
    actions
    {

        addlast(processing)
        {
            group("Change Order Status")
            {
                action("Released")
                {
                    ApplicationArea = All;


                    //By -sole supplier
                    trigger OnAction()
                    var
                        PurLine: Record "Purchase Line";
                    begin
                        rec.TestField("Requested Receipt Date");

                        PurLine.Reset();
                        PurLine.SetRange("Document Type", PurLine."Document Type"::Order);
                        PurLine.SetRange("Document No.", Rec."No.");
                        PurLine.SetRange(Quantity, 0);
                        if PurLine.FindFirst() then
                            Error('Lines with zero quantity can not be releasd.');

                        //Rec.validate("Order Status", Rec."Order Status"::Release);
                        Rec.Modify();

                        //New transer order will be created
                        CreateTransferOrder(Rec);
                    end;
                }
                action("Accepted")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnAction()
                    var

                    begin
                        // if xRec."Order Status" <> xRec."Order Status"::Release then
                        //     Error('Order status must be Release.');
                        // Rec."Order Status" := Rec."Order Status"::"Accepted";
                        Rec.Modify();
                    end;
                }
                action("Rejected")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var

                    begin
                        // if xRec."Order Status" <> xRec."Order Status"::Release then
                        //     Error('Order status must be Release.');
                        // Rec."Order Status" := Rec."Order Status"::"Rejected";
                        Rec.Modify();
                    end;
                }
                action("Payment Pending")  //Shipped
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnAction()
                    var

                    begin
                        // if xRec."Order Status" <> xRec."Order Status"::"Accepted" then
                        //     Error('Order status must be Accepted by Sole Supplier.');
                        // Rec."Order Status" := Rec."Order Status"::"Payment Pending";
                        Rec.Modify();
                    end;
                }
                action("Paid")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var

                    begin
                        // if xRec."Order Status" <> xRec."Order Status"::"Payment Pending" then
                        //     Error('Order status must be Payment Pending.');
                        Rec."Order Status" := Rec."Order Status"::Paid;
                        Rec."Paied Date" := Today;
                        Rec.Modify();
                    end;
                }
                action("Closed")
                {
                    ApplicationArea = All;
                    Visible = false;

                    //By -sole supplier
                    trigger OnAction()
                    var

                    begin
                        if xRec."Order Status" <> xRec."Order Status"::Paid then
                            Error('Order status must be Paid.');
                        //Rec."Order Status" := Rec."Order Status"::Closed;
                        Rec.Modify();
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = All;

                    //By -fg supplier
                    trigger OnAction()
                    var

                    begin
                        // if (xRec."Order Status" <> xRec."Order Status"::Release) AND
                        //         (xRec."Order Status" <> xRec."Order Status"::"Rejected") then
                        //     Error('Order must be Released or Rejected by Sole Supplier.');

                        //Rec.Validate("Order Status", Rec."Order Status"::Open);
                        Rec.Modify();
                    end;
                }

            }
        }

        modify(Action13)
        {
            Visible = false;
        }
        modify(Release)
        {
            Visible = false;
        }
        modify(Reopen)
        {
            Visible = false;
        }

    }

    //global variable
    var
        FieldEditable: Boolean;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        Rec."Order Date" := Today;

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

    trigger OnAfterGetRecord()
    begin
        //Filter for users
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
        locationVar: Record Location;
        vendorVar: Record Vendor;
    begin
        Rec."Order Date" := Today;

        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if vendorVar.Get(userSetup."Vendor No.") then
                Rec.Validate("FG Supplier No.", userSetup."Vendor No.");
            if locationVar.Get(userSetup."location Code") then
                rec.validate("Location Code", userSetup."location Code");
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;

    local procedure CreateTransferOrder(PurHeader: Record "Purchase Header")
    var
        TransHeader: Record "Transfer Header";
        TransLine: Record "Transfer Line";
        SoleSupplier: Record Vendor;
        FGSupplier: Record Vendor;
        PurLine: Record "Purchase Line";
        lineNo: Integer;
        InTransLocation: Record Location;
    begin
        SoleSupplier.get(PurHeader."Buy-from Vendor No.");
        FGSupplier.Get(PurHeader."FG Supplier No.");

        InTransLocation.SetRange("Use As In-Transit", true);
        InTransLocation.FindFirst();

        TransHeader.Reset();
        TransHeader.Setrange("Purchase Order No.", PurHeader."No.");
        if TransHeader.FindFirst() then begin
            //Modify exixtng
            TransHeader.validate("Transfer-from Code", SoleSupplier."Location Code");
            TransHeader.Validate("Transfer-to Code", FGSupplier."Location Code");
            TransHeader.Validate("Posting Date", WorkDate());
            TransHeader.Validate("In-Transit Code", InTransLocation.Code);
            TransHeader.Validate("FG Supplier No.", FGSupplier."No.");
            TransHeader.Validate("DSM Code", PurHeader."DSM Code");
            TransHeader."Purchase Order No." := PurHeader."No.";
            TransHeader."Order Planning No." := PurHeader."Order Planning No.";
            TransHeader."Promised Receipt Date" := PurHeader."Promised Receipt Date";
            TransHeader."Requested Receipt Date" := PurHeader."Requested Receipt Date";
            TransHeader.Modify();

            TransLine.SetRange("Document No.", TransHeader."No.");
            if TransLine.FindFirst() then
                TransLine.DeleteAll();

            lineNo := 10000;
            PurLine.Reset();
            PurLine.SetRange("Document Type", PurLine."Document Type"::Order);
            PurLine.SetRange("Document No.", PurHeader."No.");
            if PurLine.FindFirst() then
                repeat
                    if PurLine.Type = PurLine.Type::Item then begin
                        TransLine.Init();
                        TransLine.validate("Document No.", TransHeader."No.");
                        TransLine."Line No." := lineNo;
                        TransLine.Validate("Item No.", PurLine."No.");
                        TransLine.Validate("Shortcut Dimension 1 Code", PurLine."Shortcut Dimension 1 Code");
                        TransLine.Validate("Variant Code", PurLine."Variant Code");
                        TransLine.Validate("Unit of Measure Code", PurLine."Unit of Measure Code");
                        TransLine.validate(Quantity, PurLine.Quantity);
                        TransLine.Insert(true);
                        lineNo += 10000;
                    end;
                until (PurLine.Next() = 0);

        end
        else begin
            //Create new
            TransHeader.Init();
            TransHeader."No." := '';
            TransHeader.validate("Transfer-from Code", SoleSupplier."Location Code");
            TransHeader.Validate("Transfer-to Code", FGSupplier."Location Code");
            TransHeader.Validate("Posting Date", WorkDate());
            TransHeader.Validate("In-Transit Code", InTransLocation.Code);
            TransHeader.Validate("FG Supplier No.", FGSupplier."No.");
            TransHeader.Validate("DSM Code", PurHeader."DSM Code");
            TransHeader."Purchase Order No." := PurHeader."No.";
            TransHeader."Order Planning No." := PurHeader."Order Planning No.";
            TransHeader."Promised Receipt Date" := PurHeader."Promised Receipt Date";
            TransHeader."Requested Receipt Date" := PurHeader."Requested Receipt Date";

            if TransHeader.Insert(true) then begin
                lineNo := 10000;
                PurLine.Reset();
                PurLine.SetRange("Document Type", PurLine."Document Type"::Order);
                PurLine.SetRange("Document No.", PurHeader."No.");
                if PurLine.FindFirst() then
                    repeat
                        if PurLine.Type = PurLine.Type::Item then begin
                            TransLine.Init();
                            TransLine.validate("Document No.", TransHeader."No.");
                            TransLine."Line No." := lineNo;
                            TransLine.Validate("Item No.", PurLine."No.");
                            TransLine."Process No." := PurLine."Process No.";
                            TransLine."Shortcut Dimension 1 Code" := PurLine."Shortcut Dimension 1 Code";
                            TransLine.Validate("Unit of Measure Code", PurLine."Unit of Measure Code");
                            TransLine.validate(Quantity, PurLine.Quantity);
                            TransLine."Unit Cost" := PurLine."Unit Cost";
                            TransLine."Line Amount" := PurLine."Line Amount";
                            TransLine.Insert(true);
                            lineNo += 10000;
                        end;
                    until (PurLine.Next() = 0);
            end;
        end;
        Message('Transfer order generated with ID: %1', TransHeader."No."); // my naem  
    end;
}
