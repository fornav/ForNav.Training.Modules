Codeunit 70016 "ForNAV Replace Reports"
{
    // version FORNAV3.2.0.1579/RP2.0.0


    trigger OnRun()
    begin
    end;

    [EventSubscriber(Objecttype::Codeunit, 44, 'OnAfterSubstituteReport', '', false, false)]
    local procedure ForNAVReplaceReports(ReportId: Integer;var NewReportId: Integer)
    var
        ReportReplacement: Record "ForNAV Report Replacement";
    begin
        if ReportReplacement.Get(ReportId, UserId) then begin
          NewReportId := ReportReplacement."Replace-With Report ID";
          exit;
        end;

        if ReportReplacement.Get(ReportId) then begin
          NewReportId := ReportReplacement."Replace-With Report ID";
          exit;
        end;
    end;
}

