pageextension 50013 "Transfer Orders" extends "Transfer Orders"
{
    layout
    {
        addafter("Transfer-to Code")
        {

            field("DSM Code40620"; Rec."DSM Code")
            {
                ApplicationArea = All;
            }
            field("DSM Name00279"; Rec."DSM Name")
            {
                ApplicationArea = All;
            }
            field("Item No"; Rec."Item No.")
            {
                ApplicationArea = all;
            }
            field("Item Name"; Rec."Item Name")
            {
                ApplicationArea = all;
            }
            //field(SystemCreatedAt; Format(Rec.SystemCreatedAt, 0, '<Month>/<Day>/<Year4>'))
            field("Document Date"; Rec."Document Date")
            {
                Caption = 'Document Date';
                ApplicationArea = all;
            }
            field("Order Status10862"; Rec."Order Status")
            {
                ApplicationArea = All;
            }
            field("Shipment Status"; Rec."Shipment Status")
            {
                ApplicationArea = All;
            }
            field("Total Quantity"; Rec."Total Quantity")
            {
                ApplicationArea = all;
            }
            field("Remaining Qty"; Rec."Remaining Qty")
            {
                ApplicationArea = All;
            }
            field("Received Status"; Rec."Received Status")
            {
                ApplicationArea = All;
            }
            field("Requested Receipt Date"; Rec."Requested Receipt Date")
            {
                ApplicationArea = All;
            }
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
            {
                Caption = 'Expected Receipt Date';
                ApplicationArea = All;
            }


        }
        addafter("Shipment Date")
        {
            field("Receipt Date1"; Rec."Receipt Date")
            {
                ApplicationArea = all;
            }
        }
        modify("Shipment Date")
        {
            ApplicationArea = all;
            Visible = true;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("In-Transit Code")
        {
            Visible = false;
        }
        modify("Direct Transfer")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
    }
    actions
    {
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = false;
        }
        modify("P&osting")
        {
            Visible = false;
        }
        modify("Re&lease")
        {
            Visible = ActionVisible;
        }
        modify("Reo&pen")
        {
            Visible = ActionVisible;
        }
    }

    var
        ActionVisible: Boolean;


    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        //Filter for users
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            if userSetup."Vendor No." <> '' then begin
                rec.SetFilter("Transfer-to Code", userSetup."location Code");
                Rec.FilterGroup(2);
            end
            else
                if userSetup."Sole Supplier" <> '' then begin
                    rec.SetFilter("Transfer-from Code", userSetup."location Code");
                    Rec.FilterGroup(2);
                end;


            ActionVisible := false;
        end else
            ActionVisible := true;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Completely Shipped", "Completely Received", "Quantity Shipped", "Quantity Received");
        if Rec."Completely Shipped" then
            Rec."Shipment Status" := Rec."Shipment Status"::"Completely Shipped"
        else
            if Rec."Quantity Shipped" <> 0 then
                Rec."Shipment Status" := Rec."Shipment Status"::"Partially Shipped";

        if Rec."Completely Received" then
            Rec."Received Status" := Rec."Received Status"::"Completely Received"
        else
            if Rec."Quantity Received" <> 0 then
                Rec."Received Status" := Rec."Received Status"::"Partially Received";

        Rec.Modify();
    end;
}
