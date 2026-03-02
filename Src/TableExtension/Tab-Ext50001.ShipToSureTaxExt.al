tableextension 50001 "AYD ShipToSureTaxExt" extends "Ship-to Address"
{
    fields
    {
        field(50100; "AYD SureTax Address Validated"; Date)
        {
            Caption = 'SureTax Address Validated';
            DataClassification = CustomerContent;
        }

        field(50101; "AYD SureTax Address Verified"; Boolean)
        {
            Caption = 'SureTax Address Verified';
            DataClassification = CustomerContent;
        }
    }
}
