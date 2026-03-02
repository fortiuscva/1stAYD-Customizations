pageextension 50000 "AYD CustomerCardSureTaxExt" extends "Customer Card"
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
