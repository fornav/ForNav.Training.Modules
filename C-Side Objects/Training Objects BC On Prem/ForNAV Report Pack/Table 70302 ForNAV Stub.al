Table 70302 "ForNAV Stub"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Entry No.";Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(2;"Document Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(3;"Document No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(4;"External Document No.";Text[35])
        {
            DataClassification = SystemMetadata;
        }
        field(5;Amount;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(6;"Discount Amount";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(8;"Document Type";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(9;"Amount Paid";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(10;"Job No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(12;"Currency Code";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(13;"Posting Date";Date)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CustUpdateAmounts(var CustLedgEntry2: Record "Cust. Ledger Entry";var RemainingAmount2: Decimal;var LineAmount2: Decimal)
    var
        Currency: Record Currency;
    begin
        if "Currency Code" <> '' then
          Currency.Get("Currency Code");

        "Entry No." := CustLedgEntry2."Entry No.";
        "Document Type" := Format(CustLedgEntry2."Document Type");
        "Document No." := CustLedgEntry2."Document No.";
        "External Document No." := CustLedgEntry2."External Document No.";
        "Document Date" := CustLedgEntry2."Document Date";
        CustLedgEntry2.CalcFields("Remaining Amount");
        Amount := -(CustLedgEntry2."Remaining Amount" - CustLedgEntry2."Remaining Pmt. Disc. Possible"-
          CustLedgEntry2."Accepted Payment Tolerance");

        LineAmount2 :=
          ROUND(
            ExchangeAmt(CustLedgEntry2."Posting Date","Currency Code",CustLedgEntry2."Currency Code",Amount),
            Currency."Amount Rounding Precision");

        if ((((CustLedgEntry2."Document Type" = CustLedgEntry2."document type"::Invoice) and
              (LineAmount2 >= RemainingAmount2)) or
             ((CustLedgEntry2."Document Type" = CustLedgEntry2."document type"::"Credit Memo") and
              (LineAmount2 <= RemainingAmount2))) and
            ("Posting Date" <= CustLedgEntry2."Pmt. Discount Date")) or
           CustLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          "Discount Amount" := -CustLedgEntry2."Remaining Pmt. Disc. Possible";
          if CustLedgEntry2."Accepted Payment Tolerance" <> 0 then
            "Discount Amount" := "Discount Amount" - CustLedgEntry2."Accepted Payment Tolerance";
        end else begin
          "Discount Amount" := 0;
        end;
        Insert;
    end;

    procedure VendUpdateAmounts(var VendLedgEntry2: Record "Vendor Ledger Entry";var RemainingAmount2: Decimal;var LineAmount2: Decimal)
    var
        Currency: Record Currency;
        CurrencyCode2: Code[10];
    begin
        if "Currency Code" <> '' then
          Currency.Get("Currency Code");

        "Entry No." := VendLedgEntry2."Entry No.";
        "Document Type" := Format(VendLedgEntry2."Document Type");
        "Document No." := VendLedgEntry2."Document No.";
        "External Document No." := VendLedgEntry2."External Document No.";
        "Document Date" := VendLedgEntry2."Document Date";
        CurrencyCode2 := VendLedgEntry2."Currency Code";
        VendLedgEntry2.CalcFields("Remaining Amount");
        Amount := -(VendLedgEntry2."Remaining Amount" - VendLedgEntry2."Remaining Pmt. Disc. Possible" -
          VendLedgEntry2."Accepted Payment Tolerance");
        LineAmount2 :=
          ROUND(
            ExchangeAmt(VendLedgEntry2."Posting Date","Currency Code",CurrencyCode2,Amount),
            Currency."Amount Rounding Precision");
        if ((((VendLedgEntry2."Document Type" = VendLedgEntry2."document type"::Invoice) and
              (LineAmount2 <= RemainingAmount2)) or
             ((VendLedgEntry2."Document Type" = VendLedgEntry2."document type"::"Credit Memo") and
              (LineAmount2 >= RemainingAmount2))) and
            ("Posting Date" <= VendLedgEntry2."Pmt. Discount Date")) or
           VendLedgEntry2."Accepted Pmt. Disc. Tolerance"
        then begin
          "Discount Amount" := -VendLedgEntry2."Remaining Pmt. Disc. Possible";
          if VendLedgEntry2."Accepted Payment Tolerance" <> 0 then
            "Discount Amount" := "Discount Amount" - VendLedgEntry2."Accepted Payment Tolerance";
        end else begin
          "Discount Amount" := 0;
        end;
        Insert;
    end;

    local procedure ExchangeAmt(PostingDate: Date;CurrencyCode: Code[10];CurrencyCode2: Code[10];Amount: Decimal) Amount2: Decimal
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        if (CurrencyCode <> '')  and (CurrencyCode2 = '') then
           Amount2 :=
             CurrencyExchangeRate.ExchangeAmtLCYToFCY(
               PostingDate,CurrencyCode,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode))
        else if (CurrencyCode = '') and (CurrencyCode2 <> '') then
          Amount2 :=
            CurrencyExchangeRate.ExchangeAmtFCYToLCY(
              PostingDate,CurrencyCode2,Amount,CurrencyExchangeRate.ExchangeRate(PostingDate,CurrencyCode2))
        else if (CurrencyCode <> '') and (CurrencyCode2 <> '') and (CurrencyCode <> CurrencyCode2) then
          Amount2 := CurrencyExchangeRate.ExchangeAmtFCYToFCY(PostingDate,CurrencyCode2,CurrencyCode,Amount)
        else
          Amount2 := Amount;
    end;
}

