page 50005 "Size List"
{

    ApplicationArea = All;
    Caption = 'Size List';
    PageType = List;
    SourceTable = Size;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Size Group"; Rec."Size Group")
                {
                    ApplicationArea = All;
                }
                field(PCB; Rec.PCB)
                {
                    ApplicationArea = All;
                }
                field(Size; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Validate Varient All Doc Lines")
            {
                ApplicationArea = All;
                Visible = ShowHide;

                trigger OnAction()
                var
                    POline: Record "Purchase Line";
                    SOLine: Record "Sales Line";
                    TOLine: Record "Transfer Line";
                    ProdLine: Record "Prod. Order Line";
                    SizeRec: Record Size;
                begin
                    if POline.FindFirst() then
                        repeat
                            if (POline."No." <> '') then begin
                                SizeRec.CreateItemVariant(POline."No.", POline."Shortcut Dimension 1 Code");
                                POline."Variant Code" := POline."Shortcut Dimension 1 Code";
                                POline.Modify(false);
                            end;
                        until POline.Next() = 0;

                    if SOLine.FindFirst() then
                        repeat
                            if (SOLine."No." <> '') then begin
                                SizeRec.CreateItemVariant(SOLine."No.", SOLine."Shortcut Dimension 1 Code");
                                SOLine."Variant Code" := SOLine."Shortcut Dimension 1 Code";
                                SOLine.Modify(false);
                            end;
                        until SOLine.Next() = 0;

                    if TOLine.FindFirst() then
                        repeat
                            if (TOLine."Item No." <> '') then begin
                                SizeRec.CreateItemVariant(TOLine."Item No.", TOLine."Shortcut Dimension 1 Code");
                                TOLine."Variant Code" := TOLine."Shortcut Dimension 1 Code";
                                TOLine.Modify(false);
                            end;
                        until TOLine.Next() = 0;

                    if ProdLine.FindFirst() then
                        repeat
                            if (ProdLine."Item No." <> '') then begin
                                SizeRec.CreateItemVariant(ProdLine."Item No.", ProdLine."Shortcut Dimension 1 Code");
                                ProdLine."Variant Code" := ProdLine."Shortcut Dimension 1 Code";
                                ProdLine.Modify(false);
                            end;
                        until ProdLine.Next() = 0;

                    Message('Done');
                end;
            }
            action("Item Ledger Update")
            {
                Visible = ShowHide;
                trigger OnAction()
                var
                    ItemLedEntry: Record "Item Ledger Entry";
                begin
                    ItemLedEntry.FindFirst();
                    repeat
                        if ItemLedEntry."Global Dimension 1 Code" <> '' then begin
                            ItemLedEntry."Variant Code" := ItemLedEntry."Global Dimension 1 Code";
                            ItemLedEntry.Modify();
                        end;
                    until ItemLedEntry.Next() = 0;
                    Message('Done');
                end;
            }

            action("Value entry Update")
            {
                Visible = ShowHide;
                trigger OnAction()
                var
                    ValueEntry: Record "Value Entry";
                begin
                    ValueEntry.FindFirst();
                    repeat
                        if ValueEntry."Global Dimension 1 Code" <> '' then begin
                            ValueEntry."Variant Code" := ValueEntry."Global Dimension 1 Code";
                            ValueEntry.Modify();
                        end;
                    until ValueEntry.Next() = 0;
                    Message('Done');
                end;
            }

            action("TO Item Update")
            {
                Visible = ShowHide;
                trigger OnAction()
                var
                    TransHeader: Record "Transfer Header";
                    TransferLine: Record "Transfer Line";
                    item: Record Item;
                begin
                    TransHeader.FindFirst();
                    repeat
                        if TransHeader."Item No." = '' then begin
                            TransferLine.SetRange("Document No.", TransHeader."No.");
                            if TransferLine.FindFirst() then begin
                                item.get(TransferLine."Item No.");
                                TransHeader."Item No." := item."No.";
                                TransHeader."Item Name" := item.Description;
                                TransHeader."Process No." := item.Process;
                                TransHeader.Modify();
                            end;
                        end else begin
                            item.get(TransHeader."Item No.");
                            TransHeader."Item No." := item."No.";
                            TransHeader."Item Name" := item.Description;
                            TransHeader."Process No." := item.Process;
                            TransHeader.Modify();
                        end;
                    until TransHeader.Next() = 0;
                    Message('Done');
                end;
            }

            action("TO Status Update")
            {
                trigger OnAction()
                var
                    PurHeader: Record "Purchase Header";
                    TransHeader: Record "Transfer Header";
                begin
                    TransHeader.FindFirst();
                    repeat
                        if TransHeader."Purchase Order No." <> '' then begin
                            PurHeader.SetRange("No.", TransHeader."Purchase Order No.");
                            if PurHeader.FindFirst() then begin
                                TransHeader.Validate("Order Status", PurHeader."Order Status");
                                TransHeader.Modify();
                            end;
                        end;
                    until TransHeader.Next() = 0;
                    Message('Done');
                end;
            }

            action("TO Expect/Req Date Update")
            {
                trigger OnAction()
                var
                    TransHeader: Record "Transfer Header";
                    TransLine: Record "Transfer Line";
                begin
                    TransHeader.FindFirst();
                    repeat
                        TransLine.Reset();
                        TransLine.SetRange("Document No.", TransHeader."No.");
                        if TransLine.FindFirst() then begin
                            repeat
                                if TransLine."Requested Receipt Date" = 0D then
                                    TransLine."Requested Receipt Date" := TransHeader."Requested Receipt Date";
                                if TransLine."Promised Receipt Date" = 0D then
                                    TransLine."Promised Receipt Date" := TransHeader."Promised Receipt Date";
                                TransLine.Modify();
                            until TransLine.Next() = 0;
                        end;
                    until TransHeader.Next() = 0;
                    Message('Done');
                end;
            }
        }
    }
    var
        ShowHide: Boolean;

    trigger OnOpenPage()
    begin
        if UserId <> 'DECATHLON\NAVID' then
            ShowHide := false
        else
            ShowHide := true;
    end;

}
