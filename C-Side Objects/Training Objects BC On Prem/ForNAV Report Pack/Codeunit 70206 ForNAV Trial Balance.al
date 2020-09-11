Codeunit 70206 "ForNAV Trial Balance"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    // 
    // This codeunit is based on 10025 Paragraph Handling.


    trigger OnRun()
    begin
    end;

    procedure GetDataFromGLAccount(var TrialBalance: Record "ForNAV Trial Balance";var GLAccount: Record "G/L Account";var Args: Record "ForNAV Trial Balance Args.")
    var
        PriorFromDate: Date;
        PriorToDate: Date;
    begin
        PriorFromDate := CalcDate('<-1Y>',Args."From Date" + 1) - 1;
        PriorToDate := CalcDate('<-1Y>',Args."To Date" + 1) - 1;

        with TrialBalance do begin
          GLAccount.SetRange("Date Filter",Args."From Date",Args."To Date");
          if not Args."All Amounts in LCY" then begin
            GLAccount.CalcFields("Additional-Currency Net Change","Add.-Currency Balance at Date");
            "Net Change Actual" := GLAccount."Additional-Currency Net Change";
            "Balance at Date Actual" := GLAccount."Add.-Currency Balance at Date";
          end else begin
            GLAccount.CalcFields("Net Change","Balance at Date");
            "Net Change Actual" := GLAccount."Net Change";
            "Balance at Date Actual" := GLAccount."Balance at Date";
          end;
          if Args."Show by" = Args."show by"::Budget then begin
            GLAccount.CalcFields("Budgeted Amount","Budget at Date");
            "Net Change Actual Last Year" := GLAccount."Budgeted Amount";
            "Balance at Date Act. Last Year" := GLAccount."Budget at Date";
          end else begin
            GLAccount.SetRange("Date Filter",PriorFromDate,PriorToDate);
            if not Args."All Amounts in LCY" then begin
              GLAccount.CalcFields("Additional-Currency Net Change","Add.-Currency Balance at Date");
              "Net Change Actual Last Year" := GLAccount."Additional-Currency Net Change";
              "Balance at Date Act. Last Year" := GLAccount."Add.-Currency Balance at Date";
            end else begin
              GLAccount.CalcFields("Net Change","Balance at Date");
              "Net Change Actual Last Year" := GLAccount."Net Change";
              "Balance at Date Act. Last Year" := GLAccount."Balance at Date";
            end;
          end;

          if Args."Variance in Changes" or Args."% Variance in Changes" then
            "Variance in Changes" := "Net Change Actual" - "Net Change Actual Last Year";
          if Args."% Variance in Changes" and ("Net Change Actual Last Year" <> 0) then
            "% Variance in Changes" := "Variance in Changes" / "Net Change Actual Last Year" * 100;
          if Args."Variance in Balances" or Args."% Variance in Balances" then
            "Variance in Balances"  := "Balance at Date Actual" - "Balance at Date Act. Last Year";
          if Args."% Variance in Balances" and ("Balance at Date Act. Last Year" <> 0) then
            "% Variance in Balances"  := "Variance in Balances"  / "Balance at Date Act. Last Year" * 100;
        end;
    end;
}

