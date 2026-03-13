pageextension 50000 "AYD Customer Card" extends "Customer Card"
{
    layout
    {
        addafter("SureTax Address Validation")
        {
            field("AYD SureTax Address Verified"; Rec."AYD SureTax Address Verified")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
