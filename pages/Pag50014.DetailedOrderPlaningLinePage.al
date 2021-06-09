page 50014 "Detailed Order Planing Line"
{

    ApplicationArea = All;
    Caption = 'Detailed Order Planing Line Page';
    PageType = List;
    SourceTable = "Detailed Order Planing Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                }
                field("Child Of"; Rec."Child Of")
                {
                    ApplicationArea = All;
                }
                field(Week; Rec.Week)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(SystemId; Rec.SystemId)
                {
                    ApplicationArea = All;
                }

                field("PO Created"; Rec."PO Created")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
