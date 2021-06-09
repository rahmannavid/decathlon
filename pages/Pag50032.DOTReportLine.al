page 50032 "DOT Report Line"
{

    Caption = 'DOT Report Line';
    PageType = ListPart;
    SourceTable = "Performance Report Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Rec.Indentation;
                IndentationControls = "Report Level";
                ShowAsTree = true;
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                }
                field("Report Level"; Rec."Report Level")
                {
                    ApplicationArea = All;
                }
                field("Report Level Desc."; Rec."Report Level Desc.")
                {
                    ApplicationArea = All;
                }
                field("Order Quantity"; Rec."Order Quantity")
                {
                    ApplicationArea = All;
                }
                field("Shipment Quantity"; Rec."Shipment Quantity")
                {
                    ApplicationArea = All;
                }
                field("Qty Ontime"; Rec."Qty Ontime")
                {
                    ApplicationArea = All;
                    Visible = VisibleOnTime;
                }
                field("Qty Ontime 3 Days"; Rec."Qty Ontime 3 Days")
                {
                    Caption = 'Qty Ontime';
                    ApplicationArea = All;
                    Visible = Visible3Days;
                }
                field("Qty Ontime 7 Days"; Rec."Qty Ontime 7 Days")
                {
                    Caption = 'Qty Ontime';
                    ApplicationArea = All;
                    Visible = Visible7Days;
                }
                field("Delayed Quantity"; Rec."Delayed Quantity")
                {
                    ApplicationArea = All;
                    Visible = VisibleOnTime;
                }
                field("Delayed Quantity 3 Days"; Rec."Delayed Quantity 3 Days")
                {
                    Caption = 'Delayed Quantity';
                    ApplicationArea = All;
                    Visible = Visible3Days;
                }
                field("Delayed Quantity 7 Days"; Rec."Delayed Quantity 7 Days")
                {
                    Caption = 'Delayed Quantity';
                    ApplicationArea = All;
                    Visible = Visible7Days;
                }
                field("HOT %"; Rec."HOT %")
                {
                    ApplicationArea = All;
                    Visible = FieldShowHide;
                }
                field("Future HOT %"; Rec."Future HOT %")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Future Ontime"; Rec."Future Ontime")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Future Delayed Qty 3 Days"; Rec."Future Delayed Qty 3 Days")
                {
                    ApplicationArea = All;
                    Caption = 'Future Delayed';
                    Visible = false;
                }
                field("DOT %"; Rec."DOT %")
                {
                    ApplicationArea = All;
                }
                field("Future DOT%"; Rec."Future DOT%")
                {
                    ApplicationArea = All;
                }


            }
        }
    }

    var
        VisibleOnTime: Boolean;
        Visible3Days: Boolean;
        Visible7Days: Boolean;
        FieldShowHide: Boolean;

    procedure ShoHideColumn(CalcDays: Integer)
    begin
        VisibleOnTime := false;
        Visible3Days := false;
        Visible7Days := false;

        if CalcDays = 0 then
            VisibleOnTime := true
        else
            if CalcDays = 3 then
                Visible3Days := true
            else
                if CalcDays = 7 then
                    Visible7Days := true;
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if not UserSetup."Admin User" then begin
            FieldShowHide := false;
        end
        else begin
            FieldShowHide := true;
        end;
    end;
}
