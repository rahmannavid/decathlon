tableextension 50027 "Item Journal Line" extends "Item Journal Line"
{
    fields
    {
        modify("Order No.")
        {
            TableRelation = IF ("Order Type" = CONST(Production)) "Production Order"."No." WHERE(Status = CONST(Released)
                                                                 , "Location Code" = field("Location Code"));
        }
    }

}
