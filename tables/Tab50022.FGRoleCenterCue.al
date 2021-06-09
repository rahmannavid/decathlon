table 50022 "FG Role Center Cue"
{
    Caption = 'DC Role Center Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Open Purchase Orders"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER(Open),
                                                      "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(3; "Released Orders"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER("Released"),
                                                        "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(4; "Accepted Orders"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER(Accepted), "Shipment Status" = filter("Not Shipped"),
                                                        "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(5; "In Progress Orders"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER(Accepted),
                                                            "Shipment Status" = filter(<> "Not Shipped"),
                                                            "Received Status" = FILTER(<> "Completely Received"),
                                                        "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(6; "Payment Pending Orders"; Integer)
        {
            //CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER("Payment Pending")));
            //FieldClass = FlowField;
        }
        field(7; "Payment in Progress"; Integer)
        {
            //CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER("Paid")));
            //FieldClass = FlowField;
        }
        field(8; "Open Sales Orders"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Open),
                                                      "Location Code" = field("Location Filter")));
            Caption = 'Open Sales Orders';
            FieldClass = FlowField;
        }
        field(9; "Production Orders"; Integer)
        {
            CalcFormula = Count("Production Order" where(Status = filter(Released),
                                                            "Location Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(10; "Finished Prod. Order"; Integer)
        {
            CalcFormula = Count("Production Order" where(Status = filter(Finished),
                                                         "Location Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(11; "YTD Realized Lead Time"; Decimal)
        {

        }
        field(12; "Last Week Realized Lead Time"; Decimal)
        {

        }
        field(13; "Future Lead Time"; Decimal)
        {

        }
        field(14; "Last Week Combined Lead Time"; Decimal)
        {

        }
        field(15; "YTD Combined Lead Time"; Decimal)
        {

        }
        field(16; "Last week HOT%"; Decimal)
        {

        }
        field(17; "YTD HOT%"; Decimal)
        {

        }
        field(18; "Future HOT%"; Decimal)
        {

        }
        field(19; "Last week DOT%"; Decimal)
        {

        }
        field(20; "YTD DOT%"; Decimal)
        {

        }
        field(21; "Future DOT%"; Decimal)
        {

        }
        field(22; "Rejected Orders"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER(Rejected),
                                                         "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }
        field(23; "Location Filter"; Code[20])
        {

        }
        field(24; "FG Suppiler"; Code[20])
        {

        }
        field(26; "Sole Supplier"; Code[20])
        {

        }
        field(27; "Acceptance Pending"; Integer)
        {
            CalcFormula = Count("Transfer Header" WHERE("Order Status" = FILTER("Acceptance Pending"), "Transfer-To Code" = field("Location Filter")));
            FieldClass = FlowField;
        }

    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }

}
