table 50008 "Order Planning Header"
{
    Caption = 'Order Planning Header';
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.", "DSM Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Order Date"; Date)
        {
            Caption = 'Order Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Vendor: Record Vendor;
            begin
                Vendor.get("Vendor No.");
                "Vendor Name" := Vendor.Name;
            end;
        }
        field(4; DSM; Code[20])
        {
            Caption = 'DSM';
            DataClassification = ToBeClassified;
            TableRelation = Model.DSM where("Vendor No" = field("Vendor No."));
            ValidateTableRelation = true;

            trigger Onvalidate()
            var
                DSM_Rec: Record "DSM (Super Model)";
                OPHeader: Record "Order Planning Header";
            begin
                if DSM = '' then
                    exit;

                DSM_Rec.Get(DSM);
                "DSM Name" := DSM_Rec."DSM Name";

                TestField("Vendor No.");
                OPHeader.SetRange("Vendor No.", Rec."Vendor No.");
                OPHeader.SetRange(DSM, Rec.DSM);
                if OPHeader.FindFirst() then
                    Error('Purchase Planning already created for this DSM');

            end;
        }
        field(5; DPP; Code[20])
        {
            Caption = 'DPP';
            DataClassification = ToBeClassified;
            TableRelation = "DPP List";
            ValidateTableRelation = true;
        }
        field(6; "This Week"; Code[10])
        {

        }
        field(7; "Last Modified Date"; Date)
        {

        }
        field(8; "Vendor Name"; Text[50])
        {

        }
        field(9; "DSM Name"; text[50])
        {

        }
        field(10; "DPP Name"; Text[50])
        {

        }
        field(11; Status; Option)
        {
            OptionMembers = New,Active,Closed;
        }
        field(12; "No. Series"; code[20])
        {

        }

    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        PurchSetup.Get();
        PurchSetup.TestField("Purchase Planning Nos.");
        NoSeriesMgt.InitSeries(PurchSetup."Purchase Planning Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        rec."Order Date" := Today;
        Rec."Last Modified Date" := Today;
    end;

    trigger OnModify()
    var

    begin
        Rec.TestField(Status, Status::New);
        "Last Modified Date" := Today;
    end;

    trigger OnDelete()
    var
        OrdPlnLine: Record "Order Planning Line";
        DetailOrdPlnLine: Record "Detailed Order Planing Line";

    begin
        TestField(Status, Status::New);
        OrdPlnLine.SetRange("Document No.", "No.");
        if OrdPlnLine.FindFirst() then
            OrdPlnLine.DeleteAll();
        DetailOrdPlnLine.SetRange("Document No.", "No.");
        if DetailOrdPlnLine.FindFirst() then
            DetailOrdPlnLine.DeleteAll();
    end;

}
