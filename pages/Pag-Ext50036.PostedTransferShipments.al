pageextension 50036 "Posted Transfer Shipments" extends "Posted Transfer Shipments"
{
    layout
    {
        addafter("Transfer-to Code")
        {
            field("Transfer Order No."; Rec."Transfer Order No.")
            {
                Caption = 'PO No.';
            }
            field("External Document No."; Rec."External Document No.")
            { }

        }
    }

    actions
    {
        addafter("&Navigate")
        {
            action("Clear Warehouse Receipt No.")
            {
                trigger OnAction()
                begin
                    Rec."Warehouse Receipt No." := '';
                    Rec.Modify();
                end;
            }
        }
    }
}
