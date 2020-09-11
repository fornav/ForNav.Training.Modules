Codeunit 70302 "ForNAV Create Stub"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure FromCheck(Args: Record "ForNAV Check Arguments";var Check: Record "ForNAV Check";var Stub: Record "ForNAV Stub";GenJnlLine: Record "Gen. Journal Line")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        FoundLast: Boolean;
        FoundNegative: Boolean;
        RemainingAmount: Decimal;
    begin
        InitCode(Args, Check, GenJnlLine, CustLedgerEntry, VendorLedgerEntry, FoundLast, FoundNegative);
        RemainingAmount := Check.Amount;
        RepeatCode(Args, Check, Stub, GenJnlLine, CustLedgerEntry, VendorLedgerEntry, FoundLast, RemainingAmount, FoundNegative);
    end;

    local procedure InitCode(Args: Record "ForNAV Check Arguments";Check: Record "ForNAV Check";GenJnlLine: Record "Gen. Journal Line";var CustLedgEntry: Record "Cust. Ledger Entry";var VendLedgEntry: Record "Vendor Ledger Entry";var FoundLast: Boolean;var FoundNegative: Boolean)
    begin
        if not Args."Test Print" then
          if true then begin
            FoundLast := true;
            case Check."Application Method" of
              Check."application method"::OneLineOneEntry:
                FoundLast := false;
              Check."application method"::OneLineID:
                case Check."Balancing Type" of
                  Check."balancing type"::Customer:
                    begin
                      CustLedgEntry.Reset;
                      CustLedgEntry.SetCurrentkey("Customer No.",Open,Positive);
                      CustLedgEntry.SetRange("Customer No.",Check."Balancing No.");
                      CustLedgEntry.SetRange(Open,true);
                      CustLedgEntry.SetRange(Positive,true);
                      CustLedgEntry.SetRange("Applies-to ID",GenJnlLine."Applies-to ID");
                      FoundLast := not CustLedgEntry.Find('-');
                      if FoundLast then begin
                        CustLedgEntry.SetRange(Positive,false);
                        FoundLast := not CustLedgEntry.Find('-');
                        FoundNegative := true;
                      end else
                        FoundNegative := false;
                    end;
                  Check."balancing type"::Vendor:
                    begin
                      VendLedgEntry.Reset;
                      VendLedgEntry.SetCurrentkey("Vendor No.",Open,Positive);
                      VendLedgEntry.SetRange("Vendor No.",Check."Balancing No.");
                      VendLedgEntry.SetRange(Open,true);
                      VendLedgEntry.SetRange(Positive,true);
                      VendLedgEntry.SetRange("Applies-to ID",GenJnlLine."Applies-to ID");
                      FoundLast := not VendLedgEntry.Find('-');
                      if FoundLast then begin
                        VendLedgEntry.SetRange(Positive,false);
                        FoundLast := not VendLedgEntry.Find('-');
                        FoundNegative := true;
                      end else
                        FoundNegative := false;
                    end;
                end;
              Check."application method"::MoreLinesOneEntry:
                FoundLast := false;
            end;
          end
        else
          FoundLast := false;
    end;

    local procedure RepeatCode(Args: Record "ForNAV Check Arguments";Check: Record "ForNAV Check";var Stub: Record "ForNAV Stub";GenJnlLine: Record "Gen. Journal Line";var CustLedgEntry: Record "Cust. Ledger Entry";var VendLedgEntry: Record "Vendor Ledger Entry";var FoundLast: Boolean;var RemainingAmount: Decimal;FoundNegative: Boolean)
    var
        LineAmount2: Decimal;
        CurrentLineAmount: Decimal;
        GenJnlLine2: Record "Gen. Journal Line";
        Text016: label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: label 'must not be activated when Applies-to ID is specified in the journal lines.';
    begin
        if Check."Application Method" = Check."application method"::MoreLinesOneEntry then
          GetGenJnlLnForMoreLinesOneEntry(GenJnlLine, GenJnlLine2);

        repeat
          if not Args."Test Print" then begin
            if FoundLast then begin
              if RemainingAmount <> 0 then begin
                Stub."Document No." := '';
                Stub."External Document No." := '';
                Stub.Amount := RemainingAmount;
                LineAmount2 := RemainingAmount;
                CurrentLineAmount := LineAmount2;
                Stub."Discount Amount" := 0;
                Stub."Currency Code" := GenJnlLine."Currency Code";
                Stub.Insert;
                RemainingAmount := 0;
              end else
                exit;
            end else begin
              case Check."Application Method" of
                Check."application method"::OneLineOneEntry:
                  begin
                    case Check."Balancing Type" of
                      Check."balancing type"::Customer:
                        begin
                          CustLedgEntry.Reset;
                          CustLedgEntry.SetCurrentkey("Document No.");
                          CustLedgEntry.SetRange("Document Type",GenJnlLine."Applies-to Doc. Type");
                          CustLedgEntry.SetRange("Document No.",GenJnlLine."Applies-to Doc. No.");
                          CustLedgEntry.SetRange("Customer No.",Check."Balancing No.");
                          CustLedgEntry.Find('-');
                          Stub.CustUpdateAmounts(CustLedgEntry,RemainingAmount,LineAmount2);
                        end;
                      Check."balancing type"::Vendor:
                        begin
                          VendLedgEntry.Reset;
                          VendLedgEntry.SetCurrentkey("Document No.");
                          VendLedgEntry.SetRange("Document Type",GenJnlLine."Applies-to Doc. Type");
                          VendLedgEntry.SetRange("Document No.",GenJnlLine."Applies-to Doc. No.");
                          VendLedgEntry.SetRange("Vendor No.",Check."Balancing No.");
                          VendLedgEntry.Find('-');
                          Stub.VendUpdateAmounts(VendLedgEntry,RemainingAmount,LineAmount2);
                        end;
                    end;
                    RemainingAmount := RemainingAmount - LineAmount2;
                    CurrentLineAmount := LineAmount2;
                    FoundLast := true;
                  end;
                Check."application method"::OneLineID:
                  begin
                    case Check."Balancing Type" of
                      Check."balancing type"::Customer:
                        begin
                          Stub."Currency Code" := GenJnlLine."Currency Code";
                          Stub.CustUpdateAmounts(CustLedgEntry,RemainingAmount,LineAmount2);
                          FoundLast := (CustLedgEntry.Next = 0) or (RemainingAmount <= 0);
                          if FoundLast and not FoundNegative then begin
                            CustLedgEntry.SetRange(Positive,false);
                            FoundLast := not CustLedgEntry.Find('-');
                            FoundNegative := true;
                          end;
                        end;
                      Check."balancing type"::Vendor:
                        begin
                          Stub."Currency Code" := GenJnlLine."Currency Code";
                          Stub.VendUpdateAmounts(VendLedgEntry,RemainingAmount,LineAmount2);
                          FoundLast := (VendLedgEntry.Next = 0) or (RemainingAmount <= 0);
                          if FoundLast and not FoundNegative then begin
                            VendLedgEntry.SetRange(Positive,false);
                            FoundLast := not VendLedgEntry.Find('-');
                            FoundNegative := true;
                          end;
                        end;
                    end;
                    RemainingAmount := RemainingAmount - LineAmount2;
                    CurrentLineAmount := LineAmount2
                  end;
                Check."application method"::MoreLinesOneEntry:
                  begin
                    CurrentLineAmount := GenJnlLine2.Amount;
                    LineAmount2 := CurrentLineAmount;
                    if GenJnlLine2."Applies-to ID" <> '' then
                      Error(
                        Text016 +
                        Text017);
                    GenJnlLine2.TestField("Check Printed",false);
                    GenJnlLine2.TestField("Bank Payment Type",GenJnlLine2."bank payment type"::"Computer Check");
                    if GenJnlLine2."Applies-to Doc. No." = '' then begin
                      Stub."Document No." := '';
                      Stub."External Document No." := '';
                      Stub.Amount := CurrentLineAmount;
                      Stub."Discount Amount" := 0;
                      Stub."Currency Code" := GenJnlLine."Currency Code";
                      Stub.Insert;
                    end else begin
                      case Check."Balancing Type" of
                        Check."balancing type"::"G/L Account":
                          begin
                            Stub."Document No." := GenJnlLine2."Document No.";
                            Stub."External Document No." := GenJnlLine2."External Document No.";
                            Stub.Amount := CurrentLineAmount;
                            Stub."Discount Amount" := 0;
                            Stub."Currency Code" := GenJnlLine."Currency Code";
                            Stub.Insert;
                          end;
                        Check."balancing type"::Customer:
                          begin
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetCurrentkey("Document No.");
                            CustLedgEntry.SetRange("Document Type",GenJnlLine2."Applies-to Doc. Type");
                            CustLedgEntry.SetRange("Document No.",GenJnlLine2."Applies-to Doc. No.");
                            CustLedgEntry.SetRange("Customer No.",Check."Balancing No.");
                            CustLedgEntry.Find('-');
                            Stub."Currency Code" := GenJnlLine."Currency Code";
                            Stub.CustUpdateAmounts(CustLedgEntry,CurrentLineAmount,LineAmount2);
                            Stub.Amount := CurrentLineAmount;
                          end;
                        Check."balancing type"::Vendor:
                          begin
                            VendLedgEntry.Reset;
                            VendLedgEntry.SetCurrentkey("Document No.");
                            VendLedgEntry.SetRange("Document Type",GenJnlLine2."Applies-to Doc. Type");
                            VendLedgEntry.SetRange("Document No.",GenJnlLine2."Applies-to Doc. No.");
                            VendLedgEntry.SetRange("Vendor No.",Check."Balancing No.");
                            VendLedgEntry.Find('-');
                            Stub."Currency Code" := GenJnlLine."Currency Code";
                            Stub.VendUpdateAmounts(VendLedgEntry,CurrentLineAmount,LineAmount2);
                            Stub.Amount := CurrentLineAmount; // WTF??
                          end;
                        Check."balancing type"::"Bank Account":
                          begin
                            Stub."Document No." := GenJnlLine2."Document No.";
                            Stub."External Document No." := GenJnlLine2."External Document No.";
                            Stub.Amount := CurrentLineAmount;
                            Stub."Discount Amount" := 0;
                            Stub."Currency Code" := GenJnlLine."Currency Code";
                            Stub.Insert;
                          end;
                      end;
                    end;
                    FoundLast := GenJnlLine2.Next = 0;
                  end;
              end;
            end;
          end else begin
            if FoundLast then
              exit;
            FoundLast := true;
            Stub."Document No." := 'XXXXXXXXXX';
            Stub."External Document No." := 'XXXXXXXXXX';
            Stub.Amount := 0;
            Stub."Discount Amount" := 0;
            Stub."Currency Code" := GenJnlLine."Currency Code";
            Stub.Insert;
          end;
        until FoundLast;
    end;

    local procedure GetGenJnlLnForMoreLinesOneEntry(GenJnlLine: Record "Gen. Journal Line";var GenJnlLine2: Record "Gen. Journal Line")
    begin
        with GenJnlLine do begin

          GenJnlLine2.Reset;
          GenJnlLine2.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
          GenJnlLine2.SetRange("Journal Template Name","Journal Template Name");
          GenJnlLine2.SetRange("Journal Batch Name","Journal Batch Name");
          GenJnlLine2.SetRange("Posting Date","Posting Date");
          GenJnlLine2.SetRange("Document No.","Document No.");
          GenJnlLine2.SetRange("Account Type","Account Type");
          GenJnlLine2.SetRange("Account No.","Account No.");
          GenJnlLine2.SetRange("Bal. Account Type","Bal. Account Type");
          GenJnlLine2.SetRange("Bal. Account No.","Bal. Account No.");
          GenJnlLine2.SetRange("Bank Payment Type","Bank Payment Type");
          GenJnlLine2.Find('-');
        end;
    end;
}

