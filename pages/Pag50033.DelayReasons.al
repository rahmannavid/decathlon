page 50033 "Delay Reasons"
{

    ApplicationArea = All;
    Caption = 'Delay Reasons';
    PageType = List;
    SourceTable = "Delay Reasons";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }

}
