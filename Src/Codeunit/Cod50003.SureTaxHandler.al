codeunit 50003 "AYD SureTaxHandler"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', false, false)]
    local procedure CustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    begin
        if AddressChangedCustomer(Rec, xRec) then begin

            if xRec."SureTax Address Validation" = 0D then begin
                Rec."SureTax Address Validation" := WorkDate();
                Rec."AYD SureTax Address Verified" := true;
            end
            else begin
                Rec."SureTax Address Validation" := 0D;
                Rec."AYD SureTax Address Verified" := false;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnBeforeModifyEvent', '', false, false)]
    local procedure ShipToOnBeforeModify(var Rec: Record "Ship-to Address"; var xRec: Record "Ship-to Address"; RunTrigger: Boolean)
    begin
        if AddressChangedShipTo(Rec, xRec) then begin

            if xRec."AYD SureTax Address Validated" = 0D then begin
                Rec."AYD SureTax Address Validated" := WorkDate();
                Rec."AYD SureTax Address Verified" := true;
            end
            else begin
                Rec."AYD SureTax Address Validated" := 0D;
                Rec."AYD SureTax Address Verified" := false;
            end;
        end;
    end;

    local procedure AddressChangedCustomer(Rec: Record Customer; xRec: Record Customer): Boolean
    begin
        exit(
            (Rec.Address <> xRec.Address) or
            (Rec."Address 2" <> xRec."Address 2") or
            (Rec.City <> xRec.City) or
            (Rec."Post Code" <> xRec."Post Code") or
            (Rec."Country/Region Code" <> xRec."Country/Region Code")
        );
    end;

    local procedure AddressChangedShipTo(Rec: Record "Ship-to Address"; xRec: Record "Ship-to Address"): Boolean
    begin
        exit(
            (Rec.Address <> xRec.Address) or
            (Rec."Address 2" <> xRec."Address 2") or
            (Rec.City <> xRec.City) or
            (Rec."Post Code" <> xRec."Post Code") or
            (Rec."Country/Region Code" <> xRec."Country/Region Code")
        );
    end;
}