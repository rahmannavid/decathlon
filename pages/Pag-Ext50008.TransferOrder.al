pageextension 50008 "Transfer Order" extends "Transfer Order"
{
    Caption = 'Purchase Order';
    layout
    {
        addafter("Transfer-to Code")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {

            field("FG Supplier No."; Rec."FG Supplier No.")
            {
                Caption = 'FG Supplier No.';
                ApplicationArea = All;
                Editable = (Rec."Order Status" = Rec."Order Status"::Open);
            }
            field("FG Supplier Name"; Rec."FG Supplier Name")
            {
                Caption = 'FG Supplier Name';
                ApplicationArea = All;
                Editable = false;
            }
            field("DSM Code"; Rec."DSM Code")
            {
                Caption = 'DSM Code';
                ApplicationArea = All;
                Editable = (Rec."Order Status" = Rec."Order Status"::Open);
            }
            field("DSM Name"; Rec."DSM Name")
            {
                Caption = 'DSM Name';
                ApplicationArea = All;
                Editable = false;
            }
            field("Item No"; Rec."Item No.")
            {
                ApplicationArea = All;
                Editable = (Rec."Order Status" = Rec."Order Status"::Open);
            }
            field("Item Name"; Rec."Item Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Planning No."; Rec."Order Planning No.")
            {
                Caption = 'Order Planning No.';
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Purchase Order No."; Rec."Purchase Order No.")
            {
                Caption = 'Purchase Order No.';
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Order Status"; Rec."Order Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Order Type"; Rec."Order Type")
            {
                Editable = false;
            }
            field("Order Tag"; Rec."Order Tag")
            {
                Editable = false;
            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Remaining Qty"; Rec."Remaining Qty")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Requested Receipt Date"; rec."Requested Receipt Date")
            {
                Caption = 'Requested Date';
                ApplicationArea = all;
                Editable = (Rec."Order Status" = Rec."Order Status"::Open);
            }
            field("Promised Receipt Date"; rec."Promised Receipt Date")
            {
                Caption = 'Expected Date';
                ApplicationArea = all;
                Editable = SoleSupEditable;

                trigger OnValidate()
                var
                    UsrSetup: Record "User Setup";
                begin
                    UsrSetup.Get(UserId);
                    if UsrSetup."Admin User" = false then
                        if UsrSetup."Sole Supplier" = '' then
                            Error('You do not have permission to edit this field');

                end;
            }

        }

        addlast(Shipment)
        {
            field("Total Amount Incl. VAT"; Rec."Total Amount")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Shipment Status"; Rec."Shipment Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Received Status"; Rec."Received Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Chalan Nos"; Rec."Chalan Nos")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        addlast(Control19)
        {
            field("Financial Document No."; Rec."Financial Document No.")
            {
                Caption = 'Financial Document No.';
                Editable = true;
            }
        }

        modify("Transfer-from Code")
        {

            Caption = 'Sole Supplier';
        }
        modify("Transfer-to Code")
        {
            Editable = FieldEditable;
            Caption = 'FG Supplier';
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Visible = false;
        }
        moveafter("Shipment Date"; "Receipt Date")
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        moveafter("Shipment Method Code"; "Transport Method")
        moveafter("Transport Method"; "Transaction Specification")
        modify("Area")
        {
            Visible = false;
        }
        modify("Entry/Exit Point")
        {
            Visible = false;
        }
        modify("In-Transit Code")
        {
            Visible = false;
        }
        addafter("Posting Date")
        {
            field("Accepted Date"; Rec."Accepted Date")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        moveafter("Transport Method"; "Transaction Type")
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        moveafter("Shipment Method Code"; "Shipping Advice")

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
                    //Visible = false;
                    //By -sole supplier
                    trigger OnAction()
                    var
                        transLine: Record "Transfer Line";
                    begin
                        UpdateReqPromiseDate();

                        if Rec."Requested Receipt Date" = 0D then
                            Error('Invalid Requested Date');

                        Rec.Testfield(Rec."Order Status", Rec."Order Status"::Open);

                        transLine.Reset();
                        transLine.SetRange("Document No.", Rec."No.");
                        transLine.SetRange(Quantity, 0);
                        if transLine.FindFirst() then
                            Error('Quantity cannot be zero in any line.');

                        Rec.validate("Order Status", Rec."Order Status"::"Released");
                        Rec.Modify();

                    end;
                }
                action("Accepted")
                {
                    //Status = Released

                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        purchHeader: Record "Purchase Header";
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                        userSetup: Record "User Setup";
                    begin

                        userSetup.Get(UserId);

                        //User Validations
                        if userSetup."Admin User" = false then begin
                            if userSetup."Sole Supplier" <> '' then begin
                                if Rec."Order Status" = Rec."Order Status"::"Acceptance Pending" then
                                    Error('Order is pending you can not accept now.');
                            end else
                                if userSetup."Vendor No." <> '' then begin
                                    if Rec."Order Status" <> Rec."Order Status"::"Acceptance Pending" then
                                        Error('You can accept Only pending orders.');
                                end;
                        end;

                        UpdateReqPromiseDate();

                        // if (Rec."Promised Receipt Date" < Today) then
                        //     Error('Invalid Expected Date.');

                        if ((Rec."Requested Receipt Date" + 7) < Rec."Promised Receipt Date") AND (Rec."Order Status" <> Rec."Order Status"::"Acceptance Pending")
                        then begin

                            Rec."Order Status" := Rec."Order Status"::"Acceptance Pending";
                            Rec.Modify();

                        end else begin

                            Rec."Order Status" := Rec."Order Status"::Accepted;
                            rec."Accepted Date" := Today;
                            rec.Modify();

                            ReleaseTransferDoc.Run(Rec);

                        end;

                    end;
                }
                action("Rejected")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        purchHeader: Record "Purchase Header";
                        ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    begin
                        if Rec."Shipment Status" <> Rec."Shipment Status"::"Not Shipped" then
                            Error('Already shipped can not reject now.')
                        else
                            if rec."Receipt Date" < Today then
                                Error('Receipt date all ready in past.');

                        Rec."Order Status" := Rec."Order Status"::Rejected;

                        ReleaseTransferDoc.Reopen(Rec);
                    end;
                }

                action("Re-Open")
                {
                    ApplicationArea = All;
                    //Visible = false;
                    //By -sole supplier
                    trigger OnAction()
                    var
                        userSetup: Record "User Setup";
                    begin
                        if userSetup."Admin User" = false then
                            if userSetup."Sole Supplier" <> '' then
                                Error('You donot have permission to Re-Open Orders.');

                        if (xRec."Order Status" <> xRec."Order Status"::"Released") AND
                                (xRec."Order Status" <> xRec."Order Status"::"Rejected") AND
                                   (xRec."Order Status" <> xRec."Order Status"::"Acceptance Pending") then
                            Error('Order status must be Release or Appeptance Pending or Rejected by Sole Supplier.');

                        Rec.Validate("Order Status", Rec."Order Status"::Open);
                        Rec.Modify();
                    end;
                }


            }
        }

        addafter("&Print")
        {
            action("Print PO")
            {
                Image = PrintDocument;
                trigger OnAction()
                var
                    TransOrder: Record "Transfer Header";
                    PurchaseOrderPrint: Report "Purchase Order Print";
                begin

                    TransOrder.SetRange("No.", Rec."No.");
                    PurchaseOrderPrint.SetTableView(TransOrder);
                    PurchaseOrderPrint.Run();
                    //Report.Run(Report::"Purchase Order Print", true, false, TransOrder);
                end;
            }
        }

        modify("Re&lease")
        {
            Visible = false;
        }
        modify("Reo&pen")
        {
            Visible = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;

            trigger OnBeforeAction()
            begin
                if Rec."Posting Date" <> Today then
                    Error('Posting date must be today.');
                Rec.CalcFields("Order Status");
                if Rec."Order Status" <> Rec."Order Status"::Accepted then
                    Error('Order Status must be Accepted.');
                // if (Rec."Posting Date" > Rec."Promised Receipt Date") AND (Rec."Delay Reason" = '') then
                //     Error('Please mention the delay reason');
            end;

            trigger OnAfterAction()
            begin
                Rec."Delay Reason" := '';
            end;
        }

    }
    //global variable
    var
        FieldEditable: Boolean;
        SoleSupEditable: Boolean;

    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            FieldEditable := false;
            SoleSupEditable := false;
            if userSetup."Sole Supplier" <> '' then
                SoleSupEditable := true;
        end else begin
            FieldEditable := true;
            SoleSupEditable := true;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        TransShipHeader: Record "Transfer Shipment Header";
        PrevCalan: Text;
    begin
        // Rec.CalcFields("Completely Shipped", "Completely Received", "Quantity Shipped", "Quantity Received");
        // if Rec."Completely Shipped" then begin
        //     Rec."Shipment Status" := Rec."Shipment Status"::"Completely Shipped";
        //     Rec.Modify();
        // end else
        //     if Rec."Quantity Shipped" <> 0 then begin
        //         Rec."Shipment Status" := Rec."Shipment Status"::"Partially Shipped";
        //         Rec.Modify();
        //     end;

        // if Rec."Completely Received" then begin
        //     Rec."Received Status" := Rec."Received Status"::"Completely Received";
        //     Rec.Modify();
        // end else
        //     if Rec."Quantity Received" <> 0 then begin
        //         Rec."Received Status" := Rec."Received Status"::"Partially Received";
        //         Rec.Modify();
        //     end;
        TransShipHeader.Reset();
        TransShipHeader.SetRange("Transfer Order No.", Rec."No.");
        if TransShipHeader.FindFirst() then begin
            repeat

                if PrevCalan = '' then
                    PrevCalan += TransShipHeader."External Document No."
                else
                    PrevCalan += ',' + TransShipHeader."External Document No.";

            until TransShipHeader.Next() = 0;

            if PrevCalan <> '' then
                Rec."Chalan Nos" := PrevCalan
            else
                Rec."Chalan Nos" := '-';

            Rec.Modify();
            CurrPage.Update(false);
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        userSetup: Record "User Setup";
        InTransLocation: Record Location;
    begin
        InTransLocation.SetRange("Use As In-Transit", true);
        InTransLocation.FindFirst();

        Rec.Validate("Document Date", Today);
        Rec.Validate("In-Transit Code", InTransLocation.Code);
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Rec.Validate("Transfer-to Code", userSetup."location Code");
            FieldEditable := false;
        end else
            FieldEditable := true;
    end;


    local procedure UpdateReqPromiseDate()
    var
        TransLine: Record "Transfer Line";
    begin
        TransLine.SetRange("Document No.", Rec."No.");
        if TransLine.FindFirst() then begin
            repeat
                if Rec."Requested Receipt Date" < TransLine."Requested Receipt Date" then begin
                    Rec."Requested Receipt Date" := TransLine."Requested Receipt Date";
                    Rec.Modify();
                end;

                if Rec."Promised Receipt Date" < TransLine."Promised Receipt Date" then begin
                    Rec."Promised Receipt Date" := TransLine."Promised Receipt Date";
                    Rec.Modify();
                end;
            until TransLine.Next() = 0;
        end;
    end;


}
