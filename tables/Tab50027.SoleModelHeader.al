table 50027 "Sole Model Header"
{
    Caption = 'Sole Model Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Sole Model Code"; Code[20])
        {
            Caption = 'Sole Model Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Sole Model Description"; Text[100])
        {
            Caption = 'Sole Model Description';
            DataClassification = ToBeClassified;
        }
        field(3; "FG DSM"; Code[20])
        {
            Caption = 'FG DSM';
            DataClassification = ToBeClassified;
            TableRelation = Model.DSM;
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                DSMRec: Record "DSM (Super Model)";
            begin
                DSMRec.Get("FG DSM");
                "FG DSM Desc" := DSMRec."DSM Name";
            end;

        }
        field(4; "FG DSM Desc"; Text[100])
        {
            Caption = 'FG DSM Desc';
            DataClassification = ToBeClassified;
        }
        field(5; "Mold Code"; Code[20])
        {
            Caption = 'Mold Code';
            DataClassification = ToBeClassified;
            TableRelation = "Sole Mold Inventory Header";
            ValidateTableRelation = true;

            trigger OnValidate()
            var
                SoleModel: Record "Sole Model Header";
                MoldRec: Record "Sole Mold Inventory Header";
            begin
                SoleModel.SetRange("Mold Code", Rec."Mold Code");
                if SoleModel.FindFirst() then
                    Error('This mold code is already used in Sole Model: %1', SoleModel."Sole Model Code");

                if "Mold Code" <> '' then begin
                    MoldRec.Get("Mold Code");
                    MoldRec.Active := true;
                    MoldRec.Modify();

                    "Mold Description" := MoldRec."Mold Description";
                    "Process Code" := MoldRec."Process Code";
                    "Process Name" := MoldRec."Process Name";

                end else
                    if xRec."Mold Code" <> '' then begin
                        begin
                            MoldRec.Get(xRec."Mold Code");
                            MoldRec.Active := false;
                            MoldRec.Modify();
                        end;
                    end;
            end;
        }
        field(6; "Mold Description"; Text[100])
        {
            Caption = 'Mold Description';
            DataClassification = ToBeClassified;
        }

        field(8; "Global Std Model"; Boolean)
        {
            Caption = 'Global Std Model';
            DataClassification = ToBeClassified;
        }
        field(9; "Process Code"; Code[20])
        {
            Caption = 'Process	';
            DataClassification = ToBeClassified;
        }
        field(10; "Process Name"; Text[100])
        {
            Caption = 'Process Name';
            DataClassification = ToBeClassified;
        }
        field(7; "EOL Status"; Option)
        {
            Caption = 'EOL Status';
            DataClassification = ToBeClassified;
            OptionMembers = "Running","Planned EOL","EOL";

            trigger OnValidate()
            var

            begin
                if "EOL Status" = "EOL Status"::Running then
                    "EOL Date" := 0D;

            end;
        }
        field(11; "EOL Date"; Date)
        {
            Caption = 'EOL Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var

            begin
                if "EOL Status" = "EOL Status"::Running then
                    Error('EOL Status is Running. EOL Date cannot be changed.')
                else
                    if "EOL Status" = "EOL Status"::"Planned EOL" then begin
                        if "EOL Date" <= Today then
                            Error('EOL date must be in future date');
                    end else
                        if "EOL Status" = "EOL Status"::EOL then
                            Error('EOL Status is EOL. EOL Date cannot be changed.');
            end;
        }
        field(12; "Std Model SMV"; Integer)
        {
            Caption = 'Std Model SMV';
            DataClassification = ToBeClassified;
        }
        field(13; "Ext. Sole DSM"; Code[20])
        {
            Caption = 'Ext. Sole DSM';
            DataClassification = ToBeClassified;
        }
        field(14; "Ext. Sole DSM Description"; Text[100])
        {
            Caption = 'Ext. Sole DSM Description';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Sole Model Code")
        {
            Clustered = true;
        }
    }



}
