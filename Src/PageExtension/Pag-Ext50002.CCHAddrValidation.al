pageextension 50002 "AYD CCH Addr. Validation" extends "CCH Addr. Validation"
{
    actions
    {
        modify(Accept)
        {
            trigger OnBeforeAction()
            begin
                SingleInstanceCU.SetFromAddressValidation(true);
            end;

            trigger OnAfterAction()
            begin
                SingleInstanceCU.SetFromAddressValidation(false);
            end;
        }
        modify(Reject)
        {
            trigger OnBeforeAction()
            begin
                SingleInstanceCU.SetFromAddressValidation(true);
            end;

            trigger OnAfterAction()
            begin
                SingleInstanceCU.SetFromAddressValidation(false);
            end;
        }
    }

    var
        SingleInstanceCU: Codeunit "AYD Single Instance";
}
