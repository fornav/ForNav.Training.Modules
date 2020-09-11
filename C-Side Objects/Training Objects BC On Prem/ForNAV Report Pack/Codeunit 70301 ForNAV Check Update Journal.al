Codeunit 70301 "ForNAV Check Update Journal"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure UpdateJournal(Args: Record "ForNAV Check Arguments";var Check: Record "ForNAV Check";var GenJnlLine: Record "Gen. Journal Line")
    var
        GenJnlLine2: Record "Gen. Journal Line";
        Text013: label '%1 already exists.';
        GenJnlLine3: Record "Gen. Journal Line";
        BankAcc: Record "Bank Account";
        HighestLineNo: Integer;
        BalancingType: Option "G/L Account",Customer,Vendor,"Bank Account";
        Text014: label 'Check for %1 %2';
        Text062: label 'G/L Account,Customer,Vendor,Bank Account';
    begin
        if Args."Test Print" then
          exit;

        with Check do begin
          BankAcc.Get("Bank Account No.");
          BankAcc."Last Check No." := "Check No.";
          BankAcc.Modify;
          if Args."Test Print" then
            exit;
          if "Check No." <> GenJnlLine."Document No." then begin
            GenJnlLine3.Reset;
            GenJnlLine3.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            GenJnlLine3.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
            GenJnlLine3.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
            GenJnlLine3.SetRange("Posting Date",GenJnlLine."Posting Date");
            GenJnlLine3.SetRange("Document No.","Check No.");
            if GenJnlLine3.Find('-') then
              GenJnlLine3.FieldError("Document No.",StrSubstNo(Text013,"Check No."));
          end;

          if "Application Method" <> "application method"::MoreLinesOneEntry then begin
            GenJnlLine3 := GenJnlLine;
            GenJnlLine3.TestField("Posting No. Series",'');
            GenJnlLine3."Document No." := "Check No.";
            GenJnlLine3."Check Printed" := true;
            GenJnlLine3.Modify;
          end else begin
            GenJnlLine2.Reset;
            GenJnlLine2.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            GenJnlLine2.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
            GenJnlLine2.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
            GenJnlLine2.SetRange("Posting Date",GenJnlLine."Posting Date");
            GenJnlLine2.SetRange("Document No.",GenJnlLine."Document No.");
            GenJnlLine2.SetRange("Account Type",GenJnlLine."Account Type");
            GenJnlLine2.SetRange("Account No.",GenJnlLine."Account No.");
            GenJnlLine2.SetRange("Bal. Account Type",GenJnlLine."Bal. Account Type");
            GenJnlLine2.SetRange("Bal. Account No.",GenJnlLine."Bal. Account No.");
            GenJnlLine2.SetRange("Bank Payment Type",GenJnlLine."Bank Payment Type");
            if GenJnlLine2.Find('-') then begin
              HighestLineNo := GenJnlLine2."Line No.";
              repeat
                if GenJnlLine2."Line No." > HighestLineNo then
                  HighestLineNo := GenJnlLine2."Line No.";
                GenJnlLine3 := GenJnlLine2;
                GenJnlLine3.TestField("Posting No. Series",'');
                GenJnlLine3."Bal. Account No." := '';
                GenJnlLine3."Bank Payment Type" := GenJnlLine3."bank payment type"::" ";
                GenJnlLine3."Document No." := "Check No.";
                GenJnlLine3."Check Printed" := true;
                GenJnlLine3.Validate(Amount);
                GenJnlLine3.Modify;
              until GenJnlLine2.Next = 0;
            end;

            GenJnlLine3.Reset;
            GenJnlLine3 := GenJnlLine;
            GenJnlLine3.SetRange("Journal Template Name",GenJnlLine."Journal Template Name");
            GenJnlLine3.SetRange("Journal Batch Name",GenJnlLine."Journal Batch Name");
            GenJnlLine3."Line No." := HighestLineNo;
            if GenJnlLine3.Next = 0 then
              GenJnlLine3."Line No." := HighestLineNo + 10000
            else begin
              while GenJnlLine3."Line No." = HighestLineNo + 1 do begin
                HighestLineNo := GenJnlLine3."Line No.";
                if GenJnlLine3.Next = 0 then
                  GenJnlLine3."Line No." := HighestLineNo + 20000;
              end;
              GenJnlLine3."Line No." := (GenJnlLine3."Line No." + HighestLineNo) DIV 2;
            end;
            GenJnlLine3.Init;
            GenJnlLine3.Validate("Posting Date",GenJnlLine."Posting Date");
            GenJnlLine3."Document Type" := GenJnlLine."Document Type";
            GenJnlLine3."Document No." := "Check No.";
            GenJnlLine3."Account Type" := GenJnlLine3."account type"::"Bank Account";
            GenJnlLine3.Validate("Account No.",BankAcc."No.");
            if BalancingType <> Balancingtype::"G/L Account" then
              GenJnlLine3.Description := StrSubstNo(Text014,SelectStr(BalancingType + 1,Text062),"Balancing No.");
            GenJnlLine3.Validate(Amount,- Amount);
            GenJnlLine3."Bank Payment Type" := GenJnlLine3."bank payment type"::"Computer Check";
            GenJnlLine3."Check Printed" := true;
            GenJnlLine3."Source Code" := GenJnlLine."Source Code";
            GenJnlLine3."Reason Code" := GenJnlLine."Reason Code";
            GenJnlLine3."Allow Zero-Amount Posting" := true;
            GenJnlLine3.Insert;
          end;
        end;
    end;
}

