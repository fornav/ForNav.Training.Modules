Codeunit 70002 "ForNAV Get Vat Clause"
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
        TryGetVATClause: Integer;

    procedure GetVATClauses(var VATAmountLine: Record "VAT Amount Line" temporary;var VATClause: Record "VAT Clause";LanguageCode: Code[10])
    begin
        with VATAmountLine do
          if FindSet then repeat
            TryGetVATClauseText(VATClause, "VAT Clause Code", LanguageCode);
          until Next = 0;
    end;

    local procedure TryGetVATClauseText(var VATClausePar: Record "VAT Clause";VATClauseCode: Code[20];LanguageCode: Code[10])
    var
        VATClause: Record "VAT Clause";
    begin
        if not VATClause.Get(VATClauseCode) then
          exit;

        VATClause.TranslateDescription(LanguageCode);

        VATClausePar := VATClause;
        if VATClausePar.Insert then;
    end;
}

