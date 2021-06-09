table 50009 "Order Planning Line"
{
    Caption = 'Order Planning Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(3; "Line Type"; Option)
        {
            Caption = 'Line Type';
            DataClassification = ToBeClassified;
            OptionMembers = "Need by DSM","Need by Model","Need by Size","Need by Item","Item Need by Size","Projected Stock","Stock by Size","Deployable Orders"
                                ,"Deployable Orders by Size","Planned Orders","Planned Order by Size","Firmed Orders","Firmed Order By Size";
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }
        field(7; "Process No."; code[20])
        {
            Caption = 'Process/Size';
            DataClassification = ToBeClassified;
        }
        field(8; "Child Of"; Integer)
        {

        }
        field(9; Initial; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Item No."; code[20])
        {

        }

    }
    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", Rec."Document No.");
        DetailLine.SetRange("Line No", Rec."Line No");
        if DetailLine.FindFirst() then
            DetailLine.DeleteAll();
    end;

}
