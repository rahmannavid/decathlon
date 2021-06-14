pageextension 50020 "Purchases & Payables Setup" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Purchase Planning Nos."; rec."Purchase Planning Nos.")
            {
                ApplicationArea = all;
            }
            field("Sole Mold Inventory Nos."; Rec."Sole Mold Inventory Nos.")
            {
                ApplicationArea = all;
            }
            field("Sole Model Nos."; Rec."Sole Model Nos.")
            {
                ApplicationArea = all;
            }

        }
    }
}
