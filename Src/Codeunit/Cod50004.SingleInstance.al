codeunit 50004 "AYD Single Instance"
{
    SingleInstance = true;


    procedure SetFromAddressValidation(FromAddressValidationPar: Boolean)
    begin
        FromAddressValidation := FromAddressValidationPar;
    end;

    procedure GetFromAddressValidation(): Boolean
    begin
        exit(FromAddressValidation);
    end;

    var
        FromAddressValidation: Boolean;
}
