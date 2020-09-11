Codeunit 70013 "ForNAV Check Design Allowed"
{
    // version FORNAV3.2.0.1579/RP2.0.0


    trigger OnRun()
    begin
    end;

    procedure DesignIsAllowed(): Boolean
    var
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        exit(ReportLayoutSelection.WritePermission);
    end;
}

