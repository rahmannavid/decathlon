pageextension 50042 "Posted Whse. Shipment" extends "Posted Whse. Shipment"
{
    layout
    {
        addlast(General)
        {
            field("PO No."; Rec."PO No.")
            {

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Shipment Date" <> Rec."Posting Date" then begin
            Rec."Shipment Date" := Rec."Posting Date";
            Rec.Modify();
        end;
    end;
}
