Codeunit 70303 "ForNAV Create Check Ledg. Ent."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure CreateCheckLedgerEntry(Args: Record "ForNAV Check Arguments";Check: Record "ForNAV Check";GenJnlLine: Record "Gen. Journal Line")
    var
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
    begin
        if not Args."Test Print" then begin
          with GenJnlLine do begin
            CheckLedgEntry.Init;
            CheckLedgEntry."Bank Account No." := Args."Bank Account No.";
            CheckLedgEntry."Posting Date" := "Posting Date";
            CheckLedgEntry."Document Type" := "Document Type";
            CheckLedgEntry."Document No." := Args."Check No.";
            CheckLedgEntry.Description := Description;
            CheckLedgEntry."Bank Payment Type" := "Bank Payment Type";
            CheckLedgEntry."Bal. Account Type" := Check."Balancing Type";
            CheckLedgEntry."Bal. Account No." := Check."Balancing No.";
            if Check.Amount > 0 then begin
              CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::Printed;
              CheckLedgEntry.Amount := Check.Amount;
            end else begin
              CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::Voided;
              CheckLedgEntry.Amount := 0;
            end;
            CheckLedgEntry."Check Date" := "Posting Date";
            CheckLedgEntry."Check No." := Args."Check No.";
            CheckManagement.InsertCheck(CheckLedgEntry,RecordId);

          end;
        end else
          with GenJnlLine do begin
            CheckLedgEntry.Init;
            CheckLedgEntry."Bank Account No." := Args."Bank Account No.";
            CheckLedgEntry."Posting Date" := "Posting Date";
            CheckLedgEntry."Document No." := Args."Check No.";
            CheckLedgEntry.Description := 'XXXXXX';
            CheckLedgEntry."Bank Payment Type" := "bank payment type"::"Computer Check";
            CheckLedgEntry."Entry Status" := CheckLedgEntry."entry status"::"Test Print";
            CheckLedgEntry."Check Date" := "Posting Date";
            CheckLedgEntry."Check No." := Args."Check No.";
            CheckManagement.InsertCheck(CheckLedgEntry,RecordId);
          end;
    end;
}

