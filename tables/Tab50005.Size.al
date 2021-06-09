table 50005 Size
{
    Caption = 'Size';
    DataClassification = ToBeClassified;
    LookupPageId = "Size List";

    fields
    {
        field(1; "Size Group"; Code[20])
        {
            Caption = 'Size Group';
            DataClassification = ToBeClassified;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(3; PCB; Integer)
        {
            Caption = 'PCB';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Size Group", "Global Dimension 1 Code")
        {
            Clustered = true;
        }
    }

    procedure GetLocationsIncludingUnspecifiedLocation()
    var
        Size: Record Size;
    begin
        Init;
        //Validate(Name, UnspecifiedLocationLbl);
        Insert;
        if Size.FindSet then
            repeat
                Reset();
                SetRange(Rec."Global Dimension 1 Code", Size."Global Dimension 1 Code");
                if not FindFirst() then begin
                    Init;
                    Copy(Size);
                    Insert;
                end;
            until Size.Next = 0;


        FindFirst;
    end;

    // procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    // var
    //     DimMgt: Codeunit DimensionManagement;
    // begin
    //     DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    //     if not IsTemporary then begin
    //         DimMgt.SaveDefaultDim(DATABASE::Size, "Size Group", FieldNumber, ShortcutDimCode);
    //         Modify;
    //     end;
    // end;

    procedure CreateItemVariant(ItemNo: Code[20]; Size: Code[10])
    var
        ItemVariant: Record "Item Variant";
        Item_Rec: Record Item;
    begin
        ItemVariant.SetRange(Code, Size);
        ItemVariant.SetRange("Item No.", ItemNo);
        if not ItemVariant.FindFirst() then begin
            Item_Rec.Get(ItemNo);
            ItemVariant.Init();
            ItemVariant.Validate(Code, Size);
            ItemVariant.Validate("Item No.", ItemNo);
            ItemVariant.Validate(Description, Item_Rec.Description + ', Size-' + Size);
            ItemVariant.Insert();
        end;
    end;

}
