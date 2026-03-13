tableextension 50000 "AYD Customer" extends Customer
{
    fields
    {
        field(50066; "AYD SureTax Address Verified"; Boolean)
        {
            Caption = 'SureTax Address Verified';
            DataClassification = CustomerContent;
        }
    }
}
