pageextension 50030 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Default Customer"; rec."Default Customer")
            {
                ApplicationArea = all;
            }
        }
    }
}
