table 50026 "Sole Mold Inventory Line"
{
    Caption = 'Sole Mold Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Mold Set Code"; Code[20])
        {
            Caption = 'Mold Set Code';
            DataClassification = ToBeClassified;
            //Mold Code from Header & " - "  & Mold Owner Short Letter & " - " & Mold Set 
        }
        field(4; "Mold Set Description"; Text[100])
        {
            Caption = 'Mold Set Description';
            DataClassification = ToBeClassified;
            //Mold Description from Header & " - "  & Mold Owner Short Letter & " - " & Mold Set 
        }
        field(5; "Mold Sub Set Code"; Code[20])
        {
            Caption = 'Mold Sub Set Code';
            DataClassification = ToBeClassified;
            //Mold Set Code & " - " &  Size & Sub Set Code
        }
        field(6; "Mold Sub Set Description"; Text[100])
        {
            Caption = 'Mold Sub Set Description';
            DataClassification = ToBeClassified;
            //Mold Set Description& " - " &  Size & Sub Set Code
        }
        field(7; "Mold No"; Code[20])
        {
            Caption = 'Mold No';
            DataClassification = ToBeClassified;
        }
        field(8; "Mold Description"; Text[100])
        {
            Caption = 'Mold Description';
            DataClassification = ToBeClassified;
        }
        field(9; "Mold Provider"; Code[10])
        {
            Caption = 'Mold Provider';
            DataClassification = ToBeClassified;
        }
        field(10; "Mold Location"; Code[10])
        {
            Caption = 'Mold Location';
            DataClassification = ToBeClassified;
            TableRelation = Location;
            ValidateTableRelation = true;
        }
        field(11; "Ownership of Mold"; Code[10])
        {
            Caption = 'Ownership of Mold';
            DataClassification = ToBeClassified;
            TableRelation = Location;
            ValidateTableRelation = true;
        }
        field(12; "Mold Set No"; Code[10])
        {
            Caption = 'Mold Set No';
            DataClassification = ToBeClassified;
        }
        field(13; Size; Code[10])
        {
            Caption = 'Size';
            DataClassification = ToBeClassified;
        }
        field(14; "Mold Sub Set ID"; Code[10])
        {
            Caption = 'Mold Sub Set ID';
            DataClassification = ToBeClassified;
        }
        field(15; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = "OK","NOK","CON";
        }
        field(16; "Ext. MIC"; Code[20])
        {
            Caption = 'Ext. MIC';
            DataClassification = ToBeClassified;
        }
        field(17; "Active"; Boolean)
        {

        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key1; "Mold Set No")
        {

        }
    }


    procedure UpdateTexts(MoldInvHeader: Record "Sole Mold Inventory Header")
    var
        location: Record Location;
        MoldInvLine: Record "Sole Mold Inventory Line";
    begin
        MoldInvLine.SetRange("Document No.", MoldInvHeader."No.");
        if MoldInvLine.FindFirst() then begin
            repeat
                if location.Get(MoldInvLine."Ownership of Mold") then begin
                    MoldInvLine."Mold Set Code" := MoldInvHeader."No." + '-' + location."Name 2" + '-' + MoldInvLine."Mold Set No";
                    MoldInvLine."Mold Set Description" := MoldInvHeader."Mold Description" + '-' + location."Name 2" + '-' + MoldInvLine."Mold Set No";
                    MoldInvLine."Mold Sub Set Code" := MoldInvLine."Mold Set Code" + '-' + MoldInvLine.Size + MoldInvLine."Mold Sub Set ID";
                    MoldInvLine."Mold Sub Set Description" := MoldInvLine."Mold Set Description" + '-' + MoldInvLine.Size + MoldInvLine."Mold Sub Set ID";
                end else begin
                    MoldInvLine."Mold Set Code" := MoldInvHeader."No." + '-D-' + MoldInvLine."Mold Set No";
                    MoldInvLine."Mold Set Description" := MoldInvHeader."Mold Description" + '-D-' + MoldInvLine."Mold Set No";
                    MoldInvLine."Mold Sub Set Code" := MoldInvLine."Mold Set Code" + '-' + MoldInvLine.Size + MoldInvLine."Mold Sub Set ID";
                    MoldInvLine."Mold Sub Set Description" := MoldInvLine."Mold Set Description" + '-' + MoldInvLine.Size + MoldInvLine."Mold Sub Set ID";
                end;
                MoldInvLine.Modify();
            until MoldInvLine.Next() = 0;
        end;
    end;
}
