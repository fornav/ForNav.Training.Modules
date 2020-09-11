Codeunit 70015 "ForNAV Assisted Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0


    trigger OnRun()
    begin
    end;

    [EventSubscriber(Objecttype::Table, 1808, 'OnRegisterAssistedSetup', '', false, false)]
    local procedure AddForNAVWizard(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        ForNAVSetup: Record "ForNAV Setup";
    begin
        with TempAggregatedAssistedSetup do
          AddExtensionAssistedSetup(Page::"ForNAV Setup Wizard", ForNAVSetup.TableCaption, true, ForNAVSetup.RecordId, GetSetupStatus, '');
    end;

    [EventSubscriber(Objecttype::Table, 1808, 'OnUpdateAssistedSetupStatus', '', false, false)]
    local procedure UpdateForNAVSetupStatus(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    begin
        with TempAggregatedAssistedSetup do
          Status := GetSetupStatus;
    end;

    local procedure GetSetupStatus(): Integer
    var
        AggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary;
        ForNAVSetup: Record "ForNAV Setup";
    begin
        with AggregatedAssistedSetup do begin
          if ForNAVSetup.IsEmpty then
            exit(Status::"Not Started");

          exit(Status::Completed);
        end;
    end;
}

