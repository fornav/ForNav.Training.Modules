Codeunit 70221 "ForNAV Vendor Aging"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    var
        TempVendorLedgerEntry: Record "Vendor Ledger Entry" temporary;

    procedure GetAging(var Vend: Record Vendor;var AgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.")
    var
        CurrAgingBuffer: Record "ForNAV Aging Buffer" temporary;
        TempCurrency: Record Currency temporary;
    begin
        GetAgingWithCurrency(Vend, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
    end;

    procedure GetAgingWithCurrency(var Vend: Record Vendor;var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.";var TempCurrency: Record Currency temporary)
    begin
        ClearData(AgingBuffer);
        GetBasedOnDetailedEntry(Vend, Args);
        GetBasedOnOpenEntry(Vend, Args);
        CreateAgingBuffer(Vend, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
        AgingBuffer.SetCaptions(Args);
    end;

    local procedure GetBasedOnDetailedEntry(var Vend: Record Vendor;var Args: Record "ForNAV Aged Accounts Args.")
    var
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        with DetailedVendorLedgEntry do begin
          SetCurrentkey("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
          SetRange("Vendor No.", Vend."No.");
          SetRange("Entry Type", DetailedVendorLedgEntry."entry type"::Application);
          SetRange("Posting Date", 0D, Args."Ending Date");
          SetFilter("Posting Date", '%1..', Args."Ending Date" + 1);

          if FindSet then repeat
            if VendorLedgerEntry.Get("Vendor Ledger Entry No.") then
              if VendorLedgerEntry.Open then begin
                VendorLedgerEntry.SetRange("Date Filter",0D, Args."Ending Date");
                VendorLedgerEntry.CalcFields("Remaining Amount");
                if VendorLedgerEntry."Remaining Amount" <> 0 then
                  InsertTemp(VendorLedgerEntry);
            end;
          until Next = 0;
        end;
    end;

    local procedure GetBasedOnOpenEntry(var Vend: Record Vendor;var Args: Record "ForNAV Aged Accounts Args.")
    var
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        with VendorLedgerEntry do begin
          SetCurrentkey("Vendor No.", Open, Positive, "Due Date", "Currency Code");
          SetRange("Vendor No.", Vend."No.");
          SetRange(Open, true);

          if Args."Aging By" = Args."aging by"::"Posting Date" then begin
            SetRange("Posting Date", 0D, Args."Ending Date");
            SetRange("Date Filter", 0D, Args."Ending Date");
          end;

          if FindSet then repeat
          if Args."Aging By" = Args."aging by"::"Posting Date" then begin
             CalcFields("Remaining Amt. (LCY)");
             if "Remaining Amt. (LCY)" <> 0 then
               InsertTemp(VendorLedgerEntry);
           end else
             InsertTemp(VendorLedgerEntry);
          until Next = 0;
        end;
    end;

    local procedure CreateAgingBuffer(var Vend: Record Vendor;var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.";var TempCurrency: Record Currency temporary)
    var
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        AgingCalculation: Codeunit "ForNAV Aging Calculation";
        PeriodIndex: Integer;
    begin
        with TempVendorLedgerEntry do
          if FindSet then repeat
            AgingBuffer.Init;
            AgingBuffer."Entry No." := "Entry No.";
            AgingBuffer."Account Type" := AgingBuffer."account type"::Vendor;
            AgingBuffer."Account No." := "Vendor No.";
            AgingBuffer.GetAccountName;
        //    AgingBuffer."Customer Credit Limit (LCY)" := Vend."Credit Limit (LCY)";
            if not Args."Print Amounts in LCY" then
              AgingBuffer."Currency Code" := AgingCalculation.GetCurrencyCode("Currency Code");
            AgingBuffer."Document No." := "Document No.";
            AgingBuffer."External Document No." := "External Document No.";
            AgingBuffer."Document Type" := "Document Type";
            AgingBuffer."Document Date" := "Document Date";
            AgingBuffer."Posting Date" := "Posting Date";
            AgingBuffer."Due Date" := "Due Date";

            DetailedVendorLedgEntry.SetRange("Vendor Ledger Entry No.",TempVendorLedgerEntry."Entry No.");
            if DetailedVendorLedgEntry.FindSet then repeat
              if (DetailedVendorLedgEntry."Entry Type" = DetailedVendorLedgEntry."entry type"::"Initial Entry") and
                 (TempVendorLedgerEntry."Posting Date" > Args."Ending Date") and (Args."Aging By" <> Args."aging by"::"Posting Date")
              then begin
                if TempVendorLedgerEntry."Document Date" <= Args."Ending Date" then
                  DetailedVendorLedgEntry."Posting Date" :=  TempVendorLedgerEntry."Document Date"
                else
                  if (TempVendorLedgerEntry."Due Date" <= Args."Ending Date") and (Args."Aging By" = Args."aging by"::"Due Date") then
                    DetailedVendorLedgEntry."Posting Date" := TempVendorLedgerEntry."Due Date";
              end;
              if (DetailedVendorLedgEntry."Posting Date" <= Args."Ending Date") or
                 (TempVendorLedgerEntry.Open and (Args."Aging By" = Args."aging by"::"Due Date") and (TempVendorLedgerEntry."Due Date" > Args."Ending Date") and (TempVendorLedgerEntry."Posting Date" <= Args."Ending Date"))
              then begin
                if DetailedVendorLedgEntry."Entry Type" in
                   [DetailedVendorLedgEntry."entry type"::"Initial Entry",
                    DetailedVendorLedgEntry."entry type"::"Unrealized Loss",
                    DetailedVendorLedgEntry."entry type"::"Unrealized Gain",
                    DetailedVendorLedgEntry."entry type"::"Realized Loss",
                    DetailedVendorLedgEntry."entry type"::"Realized Gain",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount (VAT Excl.)",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount (VAT Adjustment)",
                    DetailedVendorLedgEntry."entry type"::"Payment Tolerance",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount Tolerance",
                    DetailedVendorLedgEntry."entry type"::"Payment Tolerance (VAT Excl.)",
                    DetailedVendorLedgEntry."entry type"::"Payment Tolerance (VAT Adjustment)",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount Tolerance (VAT Excl.)",
                    DetailedVendorLedgEntry."entry type"::"Payment Discount Tolerance (VAT Adjustment)"]
                then begin
                  if not Args."Print Amounts in LCY" then
                    AgingBuffer.Amount += DetailedVendorLedgEntry.Amount
                  else
                    AgingBuffer.Amount += DetailedVendorLedgEntry."Amount (LCY)";
                  AgingBuffer."Amount (LCY)" += DetailedVendorLedgEntry."Amount (LCY)";
                end;

                if DetailedVendorLedgEntry."Posting Date" <= Args."Ending Date" then begin
                  if not Args."Print Amounts in LCY" then
                    AgingBuffer.Balance += DetailedVendorLedgEntry.Amount
                  else
                    AgingBuffer.Balance += DetailedVendorLedgEntry."Amount (LCY)";
                  AgingBuffer."Balance (LCY)" += DetailedVendorLedgEntry."Amount (LCY)";

                end;
              end;
            until DetailedVendorLedgEntry.Next = 0;

            if AgingBuffer.Balance <> 0 then begin
              case Args."Aging By" of
               Args."aging by"::"Due Date":
                 PeriodIndex := Args.GetPeriodIndex(AgingBuffer."Due Date");
               Args."aging by"::"Posting Date":
                 PeriodIndex := Args.GetPeriodIndex(AgingBuffer."Posting Date");
               Args."aging by"::"Document Date":
                 begin
                   if AgingBuffer."Document Date" > Args."Ending Date" then begin
                     AgingBuffer.Balance := 0;
                     AgingBuffer."Balance (LCY)" := 0;
                     AgingBuffer."Document Date" := AgingBuffer."Posting Date";
                   end;
                   PeriodIndex := Args.GetPeriodIndex(AgingBuffer."Document Date");
                 end;
              end;

              AgingCalculation.MoveValuesToPeriod(AgingBuffer, PeriodIndex);

              AgingBuffer.Insert;
              if not Args."Print Amounts in LCY" then
                AgingCalculation.UpdateCurrencyTotals(AgingBuffer, CurrAgingBuffer, TempCurrency);
           end;
          until Next = 0;
    end;

    local procedure InsertTemp(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        with TempVendorLedgerEntry do begin
          if Get(VendorLedgerEntry."Entry No.") then
            exit;

          TempVendorLedgerEntry := VendorLedgerEntry;

          Insert;
        end;
    end;

    local procedure ClearData(var AgingBuffer: Record "ForNAV Aging Buffer")
    begin
        AgingBuffer.Reset;
        AgingBuffer.DeleteAll;
        TempVendorLedgerEntry.Reset;
        TempVendorLedgerEntry.DeleteAll;
    end;
}

