Codeunit 70012 "ForNAV Get VAT Currency Buffer"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure GetVatCurrency(Rec: Variant;var VATCurrency: Record "ForNAV VAT Currency Buffer" temporary)
    var
        DocLineBuffer: Record "ForNAV Document Line Buffer" temporary;
        RecRefLib: Codeunit "ForNAV RecordRef Library";
        TestValidDociFace: Codeunit "ForNAV Test Valid Doc iFace";
        RecRef: RecordRef;
        LineRec: RecordRef;
    begin
        ThrowErrorIfNotTemp(VATCurrency);
        RecRefLib.ConvertToRecRef(Rec, RecRef);
        if not IsValid(GetCurrencyCode(RecRef)) then
          exit;

        TestValidDociFace.ThrowErrorIfNotValid(RecRef);
        FindLinesRecRef(DocLineBuffer, RecRef, LineRec);
        CreateVATAmountLine(DocLineBuffer, VATCurrency, GetPostingDate(RecRef), GetCurrencyCode(RecRef), GetCurrencyFactor(RecRef));
    end;

    local procedure IsValid(CurrencyCode: Code[10]): Boolean
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        if (not GLSetup."Print VAT specification in LCY") or
           (CurrencyCode = '')
        then
          exit(false);

        exit(true);
    end;

    local procedure ThrowErrorIfNotTemp(var VATCurrency: Record "ForNAV VAT Currency Buffer")
    var
        CheckTemporary: Codeunit "ForNAV Check Temporary";
    begin
        CheckTemporary.IsTemporary(VATCurrency, true);
    end;

    local procedure FindLinesRecRef(var DocLineBuffer: Record "ForNAV Document Line Buffer";var RecRef: RecordRef;var LineRec: RecordRef)
    var
        RecRefLib: Codeunit "ForNAV RecordRef Library";
        FldRef: FieldRef;
    begin
        LineRec.Open(RecRef.Number + 1);

        RecRefLib.FindAndFilterFieldNo(RecRef, LineRec, FldRef, 'No.');
        RecRefLib.FindAndFilterFieldNo(RecRef, LineRec, FldRef, 'Document Type');
        if LineRec.FindSet then repeat
          DocLineBuffer.CreateForRecRef(LineRec);
        until LineRec.Next = 0;
    end;

    local procedure CreateVATAmountLine(var DocLineBuffer: Record "ForNAV Document Line Buffer";var VATCurrency: Record "ForNAV VAT Currency Buffer";PostingDate: Date;CurrencyCode: Code[10];CurrencyFactor: Decimal)
    var
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        with DocLineBuffer do
          if FindSet then repeat
            VATCurrency.Init;
            VATCurrency."VAT Identifier" := "VAT Identifier";
            VATCurrency."VAT %" := "VAT %";
            VATCurrency."VAT Base Amount" := CurrExchRate.ExchangeAmtFCYToLCY(PostingDate,CurrencyCode, Amount, CurrencyFactor);
            VATCurrency."VAT Amount" := CurrExchRate.ExchangeAmtFCYToLCY(PostingDate,CurrencyCode, "Amount Including VAT" - Amount, CurrencyFactor);
            VATCurrency."Currency Factor" := CurrencyFactor;
            VATCurrency.InsertLine;
          until Next = 0;
    end;

    local procedure GetCurrencyCode(var RecRef: RecordRef): Code[10]
    var
        "Field": Record "Field";
        FldRef: FieldRef;
        NoPrinted: Integer;
        NotAValidTableErr: label 'This table is not valid to be used with the Update No. Printed Function. Please contact your system administrator or ForNAV support.';
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, 'Currency Code');
        if not Field.FindFirst then
          Error(NotAValidTableErr);

        FldRef := RecRef.Field(Field."No.");
        exit(FldRef.Value);
    end;

    local procedure GetPostingDate(var RecRef: RecordRef): Date
    var
        NotAValidTableErr: label 'This table is not valid to be used with the Update No. Printed Function. Please contact your system administrator or ForNAV support.';
        "Field": Record "Field";
        FldRef: FieldRef;
        NoPrinted: Integer;
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, 'Posting Date');
        if not Field.FindFirst then
          Error(NotAValidTableErr);

        FldRef := RecRef.Field(Field."No.");
        exit(FldRef.Value);
    end;

    local procedure GetCurrencyFactor(var RecRef: RecordRef): Decimal
    var
        "Field": Record "Field";
        FldRef: FieldRef;
        NoPrinted: Integer;
        NotAValidTableErr: label 'This table is not valid to be used with the Update No. Printed Function. Please contact your system administrator or ForNAV support.';
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, 'Currency Factor');
        if not Field.FindFirst then
          Error(NotAValidTableErr);

        FldRef := RecRef.Field(Field."No.");
        exit(FldRef.Value);
    end;
}

