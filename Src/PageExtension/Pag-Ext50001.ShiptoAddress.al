pageextension 50001 "AYD Ship-to Address" extends "Ship-to Address"
{
    layout
    {
        addlast(General)
        {
            field("AYD SureTax Address Verified"; Rec."AYD SureTax Address Verified")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("AYD SureTax Address Validated"; Rec."AYD SureTax Address Validated")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
}
