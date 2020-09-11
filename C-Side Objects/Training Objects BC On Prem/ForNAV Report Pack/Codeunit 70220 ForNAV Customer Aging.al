Codeunit 70220 "ForNAV Customer Aging"
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
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;

    procedure GetAging(var Cust: Record Customer;var AgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.")
    var
        CurrAgingBuffer: Record "ForNAV Aging Buffer" temporary;
        TempCurrency: Record Currency temporary;
    begin
        GetAgingWithCurrency(Cust, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
    end;

    procedure GetAgingWithCurrency(var Cust: Record Customer;var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.";var TempCurrency: Record Currency temporary)
    begin
        ClearData(AgingBuffer);
        GetBasedOnDetailedEntry(Cust, Args);
        GetBasedOnOpenEntry(Cust, Args);
        CreateAgingBuffer(Cust, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
        AgingBuffer.SetCaptions(Args);
    end;

    local procedure GetBasedOnDetailedEntry(var Cust: Record Customer;var Args: Record "ForNAV Aged Accounts Args.")
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        with DetailedCustLedgEntry do begin
          SetCurrentkey("Customer No.", "Posting Date", "Entry Type", "Currency Code");
          SetRange("Customer No.", Cust."No.");
          SetRange("Entry Type", DetailedCustLedgEntry."entry type"::Application);
          SetRange("Posting Date", 0D, Args."Ending Date");
          SetFilter("Posting Date", '%1..', Args."Ending Date" + 1);

          if FindSet then repeat
            if CustLedgEntry.Get("Cust. Ledger Entry No.") then
              if CustLedgEntry.Open then begin
                CustLedgEntry.SetRange("Date Filter",0D, Args."Ending Date");
                CustLedgEntry.CalcFields("Remaining Amount");
                if CustLedgEntry."Remaining Amount" <> 0 then
                  InsertTemp(CustLedgEntry);
            end;
          until Next = 0;
        end;
    end;

    local procedure GetBasedOnOpenEntry(var Cust: Record Customer;var Args: Record "ForNAV Aged Accounts Args.")
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        with CustLedgEntry do begin
          SetCurrentkey("Customer No.", Open, Positive, "Due Date", "Currency Code");
          SetRange("Customer No.", Cust."No.");
          SetRange(Open, true);

          if Args."Aging By" = Args."aging by"::"Posting Date" then begin
            SetRange("Posting Date", 0D, Args."Ending Date");
            SetRange("Date Filter", 0D, Args."Ending Date");
          end;

          if FindSet then repeat
          if Args."Aging By" = Args."aging by"::"Posting Date" then begin
             CalcFields("Remaining Amt. (LCY)");
             if "Remaining Amt. (LCY)" <> 0 then
               InsertTemp(CustLedgEntry);
           end else
             InsertTemp(CustLedgEntry);
          until Next = 0;
        end;
    end;

    local procedure CreateAgingBuffer(var Cust: Record Customer;var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.";var TempCurrency: Record Currency temporary)
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        AgingCalculation: Codeunit "ForNAV Aging Calculation";
        PeriodIndex: Integer;
    begin
        with TempCustLedgEntry do
          if FindSet then repeat
            AgingBuffer.Init;
            AgingBuffer."Entry No." := "Entry No.";
            AgingBuffer."Account No." := "Customer No.";
            AgingBuffer.GetAccountName;
            AgingBuffer."Credit Limit (LCY)" := Cust."Credit Limit (LCY)";
            if not Args."Print Amounts in LCY" then
              AgingBuffer."Currency Code" := AgingCalculation.GetCurrencyCode("Currency Code");
            AgingBuffer."Document No." := "Document No.";
            AgingBuffer."External Document No." := "External Document No.";
            AgingBuffer."Document Type" := "Document Type";
            AgingBuffer."Document Date" := "Document Date";
            AgingBuffer."Posting Date" := "Posting Date";
            AgingBuffer."Due Date" := "Due Date";

            DetailedCustLedgEntry.SetRange("Cust. Ledger Entry No.",TempCustLedgEntry."Entry No.");
            if DetailedCustLedgEntry.FindSet then repeat
              if (DetailedCustLedgEntry."Entry Type" = DetailedCustLedgEntry."entry type"::"Initial Entry") and
                 (TempCustLedgEntry."Posting Date" > Args."Ending Date") and (Args."Aging By" <> Args."aging by"::"Posting Date")
              then begin
                if TempCustLedgEntry."Document Date" <= Args."Ending Date" then
                  DetailedCustLedgEntry."Posting Date" :=  TempCustLedgEntry."Document Date"
                else
                  if (TempCustLedgEntry."Due Date" <= Args."Ending Date") and (Args."Aging By" = Args."aging by"::"Due Date") then
                    DetailedCustLedgEntry."Posting Date" := TempCustLedgEntry."Due Date";
              end;
              if (DetailedCustLedgEntry."Posting Date" <= Args."Ending Date") or
                 (TempCustLedgEntry.Open and (Args."Aging By" = Args."aging by"::"Due Date") and (TempCustLedgEntry."Due Date" > Args."Ending Date") and (TempCustLedgEntry."Posting Date" <= Args."Ending Date"))
              then begin
                if DetailedCustLedgEntry."Entry Type" in
                   [DetailedCustLedgEntry."entry type"::"Initial Entry",
                    DetailedCustLedgEntry."entry type"::"Unrealized Loss",
                    DetailedCustLedgEntry."entry type"::"Unrealized Gain",
                    DetailedCustLedgEntry."entry type"::"Realized Loss",
                    DetailedCustLedgEntry."entry type"::"Realized Gain",
                    DetailedCustLedgEntry."entry type"::"Payment Discount",
                    DetailedCustLedgEntry."entry type"::"Payment Discount (VAT Excl.)",
                    DetailedCustLedgEntry."entry type"::"Payment Discount (VAT Adjustment)",
                    DetailedCustLedgEntry."entry type"::"Payment Tolerance",
                    DetailedCustLedgEntry."entry type"::"Payment Discount Tolerance",
                    DetailedCustLedgEntry."entry type"::"Payment Tolerance (VAT Excl.)",
                    DetailedCustLedgEntry."entry type"::"Payment Tolerance (VAT Adjustment)",
                    DetailedCustLedgEntry."entry type"::"Payment Discount Tolerance (VAT Excl.)",
                    DetailedCustLedgEntry."entry type"::"Payment Discount Tolerance (VAT Adjustment)"]
                then begin
                  if not Args."Print Amounts in LCY" then
                    AgingBuffer.Amount += DetailedCustLedgEntry.Amount
                  else
                    AgingBuffer.Amount += DetailedCustLedgEntry."Amount (LCY)";
                  AgingBuffer."Amount (LCY)" += DetailedCustLedgEntry."Amount (LCY)";
                end;

                if DetailedCustLedgEntry."Posting Date" <= Args."Ending Date" then begin
                  if not Args."Print Amounts in LCY" then
                    AgingBuffer.Balance += DetailedCustLedgEntry.Amount
                  else
                    AgingBuffer.Balance += DetailedCustLedgEntry."Amount (LCY)";
                  AgingBuffer."Balance (LCY)" += DetailedCustLedgEntry."Amount (LCY)";

                end;
              end;
            until DetailedCustLedgEntry.Next = 0;

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

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        with TempCustLedgEntry do begin
          if Get(CustLedgEntry."Entry No.") then
            exit;

          TempCustLedgEntry := CustLedgEntry;

          Insert;
        end;
    end;

    local procedure ClearData(var AgingBuffer: Record "ForNAV Aging Buffer")
    begin
        AgingBuffer.Reset;
        AgingBuffer.DeleteAll;
        TempCustLedgEntry.Reset;
        TempCustLedgEntry.DeleteAll;
    end;
}

