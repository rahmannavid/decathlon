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

        }
    }
}
