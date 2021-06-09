pageextension 50045 "Production Order List" extends "Production Order List"
{
    trigger OnOpenPage()
    var
        userSetup: Record "User Setup";
    begin
        userSetup.Get(UserId());
        if not userSetup."Admin User" then begin
            Rec.Setrange("Location Code", userSetup."location Code");
            Rec.FilterGroup(2);
        end;
    end;

}
