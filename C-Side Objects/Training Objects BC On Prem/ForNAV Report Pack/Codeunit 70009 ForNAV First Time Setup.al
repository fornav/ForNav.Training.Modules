Codeunit 70009 "ForNAV First Time Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
        if CheckIfSetupExists then
          exit;

        AskForDefault;
        RunWizardIfSetupDoesNotExist;
    end;

    local procedure CheckIfSetupExists(): Boolean
    var
        Setup: Record "ForNAV Setup";
    begin
        exit(Setup.Get);
    end;

    local procedure AskForDefault()
    var
        SetDefaultsQst: label 'Do you want to setup ForNAV with default values?';
        Setup: Record "ForNAV Setup";
        CheckSetup: Record "ForNAV Check Setup";
    begin
        if not Confirm(SetDefaultsQst, true) then
          exit;

        Setup.InitSetup;
        Setup.CreateWebService;
        Setup.ReplaceReportSelection(true);
        CheckSetup.InitSetup;
        CheckSetup.SetDefault(Setup);
        Commit;
    end;

    local procedure RunWizardIfSetupDoesNotExist()
    var
        Setup: Record "ForNAV Setup";
        SetupWizard: Page "ForNAV Setup Wizard";
    begin
        if Setup.Get then
          exit;

        SetupWizard.RunModal;

        if Setup.Get then
          Commit;
    end;
}

