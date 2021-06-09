tableextension 50000 "Item Table Extension" extends Item
{
    fields
    {
        field(50000; "Sole Model Code"; Code[20])
        {
            Caption = 'Sole Model Code';
        }

        field(50001; "Sole Model Description"; Text[30])
        {
            Caption = 'Sole Model Description';
        }

        field(50002; "Process"; Code[20])
        {
            Caption = 'Process';
            TableRelation = Process;
            ValidateTableRelation = true;
        }
        field(50003; "Process Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Process."Process Name" where("Process Code" = field(Process)));
        }
        field(50007; "Mold_Name"; Code[20])
        {
            Caption = 'Mold Name';
        }
        field(50008; "Compound"; Code[20])
        {
            Caption = 'Compound';
        }
        field(50009; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            TableRelation = "Color Code";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Color_Rec: Record "Color Code";
            begin
                Color_Rec.Get("Color Code");
                "Color Name" := Color_Rec."Color Name";
            end;
        }
        field(50010; "Color Name"; Text[60])
        {
            Caption = 'Color Name';
            Editable = false;
        }
        field(50011; "CNUF"; Code[20])
        {
            Caption = 'CNUF';
            TableRelation = Vendor;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Vendor_Rec: Record Vendor;
            begin
                Vendor_Rec.Get(CNUF);
                "Vendor No." := Vendor_Rec."No.";
            end;

        }
        field(50012; "Supplier"; Code[20])
        {
            Caption = 'Supplier';

        }
        field(50013; "Sharing"; Code[20])
        {
            Caption = 'Sharing';
            //From Vendor Table
        }
        field(50014; "PCB"; Integer)
        {
            Caption = 'PCB';
            //From Vendor Table
        }

        field(50015; "Sole DSM"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "DSM (Super Model)";

            trigger Onvalidate()
            var
                dsm: Record "DSM (Super Model)";
            begin
                dsm.get("Sole DSM");
                "Sole DSM Name" := dsm."DSM Name";
            end;
        }

        field(50016; "Sole DSM Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50017; "FG DSM"; Code[20])
        {
            TableRelation = "DSM (Super Model)";
            DataClassification = ToBeClassified;

            trigger Onvalidate()
            var
                dsm: Record "DSM (Super Model)";
                itemDist: Record "Item Distributions";
            begin
                dsm.get("FG DSM");
                "FG DSM Name" := dsm."DSM Name";
                itemDist.CreateItemDistribution("FG DSM", "No.");
            end;
        }

        field(50018; "FG DSM Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        modify("Lead Time Calculation")
        {
            trigger OnAfterValidate()
            begin
                Validate("Safety Lead Time", "Lead Time Calculation");
            end;
        }


    }



    local procedure CreateItemDistributions(ModelNo: Code[20])
    var
        ItemDistributions_Rec: Record "Item Distributions";
        Model_Rec: Record Model;
    begin
        Model_Rec.SetRange(Model, ModelNo);
        if Model_Rec.FindFirst() then
            repeat
                ItemDistributions_Rec.Init();
                ItemDistributions_Rec."Item No" := "No.";
                ItemDistributions_Rec.Validate("Model No", Model_Rec.Model);
                ItemDistributions_Rec."Vendor No" := Model_Rec."Vendor No";
            Until (Model_Rec.Next() = 0);
    end;
}

