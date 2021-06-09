codeunit 50000 "Order Planning Management"
{
    var

    procedure GeneratePlanningLines(OrderPlanningHeader: Record "Order Planning Header")
    var
        lineNo: Integer;
        OrderPlanningLine: Record "Order Planning Line";
        DMS: Record "DSM (Super Model)";
        Model: Record Model;
        Size: Record Size;
        ItemDistributions: Record "Item Distributions";
        Item: Record Item;
        PrevRecNo: code[20];
        ParrentLineNo1: Integer;
        ParrentLineNo2: Integer;
    begin
        OrderPlanningLine.SetRange("Document No.", OrderPlanningHeader."No.");
        if OrderPlanningLine.FindFirst() then
            OrderPlanningLine.DeleteAll(true);


        //DMS line
        lineNo := 10000;
        DMS.Get(OrderPlanningHeader.DSM);
        OrderPlanningLine.Init();
        OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
        OrderPlanningLine."Line No" := lineNo;
        OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Need by DSM";
        OrderPlanningLine."No." := DMS."DSM Code";
        OrderPlanningLine.Description := DMS."DSM Name";
        OrderPlanningLine.Indentation := 0;
        OrderPlanningLine.Insert();
        ParrentLineNo1 := lineNo;

        //Model Lines
        Model.Reset();
        Model.SetRange(DSM, OrderPlanningHeader.DSM);
        if Model.FindFirst() then
            repeat

                if PrevRecNo <> Model.Model then begin
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Need by Model";
                    OrderPlanningLine."No." := Model.Model;
                    OrderPlanningLine.Description := Model."Model Name";
                    OrderPlanningLine.Indentation := 1;
                    OrderPlanningLine."Child Of" := ParrentLineNo1;
                    OrderPlanningLine.Insert();
                    ParrentLineNo2 := lineNo;


                    //Size Lines
                    Size.Reset();
                    Size.SetRange("Size Group", Model."Size Group");
                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Need by Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'Size ' + Size."Global Dimension 1 Code";
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine.Indentation := 2;
                            OrderPlanningLine."Child Of" := ParrentLineNo2;
                            OrderPlanningLine.Insert();
                        until Size.Next() = 0;
                end;

                PrevRecNo := Model.Model;
            until Model.Next() = 0;


        ItemDistributions.SetRange("DSM Code", OrderPlanningHeader.DSM);
        if ItemDistributions.FindFirst() then
            repeat
                if PrevRecNo <> ItemDistributions."Item No" then begin
                    //Item and Size lines
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Need by Item";
                    OrderPlanningLine."No." := ItemDistributions."Item No";
                    Item.Get(ItemDistributions."Item No");
                    OrderPlanningLine.Description := Item.Description;
                    OrderPlanningLine."Process No." := Item.Process;
                    OrderPlanningLine."Item No." := Item."No.";
                    OrderPlanningLine.Indentation := 0;
                    OrderPlanningLine.Insert();
                    ParrentLineNo1 := lineNo;

                    Model.Reset();
                    Model.SetRange(Model, ItemDistributions."Model No");
                    Model.FindFirst();
                    Size.Reset();
                    Size.SetRange("Size Group", Model."Size Group");
                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Item Need by Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'PCB ' + Format(Size.PCB);
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine."Item No." := Item."No.";
                            OrderPlanningLine.Indentation := 1;
                            OrderPlanningLine."Child Of" := ParrentLineNo1;
                            OrderPlanningLine.Insert();
                        until Size.Next() = 0;

                    //Projected Stock and Size Lines
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Projected Stock";
                    OrderPlanningLine."Item No." := Item."No.";
                    OrderPlanningLine.Indentation := 1;
                    OrderPlanningLine."Child Of" := 0;
                    OrderPlanningLine.Insert();
                    ParrentLineNo2 := lineNo;

                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Stock by Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'Size ' + Size."Global Dimension 1 Code";
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine."Item No." := Item."No.";
                            OrderPlanningLine.Indentation := 2;
                            OrderPlanningLine."Child Of" := ParrentLineNo2;
                            OrderPlanningLine.Insert();
                        until Size.Next() = 0;

                    //Deployable Orders and Size Lines
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Deployable Orders";
                    OrderPlanningLine."Item No." := Item."No.";
                    OrderPlanningLine.Indentation := 1;
                    OrderPlanningLine."Child Of" := 0;
                    OrderPlanningLine.Insert();
                    ParrentLineNo2 := lineNo;

                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Deployable Orders by Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'Size ' + Size."Global Dimension 1 Code";
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine."Item No." := Item."No.";
                            OrderPlanningLine.Indentation := 2;
                            OrderPlanningLine."Child Of" := ParrentLineNo2;
                            OrderPlanningLine.Insert();

                        until Size.Next() = 0;

                    //Planned Orders and Size Lines
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Planned Orders";
                    OrderPlanningLine."Item No." := Item."No.";
                    OrderPlanningLine.Indentation := 1;
                    OrderPlanningLine."Child Of" := 0;
                    OrderPlanningLine.Insert();
                    ParrentLineNo2 := lineNo;


                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Planned Order by Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'Size ' + Size."Global Dimension 1 Code";
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine."Item No." := Item."No.";
                            OrderPlanningLine.Indentation := 2;
                            OrderPlanningLine."Child Of" := ParrentLineNo2;
                            OrderPlanningLine.Insert();

                        until Size.Next() = 0;

                    //Firmed Orders and Size Lines
                    lineNo += 10000;
                    OrderPlanningLine.Init();
                    OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                    OrderPlanningLine."Line No" := lineNo;
                    OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Firmed Orders";
                    OrderPlanningLine."Item No." := Item."No.";
                    OrderPlanningLine.Indentation := 1;
                    OrderPlanningLine."Child Of" := 0;
                    OrderPlanningLine.Insert();
                    ParrentLineNo2 := lineNo;


                    if Size.FindFirst() then
                        repeat
                            lineNo += 10000;
                            OrderPlanningLine.Init();
                            OrderPlanningLine."Document No." := OrderPlanningHeader."No.";
                            OrderPlanningLine."Line No" := lineNo;
                            OrderPlanningLine."Line Type" := OrderPlanningLine."Line Type"::"Firmed Order By Size";
                            OrderPlanningLine."No." := Size."Size Group";
                            OrderPlanningLine.Description := 'Size ' + Size."Global Dimension 1 Code";
                            OrderPlanningLine."Process No." := Size."Global Dimension 1 Code";
                            OrderPlanningLine."Item No." := Item."No.";
                            OrderPlanningLine.Indentation := 2;
                            OrderPlanningLine."Child Of" := ParrentLineNo2;
                            OrderPlanningLine.Insert();

                        until Size.Next() = 0;
                end;
                PrevRecNo := ItemDistributions."Item No";
            until ItemDistributions.Next() = 0;
    end;

    procedure CalcuelateByWeek(OrdPlnDocNo: Code[20]; Week: Date)
    var
        OrdPlnLn: Record "Order Planning Line";
        TotalQty: Decimal;
        OrdPlnLn2: Record "Order Planning Line";
        OrdPlnItem: Record "Order Planning Line";
        PCB: Integer;
        Item_rec: Record Item;
        LeadTime: DateFormula;
        PLeadTime: DateFormula;
        TotalSizeQtyByWeek: Decimal;
        TotalOrdrQtyByWeek: Decimal;
        TotalFirmedOrdrQtyByWeek: Decimal;
        Location_rec: Record Location;
        OrdPlnHeader: Record "Order Planning Header";
        Vendor_rec: Record Vendor;
    begin

        TotalQty := 0;

        OrdPlnHeader.Get(OrdPlnDocNo);
        //Get Lead Time 
        OrdPlnItem.Reset();
        OrdPlnItem.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnItem.SetRange("Line Type", OrdPlnItem."Line Type"::"Need by Item");
        if OrdPlnItem.FindFirst() then
            repeat
                if Item_rec.Get(OrdPlnItem."No.") then
                    LeadTime := Item_rec."Safety Lead Time";

                Evaluate(PLeadTime, '-' + Format(LeadTime));

                //Caculate planed order
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange("Item No.", OrdPlnItem."No.");
                OrdPlnLn.SetRange("Line Type", OrdPlnLn."Line Type"::"Planned Order by Size");
                if OrdPlnLn.FindFirst() then begin
                    repeat
                        TotalSizeQtyByWeek := 0;
                        TotalOrdrQtyByWeek := 0;
                        TotalQty := 0;

                        //total for need by size ..this week
                        OrdPlnLn2.Reset();
                        OrdPlnLn2.SetRange("Document No.", OrdPlnDocNo);
                        OrdPlnLn2.SetRange("Line Type", OrdPlnLn2."Line Type"::"Need by Size");
                        OrdPlnLn2.SetRange("Process No.", OrdPlnLn."Process No.");  //Process No. = Size No
                        if OrdPlnLn2.FindFirst() then
                            repeat
                                TotalSizeQtyByWeek += getTotalQtyforSizeByWeeks(OrdPlnLn2, CALCDATE('<-CW>', WorkDate()), Week);
                            until OrdPlnLn2.Next() = 0;

                        //total Planned order by size this week < this week
                        OrdPlnLn2.Reset();
                        OrdPlnLn2.SetRange("Document No.", OrdPlnDocNo);
                        OrdPlnLn2.SetRange("Item No.", OrdPlnItem."No.");
                        OrdPlnLn2.SetRange("Line Type", OrdPlnLn2."Line Type"::"Planned Order by Size");
                        OrdPlnLn2.SetRange("Process No.", OrdPlnLn."Process No.");  //Process No. = Size No
                        if OrdPlnLn2.FindFirst() then
                            repeat
                                TotalOrdrQtyByWeek += getTotalQtyforSizeByWeeks(OrdPlnLn2, CALCDATE('<-CW>', WorkDate()), Week - 1);
                            until OrdPlnLn2.Next() = 0;

                        //total for need by size ..this week - total for ordered by size < this week - initial(if any)

                        TotalQty := TotalSizeQtyByWeek - TotalOrdrQtyByWeek - getInitialbySize(OrdPlnDocNo, OrdPlnLn."Process No.", Item_rec."No.");

                        //total Firmed order by size this week < this week
                        TotalFirmedOrdrQtyByWeek := 0;
                        OrdPlnLn2.Reset();
                        OrdPlnLn2.SetRange("Document No.", OrdPlnDocNo);
                        OrdPlnLn2.SetRange("Item No.", OrdPlnItem."No.");
                        OrdPlnLn2.SetRange("Line Type", OrdPlnLn2."Line Type"::"Firmed Order by Size");
                        OrdPlnLn2.SetRange("Process No.", OrdPlnLn."Process No.");  //Process No. = Size No
                        if OrdPlnLn2.FindFirst() then
                            repeat
                                TotalFirmedOrdrQtyByWeek += getTotalQtyforSizeByWeeks(OrdPlnLn2, CALCDATE('<-CW>', WorkDate()), Week);
                            until OrdPlnLn2.Next() = 0;

                        if TotalQty > TotalFirmedOrdrQtyByWeek then         //If firmed order has quantity no plan order should be created 
                            UpdateAmount(OrdPlnLn, Week, TotalQty - TotalFirmedOrdrQtyByWeek);

                    until OrdPlnLn.Next() = 0;
                end;

                //Item Need by size calc
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange("Item No.", OrdPlnItem."No.");
                OrdPlnLn.SetRange("Line Type", OrdPlnLn."Line Type"::"Item Need by Size");
                if OrdPlnLn.FindFirst() then
                    repeat
                        TotalQty := 0;
                        OrdPlnLn2.Reset();
                        OrdPlnLn2.SetRange("Document No.", OrdPlnDocNo);
                        OrdPlnLn2.SetRange("Line Type", OrdPlnLn2."Line Type"::"Need by Size");
                        OrdPlnLn2.SetRange("Process No.", OrdPlnLn."Process No.");  //Process No. = Size No
                        if OrdPlnLn2.FindFirst() then
                            repeat
                                TotalQty += getTotalQtyforSizeByWeeks(OrdPlnLn2, Week, Week);
                            until OrdPlnLn2.Next() = 0;
                        PCB := GetPCBbySizeGroup(OrdPlnLn."No.", OrdPlnLn."Process No.");  //Process No. = Size No
                        //TotalQty := Round(TotalQty / PCB, 1, '>') * PCB;
                        UpdateAmount(OrdPlnLn, Week, TotalQty);
                    until OrdPlnLn.Next() = 0;

                //Need by model total calc 
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange("Line Type", OrdPlnLn."Line Type"::"Need by Model");
                if OrdPlnLn.FindFirst() then begin
                    repeat
                        TotalQty := getTotalChildQtyByWeek(OrdPlnLn, Week);
                        UpdateAmount(OrdPlnLn, Week, TotalQty);
                    until OrdPlnLn.Next() = 0;
                end;


                //Item Stock by Size Initial Calc
                Vendor_rec.get(OrdPlnHeader."Vendor No.");
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange("Line Type", OrdPlnLn."Line Type"::"Stock by Size");
                if OrdPlnLn.FindFirst() then begin
                    repeat
                        Item_rec.Get(OrdPlnLn."Item No.");
                        Item_rec.SetFilter("Global Dimension 1 Filter", OrdPlnLn."Process No."); //Size
                        Item_rec.SetFilter("Location Filter", Vendor_rec."Location Code");
                        Item_rec.CalcFields(Inventory);
                        OrdPlnLn.Initial := Item_rec.Inventory;
                        OrdPlnLn.Modify();
                    until OrdPlnLn.Next() = 0;
                end;


                //Label 1 Calc
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange("Item No.", OrdPlnItem."No.");
                OrdPlnLn.SetRange(Indentation, 1);
                OrdPlnLn.SetFilter("Line Type", '<>%1', OrdPlnLn."Line Type"::"Item Need by Size");
                if OrdPlnLn.FindFirst() then begin
                    repeat
                        TotalQty := getTotalChildQtyByWeek(OrdPlnLn, Week);
                        UpdateAmount(OrdPlnLn, Week, TotalQty);
                    until OrdPlnLn.Next() = 0;
                end;

                //Label 0 Calc
                OrdPlnLn.Reset();
                OrdPlnLn.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLn.SetRange(Indentation, 0);
                if OrdPlnLn.FindFirst() then begin
                    repeat
                        TotalQty := getTotalChildQtyByWeek(OrdPlnLn, Week);
                        UpdateAmount(OrdPlnLn, Week, TotalQty);
                    until OrdPlnLn.Next() = 0;
                end;
            until OrdPlnItem.Next() = 0;
    end;

    local procedure getTotalQtyforSizeByWeeks(OrdPlnLn: Record "Order Planning Line"; FromWeek: Date; ToWeek: Date): Decimal
    var
        DtlDrdPlnLn: Record "Detailed Order Planing Line";
        TotalQty: Decimal;
    begin
        DtlDrdPlnLn.Reset();
        DtlDrdPlnLn.SetRange("Document No.", OrdPlnLn."Document No.");
        DtlDrdPlnLn.SetRange("Line No", OrdPlnLn."Line No");
        DtlDrdPlnLn.SetRange(Week, FromWeek, ToWeek);
        if DtlDrdPlnLn.FindFirst() then begin
            TotalQty := 0;
            repeat
                TotalQty += DtlDrdPlnLn.Quantity;
            until DtlDrdPlnLn.Next() = 0;
        end;
        exit(TotalQty);
    end;

    local procedure getTotalChildQtyByWeek(OrdPlnLn: Record "Order Planning Line"; Week: Date): Decimal
    var
        DtlDrdPlnLn: Record "Detailed Order Planing Line";
        TotalQty: Decimal;
    begin
        DtlDrdPlnLn.Reset();
        DtlDrdPlnLn.SetRange("Document No.", OrdPlnLn."Document No.");
        DtlDrdPlnLn.SetRange(Week, Week);
        DtlDrdPlnLn.SetRange("Child Of", OrdPlnLn."Line No");
        if DtlDrdPlnLn.FindFirst() then begin
            TotalQty := 0;
            repeat
                TotalQty += DtlDrdPlnLn.Quantity;
            until DtlDrdPlnLn.Next() = 0;
        end;
        exit(TotalQty);
    end;

    local procedure UpdateAmount(Rec: Record "Order Planning Line"; Week: Date; TotalQty: Decimal)
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", Rec."Document No.");
        DetailLine.SetRange("Line No", Rec."Line No");
        DetailLine.SetRange(Week, Week);
        if DetailLine.FindFirst() then begin
            DetailLine.Quantity := TotalQty;
            DetailLine.Modify();
        end else begin
            DetailLine.Init();
            DetailLine."Document No." := Rec."Document No.";
            DetailLine."Line No" := Rec."Line No";
            DetailLine.Week := Week;
            DetailLine.Quantity := TotalQty;
            DetailLine."Child Of" := Rec."Child Of";
            DetailLine.Insert();
        end;
    end;

    local procedure GetPCBbySizeGroup(SizeGroup: Code[20]; Size: code[20]): Integer
    var
        Size_Rec: Record Size;
    begin
        Size_Rec.Get(SizeGroup, Size);
        exit(Size_Rec.PCB);
    end;

    local procedure getInitialbySize(OrdPlnDocNo: Code[20]; ProcessNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        OrdPlnLine_rec: Record "Order Planning Line";
    begin
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnLine_rec.SetRange("Item No.", ItemNo);
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Stock by Size");
        OrdPlnLine_rec.SetRange("Process No.", ProcessNo);
        OrdPlnLine_rec.FindFirst();
        exit(OrdPlnLine_rec.Initial);
    end;

    procedure CreateFrimedOrders(OrdPlnDocNo: Code[20]; ThisWeek: Date; ItemNo: Code[20])
    var
        OrdPlnLine_rec: Record "Order Planning Line";
        OrdPlnLinePland_rec: Record "Order Planning Line";
        TotalQty: Decimal;
        LastLeadWeekDate: date;
        Item_rec: Record Item;
        LeadTime: DateFormula;
        OrdPlnHeader: Record "Order Planning Header";
        POQty: Decimal;
        PCB: Decimal;
    begin
        TotalQty := 0;
        POQty := 0;

        OrdPlnHeader.Get(OrdPlnDocNo);

        //Get Lead Time 
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnLine_rec.SetRange("Item No.", ItemNo);
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Item");
        if OrdPlnLine_rec.FindFirst() then
            if Item_rec.Get(OrdPlnLine_rec."No.") then
                LeadTime := Item_rec."Safety Lead Time";

        LastLeadWeekDate := CalcDate(LeadTime, ThisWeek);
        LastLeadWeekDate := CalcDate('+1W', LastLeadWeekDate);

        repeat

            //Calculate total firmed order
            OrdPlnLine_rec.Reset();
            OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
            OrdPlnLine_rec.SetRange("Item No.", ItemNo);
            OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Firmed Orders");
            if OrdPlnLine_rec.FindFirst() then begin
                TotalQty := getTotalChildQtyByWeek(OrdPlnLine_rec, ThisWeek);
                if TotalQty > 0 then begin
                    UpdateAmount(OrdPlnLine_rec, ThisWeek, TotalQty);
                    // UpdatePOCreated(OrdPlnLine_rec, ThisWeek, false);
                end;
            end;

            //Delete total Pland order
            OrdPlnLine_rec.Reset();
            OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
            OrdPlnLine_rec.SetRange("Item No.", ItemNo);
            OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Planned Orders");
            if OrdPlnLine_rec.FindFirst() then begin
                TotalQty := 0;
                UpdateAmount(OrdPlnLine_rec, ThisWeek, TotalQty);
            end;

            //Delete total Pland order by Size
            OrdPlnLine_rec.Reset();
            OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
            OrdPlnLine_rec.SetRange("Item No.", ItemNo);
            OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Planned Order by Size");
            if OrdPlnLine_rec.FindFirst() then
                repeat
                    TotalQty := 0;
                    UpdateAmount(OrdPlnLine_rec, ThisWeek, TotalQty);
                until OrdPlnLine_rec.Next() = 0;

            ThisWeek := CalcDate('+1W', ThisWeek);
        until ThisWeek >= LastLeadWeekDate;
    end;

    procedure CalculateProjectedStock(OrdPlnDocNo: Code[20]; ThisWeek: Date; ItemNo: Code[20])
    var
        OrdPlnLineProj_rec: Record "Order Planning Line";
        OrdPlnLine_rec: Record "Order Planning Line";
        TotalNeed: Decimal;
        TotalPlanned: Decimal;
        TotalFirmed: Decimal;
        TotalPrvProj: Decimal;
        totalQty: Decimal;
    begin
        OrdPlnLineProj_rec.Reset();
        OrdPlnLineProj_rec.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnLineProj_rec.SetRange("Item No.", ItemNo);
        OrdPlnLineProj_rec.SetRange("Line Type", OrdPlnLineProj_rec."Line Type"::"Stock by Size");
        if OrdPlnLineProj_rec.FindFirst() then begin
            repeat
                //get total need
                TotalNeed := 0;
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Size");
                OrdPlnLine_rec.SetRange("Process No.", OrdPlnLineProj_rec."Process No.");
                OrdPlnLine_rec.FindFirst();
                repeat
                    TotalNeed += getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek)
                until OrdPlnLine_rec.Next() = 0;

                //get total planned order
                TotalPlanned := 0;
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLine_rec.SetRange("Item No.", ItemNo);
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Planned Order by Size");
                OrdPlnLine_rec.SetRange("Process No.", OrdPlnLineProj_rec."Process No.");
                OrdPlnLine_rec.FindFirst();
                repeat
                    TotalPlanned += getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek)
                until OrdPlnLine_rec.Next() = 0;

                //get total firmed order
                TotalFirmed := 0;
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLine_rec.SetRange("Item No.", ItemNo);
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Firmed Order By Size");
                OrdPlnLine_rec.SetRange("Process No.", OrdPlnLineProj_rec."Process No.");
                OrdPlnLine_rec.FindFirst();
                repeat
                    TotalFirmed += getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek)
                until OrdPlnLine_rec.Next() = 0;

                //get total previous week projected order
                TotalPrvProj := 0;
                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLine_rec.SetRange("Item No.", ItemNo);
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Stock by Size");
                OrdPlnLine_rec.SetRange("Process No.", OrdPlnLineProj_rec."Process No.");
                if OrdPlnLine_rec.FindFirst() then begin
                    repeat
                        TotalPrvProj += getTotalQtyforSizeByWeeks(OrdPlnLine_rec, CalcDate('-1W', ThisWeek), CalcDate('-1W', ThisWeek));
                        if TotalPrvProj = 0 then
                            if OrdPlnLine_rec.Initial <> 0 then
                                TotalPrvProj := OrdPlnLine_rec.Initial;
                    until OrdPlnLine_rec.Next() = 0;
                end;
                if TotalNeed > 0 then
                    TotalQty := TotalPrvProj + TotalFirmed + TotalPlanned - TotalNeed;
                UpdateAmount(OrdPlnLineProj_rec, ThisWeek, TotalQty);
            until OrdPlnLineProj_rec.Next() = 0;
        end;

        //Calculate total proj stock 
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnLine_rec.SetRange("Item No.", ItemNo);
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Projected Stock");
        if OrdPlnLine_rec.FindFirst() then begin
            TotalQty := getTotalChildQtyByWeek(OrdPlnLine_rec, ThisWeek);
            UpdateAmount(OrdPlnLine_rec, ThisWeek, TotalQty);
        end;

    end;


    procedure CreatePO(OrdPlnDocNo: Code[20]; ThisWeek: Date; itemNo: code[20]; ItemDistributions: Record "Item Distributions")
    var
        ordPlnHeader_rec: Record "Order Planning Header";
        OrdPlnLine_rec: Record "Order Planning Line";

        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        lineNo: Integer;
        Qty: Decimal;
        NeedQty: Decimal;
        Item_rec: Record Item;
        LeadTime: DateFormula;
        LastLeadWeekDate: Date;
        PCB: Decimal;
        TotalQty: Decimal;
        POCreated: Boolean;
    begin

        ordPlnHeader_rec.Get(OrdPlnDocNo);

        //Get Lead Time 
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
        OrdPlnLine_rec.SetRange("Item No.", ItemNo);
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Need by Item");
        if OrdPlnLine_rec.FindFirst() then
            if Item_rec.Get(OrdPlnLine_rec."No.") then
                LeadTime := Item_rec."Safety Lead Time";

        //Evaluate(LeadTime, '+4W'); //for test remove later

        LastLeadWeekDate := CalcDate(LeadTime, ThisWeek);
        LastLeadWeekDate := CalcDate('+1W', LastLeadWeekDate);

        repeat
            OrdPlnLine_rec.Reset();
            OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
            OrdPlnLine_rec.SetRange("Item No.", ItemNo);
            //OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Firmed Orders");
            OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Planned Orders");
            OrdPlnLine_rec.FindFirst();
            Qty := getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek);

            //POCreated := isPOCreated(OrdPlnLine_rec, ThisWeek);

            //if (Qty > 0) and (POCreated = false) then begin
            if (Qty > 0) then begin
                PurchSetup.Get();
                PurchaseHeader.Init();
                PurchaseHeader.validate("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseHeader.validate("No.", '');
                PurchaseHeader.validate("Buy-from Vendor No.", ItemDistributions."Sole Supplier");
                PurchaseHeader.Validate("FG Supplier No.", ordPlnHeader_rec."Vendor No.");
                PurchaseHeader.validate("Order Planning No.", ordPlnHeader_rec."No.");
                PurchaseHeader.Validate("DSM Code", ordPlnHeader_rec.DSM);
                PurchaseHeader.Validate("DSM Name", ordPlnHeader_rec."DSM Name");
                PurchaseHeader.Validate("Document Date", ThisWeek);
                PurchaseHeader.Validate("Requested Receipt Date", ThisWeek);
                PurchaseHeader.Validate("Promised Receipt Date", ThisWeek);
                PurchaseHeader."Order Type" := PurchaseHeader."Order Type"::Auto;
                PurchaseHeader."Order Tag" := PurchaseHeader."Order Tag"::Replenishment;
                PurchaseHeader.Insert(true);

                //create line
                PurchaseLine.Reset();
                PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
                if PurchaseLine.FindLast() then
                    lineNo := PurchaseLine."Line No." + 10000
                else
                    lineNo := 10000;

                OrdPlnLine_rec.Reset();
                OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                OrdPlnLine_rec.SetRange("Item No.", ItemNo);
                OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Planned Order By Size");
                if OrdPlnLine_rec.FindFirst() then begin
                    repeat
                        Qty := getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek);

                        if Qty > 0 then begin

                            PurchaseLine.Init();
                            PurchaseLine.validate("Document Type", PurchaseHeader."Document Type"::Order);
                            PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
                            PurchaseLine.Validate("Line No.", lineNo);
                            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
                            PurchaseLine.Validate("No.", itemNo);
                            PurchaseLine.Validate("Shortcut Dimension 1 Code", OrdPlnLine_rec."Process No."); //Size

                            PCB := GetPCBbySizeGroup(OrdPlnLine_rec."No.", OrdPlnLine_rec."Process No.");  //Process No. = Size No
                            TotalQty := Qty * ItemDistributions."Sharing Percentage" / 100;
                            TotalQty := Round(TotalQty / PCB, 1, '>') * PCB;
                            PurchaseLine.Validate(Quantity, TotalQty);

                            PurchaseLine.Validate("Direct Unit Cost", ItemDistributions."Item Price");
                            PurchaseLine.Insert();
                            lineNo := PurchaseLine."Line No." + 10000;

                            updateFirmedOrder(OrdPlnLine_rec, ThisWeek, TotalQty);
                        end;
                    until OrdPlnLine_rec.Next() = 0;
                end;

                //Mark as po created or this firm order
                // OrdPlnLine_rec.Reset();
                // OrdPlnLine_rec.SetRange("Document No.", OrdPlnDocNo);
                // OrdPlnLine_rec.SetRange("Item No.", ItemNo);
                // OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Firmed Orders");
                // OrdPlnLine_rec.FindFirst();
                // UpdatePOCreated(OrdPlnLine_rec, ThisWeek, true);
            end;

            ThisWeek := CalcDate('+1W', ThisWeek);
        until ThisWeek >= LastLeadWeekDate;

    end;

    local procedure updateFirmedOrder(PlanedOrderLine: Record "Order Planning Line"; ThisWeek: Date; TotalQty: Decimal)
    var
        OrdPlnLine_rec: Record "Order Planning Line";
    begin
        //Calculate total firmed order
        OrdPlnLine_rec.Reset();
        OrdPlnLine_rec.SetRange("Document No.", PlanedOrderLine."Document No.");
        OrdPlnLine_rec.SetRange("Item No.", PlanedOrderLine."Item No.");
        OrdPlnLine_rec.SetRange("Process No.", PlanedOrderLine."Process No.");
        OrdPlnLine_rec.SetRange("Line Type", OrdPlnLine_rec."Line Type"::"Firmed Order By Size");
        if OrdPlnLine_rec.FindFirst() then begin
            TotalQty := TotalQty + getTotalQtyforSizeByWeeks(OrdPlnLine_rec, ThisWeek, ThisWeek);
            UpdateAmount(OrdPlnLine_rec, ThisWeek, TotalQty);
        end;
    end;

    local procedure GetTotalPOQty(FromDate: date; Todate: date; vendorNo: Code[20]; ItemNo: code[20]; size: Code[20]) Qty: Decimal
    var
        POHeader: Record "Purchase Header";
        POLine: Record "Purchase Line";
    begin
        Clear(Qty);
        POHeader.Reset();
        POHeader.SetRange("Promised Receipt Date", FromDate, Todate);
        POHeader.SetRange("Buy-from Vendor No.", vendorNo);
        if POHeader.FindFirst() then begin
            repeat
                POLine.Reset();
                POLine.SetRange("Document Type", POHeader."Document Type");
                POLine.SetRange("Document No.", POHeader."No.");
                POLine.SetRange("No.", ItemNo);
                POLine.SetRange("Shortcut Dimension 1 Code", size);
                Qty += POLine.Quantity;
            until POHeader.Next() = 0;
        end;
        exit(Qty)
    end;

    local procedure isPOCreated(OrdPlnLine: Record "Order Planning Line"; WeekDay: Date): Boolean
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", OrdPlnLine."Document No.");
        DetailLine.SetRange("Line No", OrdPlnLine."Line No");
        DetailLine.SetRange(Week, WeekDay);
        if DetailLine.FindFirst() then begin
            eXIT(DetailLine."PO Created");
        end;
        exit(false);
    end;

    procedure UpdatePOCreated(OrdPlnLine: Record "Order Planning Line"; WeekDay: Date; Created: boolean)
    var
        DetailLine: Record "Detailed Order Planing Line";
    begin
        DetailLine.Reset();
        DetailLine.SetRange("Document No.", OrdPlnLine."Document No.");
        DetailLine.SetRange("Line No", OrdPlnLine."Line No");
        DetailLine.SetRange(Week, WeekDay);
        if DetailLine.FindFirst() then begin
            DetailLine."PO Created" := Created;
            DetailLine.Modify();
        end;
    end;

}
