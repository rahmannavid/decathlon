table 50007 "Item Distributions"
{
    Caption = 'Item Distributions';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No"; Code[20])
        {
            Caption = 'Item No';
            DataClassification = ToBeClassified;
        }
        field(2; "Model No"; Code[20])
        {
            Caption = 'Model No';
            DataClassification = ToBeClassified;
            TableRelation = Model.Model;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                Model_Rec: Record Model;
            begin
                Model_Rec.SetRange(Model, "Model No");
                Model_Rec.FindFirst();
                "Model Name" := Model_Rec."Model Name";
                "DSM Code" := Model_Rec.DSM;
            end;
        }

        field(3; "Model Name"; Text[60])
        {
            Caption = 'Model Name';
            DataClassification = ToBeClassified;
        }
        field(4; "DSM Code"; Code[20])
        {
            Caption = 'DSM Code';
            TableRelation = "DSM (Super Model)";
            ValidateTableRelation = true;
            DataClassification = ToBeClassified;
        }
        field(5; "Sharing Percentage"; Integer)
        {
            Caption = 'Sharing Percentage';
            DataClassification = ToBeClassified;
        }
        field(6; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
            DataClassification = ToBeClassified;
            TableRelation = Model."Vendor No" where(Model = field("Model No"));
            ValidateTableRelation = true;
        }
        field(9; "Sole Supplier"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
            ValidateTableRelation = true;
        }

        field(10; "Supplier Type"; Option)
        {
            OptionMembers = "FG Supplier","Sole Supplier";

        }
        field(11; "Item Price"; Decimal)
        {

        }
        field(12; "DSM Name"; Text[60])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("DSM (Super Model)"."DSM Name" where("DSM Code" = field("DSM Code")));
        }
        field(13; "Vendor Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No")));
        }
        field(14; "Sole Supplier Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Sole Supplier")));
        }
    }
    keys
    {
        key(PK; "Item No", "Model No", "Vendor No", "Sole Supplier", "DSM Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "DSM Code", "DSM Name")
        {

        }
    }

    procedure CreateItemDistribution(DSM_Code: Code[20]; Item_Code: Code[20])
    var
        Model: Record Model;
        ItemDist: Record "Item Distributions";
    begin
        Model.SetRange(DSM, DSM_Code);
        Model.FindFirst();
        repeat
            ItemDist.SetRange("DSM Code", DSM_Code);
            ItemDist.SetRange("Item No", Item_Code);
            ItemDist.SetRange("Model No", Model.Model);
            ItemDist.SetRange("Vendor No", Model."Vendor No");
            if not ItemDist.FindFirst() then begin
                ItemDist.Init();
                ItemDist.Validate("Model No", Model.Model);
                ItemDist."Model Name" := Model."Model Name";
                ItemDist.Validate("DSM Code", DSM_Code);
                ItemDist.Validate("Item No", Item_Code);
                ItemDist.Validate("Vendor No", Model."Vendor No");
                ItemDist.Insert();
            end;
        until (Model.Next() = 0)
    end;

}
