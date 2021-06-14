table 50025 "Sole Mold Inventory Header"
{
    Caption = 'Mold Inventory Header';
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Mold Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Mold Description"; Text[150])
        {
            Caption = 'Mold Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Total No of Mold"; Integer)
        {
            Caption = 'Total No of Mold';
            DataClassification = ToBeClassified;
        }
        field(4; "Total No Sub Set"; Integer)
        {
            Caption = 'Total No Sub Set';
            DataClassification = ToBeClassified;
        }
        field(5; "Process Code"; Code[20])
        {
            Caption = 'Process';
            DataClassification = ToBeClassified;
            TableRelation = Process;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Process_rec: Record Process;
            begin
                Process_rec.Get("Process Code");
                "Process Name" := Process_rec."Process Name";
            end;
        }
        field(6; "Process Name"; Text[50])
        {
            Caption = 'Process Name';
            DataClassification = ToBeClassified;
        }
        field(7; Location; Code[10])
        {
            Caption = 'Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(8; "Ext. MMC"; Code[20])
        {
            Caption = 'Ext. MMC';
            DataClassification = ToBeClassified;
        }
        field(9; Active; Boolean)
        {

        }
        field(10; "No. Series"; Code[20])
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
        NoSeriesMgt.InitSeries(PurchSetup."Sole Mold Inventory Nos.", xRec."No. Series", 0D, "No.", "No. Series");
    end;

}
