Table 70230 "ForNAV Statistics Args."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(2;Invoices;Boolean)
        {
            Caption = 'Invoices';
            DataClassification = SystemMetadata;
        }
        field(3;"Credit Memos";Boolean)
        {
            Caption = 'Credit Memos';
            DataClassification = SystemMetadata;
        }
        field(4;"Customer No.";Boolean)
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
        }
        field(5;"Vendor No.";Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Currency Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateCurrencies()
    var
        Currency: Record Currency;
    begin
        if Currency.FindSet then
          repeat
            "Currency Code" := Currency.Code;
            Insert;
          until Currency.Next = 0;

        if not Get('') then begin
          "Currency Code" := '';
          Insert;
        end;
    end;

    procedure GetInvoiceAmountLCY(SalesInvoiceHeader: Record "Sales Invoice Header"): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetCurrentkey("Document No.");
        CustLedgEntry.SetRange("Document No.",SalesInvoiceHeader."No.");
        CustLedgEntry.SetRange("Document Type",CustLedgEntry."document type"::Invoice);
        CustLedgEntry.SetRange("Customer No.",SalesInvoiceHeader."Bill-to Customer No.");
        if CustLedgEntry.FindFirst then
          exit(CustLedgEntry."Sales (LCY)");
    end;

    procedure GetInvoiceCostLCY(SalesInvoiceHeader: Record "Sales Invoice Header"): Decimal
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        CostLCY: Decimal;
    begin
        SalesInvoiceLine.SetRange("Document No.",SalesInvoiceHeader."No.");
        if SalesInvoiceLine.Find('-') then
          repeat
            CostLCY := CostLCY + CostCalcMgt.CalcSalesInvLineCostLCY(SalesInvoiceLine);
          until SalesInvoiceLine.Next = 0;

        exit(CostLCY);
    end;

    procedure GetCreditMemoAmountLCY(SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Decimal
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        CustLedgEntry.SetCurrentkey("Document No.");
        CustLedgEntry.SetRange("Document No.",SalesCrMemoHeader."No.");
        CustLedgEntry.SetRange("Document Type",CustLedgEntry."document type"::"Credit Memo");
        CustLedgEntry.SetRange("Customer No.",SalesCrMemoHeader."Bill-to Customer No.");
        if CustLedgEntry.FindFirst then
          exit(CustLedgEntry."Sales (LCY)");
    end;

    procedure GetCreditMemoCostLCY(SalesCrMemoHeader: Record "Sales Cr.Memo Header"): Decimal
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
        CostLCY: Decimal;
    begin
        SalesCrMemoLine.SetRange("Document No.",SalesCrMemoHeader."No.");
        if SalesCrMemoLine.Find('-') then
          repeat
            CostLCY := CostLCY + CostCalcMgt.CalcSalesCrMemoLineCostLCY(SalesCrMemoLine);
          until SalesCrMemoLine.Next = 0;

        exit(CostLCY);
    end;

    procedure GetPurchInvAmountLCY(PurchInvHeader: Record "Purch. Inv. Header"): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.",PurchInvHeader."No.");
        VendLedgEntry.SetRange("Document Type",VendLedgEntry."document type"::Invoice);
        VendLedgEntry.SetRange("Vendor No.", PurchInvHeader."Pay-to Vendor No.");
        if VendLedgEntry.FindFirst then
          exit(VendLedgEntry."Purchase (LCY)");
    end;

    procedure GetPurchCrMemoAmountLCY(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."): Decimal
    var
        VendLedgEntry: Record "Vendor Ledger Entry";
    begin
        VendLedgEntry.SetCurrentkey("Document No.");
        VendLedgEntry.SetRange("Document No.",PurchCrMemoHdr."No.");
        VendLedgEntry.SetRange("Document Type",VendLedgEntry."document type"::"Credit Memo");
        VendLedgEntry.SetRange("Vendor No.", PurchCrMemoHdr."Pay-to Vendor No.");
        if VendLedgEntry.FindFirst then
          exit(VendLedgEntry."Purchase (LCY)");
    end;
}

