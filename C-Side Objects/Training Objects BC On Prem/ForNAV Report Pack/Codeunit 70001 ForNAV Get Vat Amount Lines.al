Codeunit 70001 "ForNAV Get Vat Amount Lines"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure GetVatAmountLines(Rec: Variant;var VATAmountLine: Record "VAT Amount Line" temporary)
    var
        DocLineBuffer: Record "ForNAV Document Line Buffer" temporary;
        RecRefLib: Codeunit "ForNAV RecordRef Library";
        TestValidDociFace: Codeunit "ForNAV Test Valid Doc iFace";
        RecRef: RecordRef;
        LineRec: RecordRef;
    begin
        ThrowErrorIfNotTemp(VATAmountLine);
        RecRefLib.ConvertToRecRef(Rec, RecRef);
        TestValidDociFace.ThrowErrorIfNotValid(RecRef);
        FindLinesRecRef(DocLineBuffer, RecRef, LineRec);
        CreateVATAmountLine(DocLineBuffer, VATAmountLine);
    end;

    local procedure ThrowErrorIfNotTemp(var VATAmountLine: Record "VAT Amount Line")
    var
        CheckTemporary: Codeunit "ForNAV Check Temporary";
    begin
        CheckTemporary.IsTemporary(VATAmountLine, true);
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

    local procedure CreateVATAmountLine(var DocLineBuffer: Record "ForNAV Document Line Buffer";var VATAmountLine: Record "VAT Amount Line")
    begin
        with DocLineBuffer do
          if FindSet then repeat
            VATAmountLine.Init;
            VATAmountLine."VAT Identifier" := "VAT Identifier";
            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
            VATAmountLine."Tax Group Code" := "Tax Group Code";
            VATAmountLine."VAT %" := "VAT %";
            VATAmountLine."VAT Base" := Amount;
            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
            VATAmountLine."Line Amount" := "Line Amount";
            if "Allow Invoice Disc." then
              VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
            if ("VAT %" <> 0) or ("VAT Clause Code" <> '') or (Amount <> "Amount Including VAT") then
              VATAmountLine.InsertLine;
          until Next = 0;
    end;
}

