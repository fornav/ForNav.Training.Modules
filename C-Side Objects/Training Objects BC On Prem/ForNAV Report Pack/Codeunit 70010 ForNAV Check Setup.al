Codeunit 70010 "ForNAV Check Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2018 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    TableNo = "ForNAV Setup";

    trigger OnRun()
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CreateCheckSetupRecord(CheckSetup);
        SetCheckType(Rec, CheckSetup);
    end;

    procedure CreateCheckSetupRecord(var CheckSetup: Record "ForNAV Check Setup")
    begin
        CheckSetup.InitSetup;
    end;

    procedure SetCheckType(Setup: Record "ForNAV Setup";var CheckSetup: Record "ForNAV Check Setup")
    begin
        with Setup do begin
          case "VAT Report Type" of
            "vat report type"::"N/A. (Sales Tax)":
              if CheckSetup.Layout = CheckSetup.Layout::" " then
                CheckSetup.Validate(Layout, CheckSetup.Layout::"Check-Stub-Stub");
            else
              CheckSetup.Validate(Layout, CheckSetup.Layout::" ");
          end;

          CheckSetup.Modify;
        end;
    end;
}

