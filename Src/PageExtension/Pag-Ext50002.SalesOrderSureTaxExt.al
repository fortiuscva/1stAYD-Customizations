pageextension 50002 "AYD SalesOrderSureTaxExt" extends "Sales Order"
{
    layout
    {
        modify("Approved by Salesperson")
        {
            trigger OnAfterValidate()
            var
                Cust: Record Customer;
                ShipTo: Record "Ship-to Address";
            begin
                if not Rec."Approved by Salesperson" then
                    exit;

                if Rec."Ship-to Code" <> '' then begin
                    if ShipTo.Get(Rec."Sell-to Customer No.", Rec."Ship-to Code") then begin
                        if not ShipTo."AYD SureTax Address Verified" then
                            Error(
                              'Sure Tax Address is not Validated. Please click on Sell-To and Ship-To Address Validation button on the order.');
                    end;
                end else begin
                    if Cust.Get(Rec."Sell-to Customer No.") then begin
                        if not Cust."AYD SureTax Address Verified" then
                            Error(
                              'Sure Tax Address is not Validated. Please click on Sell-To and Ship-To Address Validation button on the order.');
                    end;
                end;
            end;
        }
    }
}