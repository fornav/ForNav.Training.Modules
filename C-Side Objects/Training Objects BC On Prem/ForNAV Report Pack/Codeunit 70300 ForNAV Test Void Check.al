Codeunit 70300 "ForNAV Test Void Check"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure TestVoidCheck(var GenJnlLn: Record "Gen. Journal Line";var Args: Record "ForNAV Check Arguments";Preview: Boolean): Boolean
    var
        Text000Err: label 'Preview is not allowed.';
        Text001Err: label 'Last Check No. must be filled in.';
        Text002Err: label 'Filters on %1 and %2 are not allowed.', Comment='%1=Field caption for Line No. field.; %2=Field caption for Document No. field.';
        USText004Err: label 'Last Check No. must include at least one digit, so that it can be incremented.';
    begin
        if Preview then
          exit(false);

        if Args."Check No." = '' then
          Error(Text001Err);
        if IncStr(Args."Check No.") = '' then
          Error(USText004Err);
        if Args."Test Print" then
          exit(false);
        if not Args."Reprint Checks" then
          exit(false);
        with GenJnlLn do begin

          if (GetFilter("Line No.") <> '') or (GetFilter("Document No.") <> '') then
            Error(
              Text002Err,FieldCaption("Line No."),FieldCaption("Document No."));

          SetRange("Bank Payment Type", "bank payment type"::"Computer Check");
          SetRange("Check Printed",true);
        end;

        exit(true);
    end;
}

