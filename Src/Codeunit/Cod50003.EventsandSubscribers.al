codeunit 50003 "AYD Events and Subscribers"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'GetDatabaseTableTriggerSetup', '', false, false)]
    local procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean)
    begin
        if TableId = Database::"customer" then begin
            OnDatabaseInsert := true;
            OnDatabaseModify := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::GlobalTriggerManagement, 'OnBeforeOnDatabaseModify', '', false, false)]
    local procedure GlobalTriggerManagement_OnBeforeOnDatabaseModify(RecRef: RecordRef)
    var
        TableID: Integer;
        SureTaxAddrValidFieldRef: FieldRef;
        AYDSureTaxAddrVerFieldRec: FieldRef;
        TodayDate: Date;
        AYDSureTaxAddrVerified: Boolean;
        FromAddressValidation: Boolean;
    begin
        FromAddressValidation := SingleInstanceCU.GetFromAddressValidation();
        //Error('%1', FromAddressValidation);
        //if FromAddressValidation then begin
        TodayDate := Today;
        TableID := RecRef.Number;
        if TableID = Database::Customer then begin
            if (Format(RecRef.Field(14083551).Value) = 'Yes') then begin
                AYDSureTaxAddrVerified := true;
                SureTaxAddrValidFieldRef := RecRef.Field(50014);
                SureTaxAddrValidFieldRef.Value(TodayDate);

                AYDSureTaxAddrVerFieldRec := RecRef.Field(50066);
                AYDSureTaxAddrVerFieldRec.Value(AYDSureTaxAddrVerified);
                //RecRef.Modify(false);
            end else begin
                AYDSureTaxAddrVerified := false;
                AYDSureTaxAddrVerFieldRec := RecRef.Field(50066);
                AYDSureTaxAddrVerFieldRec.Value(AYDSureTaxAddrVerified);
                //RecRef.Modify(false);
            end;
        end;
        //end;
    end;

    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    // local procedure CustomerOnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    // begin
    //     if not RunTrigger then
    //         exit;

    //     if (Rec.Address = '') then
    //         exit;

    //     //if AddressChangedCustomer(Rec, xRec) then begin
    //     Rec."AYD SureTax Address Verified" := false;
    //     Rec.Modify(false);

    //     if Rec."CCH Validated" then begin
    //         Rec."SureTax Address Validation" := WorkDate();
    //         Rec."AYD SureTax Address Verified" := true;
    //         Rec.Modify(false);
    //     end;
    //     //end;
    // end;


    // [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', false, false)]
    // local procedure CustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    // begin
    //     if not RunTrigger then
    //         exit;

    //     if AddressChangedCustomer(Rec, xRec) then begin
    //         Rec."AYD SureTax Address Verified" := false;
    //         Clear(Rec."SureTax Address Validation");

    //         if Rec."SureTax Address Validation" = 0D then begin
    //             Rec."SureTax Address Validation" := WorkDate();
    //             Rec."AYD SureTax Address Verified" := true;
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnBeforeModifyEvent', '', false, false)]
    // local procedure ShipToOnBeforeModify(var Rec: Record "Ship-to Address"; var xRec: Record "Ship-to Address"; RunTrigger: Boolean)
    // begin
    //     if not RunTrigger then
    //         exit;

    //     if AddressChangedShipTo(Rec, xRec) then begin
    //         Rec."AYD SureTax Address Verified" := false;
    //         Clear(Rec."AYD SureTax Address Validated");

    //         if Rec."AYD SureTax Address Validated" = 0D then begin
    //             Rec."AYD SureTax Address Validated" := WorkDate();
    //             Rec."AYD SureTax Address Verified" := true;
    //         end;
    //     end;
    // end;

    local procedure AddressChangedCustomer(Rec: Record Customer; xRec: Record Customer): Boolean
    begin
        exit(
            (Rec.Address <> xRec.Address) or
            (Rec."Address 2" <> xRec."Address 2") or
            (Rec.City <> xRec.City) or
            (Rec."Post Code" <> xRec."Post Code") or
            (Rec.County <> xrec.County) or
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
            (Rec.County <> xrec.County) or
            (Rec."Country/Region Code" <> xRec."Country/Region Code")
        );
    end;

    var
        SingleInstanceCU: Codeunit "AYD Single Instance";

}