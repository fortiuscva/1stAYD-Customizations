tableextension 50002 "AYD Sales Header" extends "Sales Header"
{
    fields
    {
        modify("Approved by Salesperson")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                ShipTo: Record "Ship-to Address";
            begin
                if SingleInstanceCU.GetFromAddressValidation() then
                    exit;


                if not Rec."Approved by Salesperson" then
                    exit;

                if Rec."Ship-to Code" <> '' then begin
                    if ShipTo.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then begin
                        if not ShipTo."AYD SureTax Address Verified" then
                            Error(StrSubstNo(ShipToCodeAddressNotValidatedMsg, Rec."Ship-to Code"));
                    end;
                end else begin
                    if Cust.Get(Rec."Sell-to Customer No.") then begin
                        if not Cust."AYD SureTax Address Verified" then
                            Error(StrSubstNo(CustomerAddressNotValidatedMsg, Cust."No."));
                    end;
                end;
            end;
        }
        modify("Ship-to Code")
        {
            trigger OnBeforeValidate()
            var
                ShipTo: Record "Ship-to Address";
            begin
                if Rec."Ship-to Code" <> '' then begin
                    if ShipTo.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then begin
                        if not ShipTo."AYD SureTax Address Verified" then
                            Error(StrSubstNo(ShipToCodeAddressNotValidatedMsg, Rec."Ship-to Code"));

                    end;
                end;
            end;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnBeforeValidate()
            var
                Cust: Record Customer;
            begin
                if Cust.Get(Rec."Sell-to Customer No.") then begin
                    if not Cust."AYD SureTax Address Verified" then
                        Error(StrSubstNo(CustomerAddressNotValidatedMsg, Cust."No."));
                end;
            end;
        }
    }
    var
        SingleInstanceCU: Codeunit "AYD Single Instance";
        ShipToCodeAddressNotValidatedMsg: Label 'Sure Tax Address on  is not Validated on Ship-to Address %1. Please click on "Address Validation" on Ship-to Address card.';
        CustomerAddressNotValidatedMsg: Label 'Sure Tax Address is not validated on Customer %1. Please click on “Address Validation” on Customer card.';
}
