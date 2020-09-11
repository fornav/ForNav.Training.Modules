Codeunit 70003 "ForNAV Update No. Printed"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Permissions = TableData "Sales Header"=rm,
                  TableData "Purchase Header"=rm,
                  TableData "Sales Shipment Header"=rm,
                  TableData "Sales Invoice Header"=rm,
                  TableData "Sales Cr.Memo Header"=rm,
                  TableData "Purch. Rcpt. Header"=rm,
                  TableData "Purch. Inv. Header"=rm,
                  TableData "Purch. Cr. Memo Hdr."=rm;

    trigger OnRun()
    begin
    end;

    procedure UpdateNoPrinted(Rec: Variant;Preview: Boolean)
    var
        RecRefLib: Codeunit "ForNAV RecordRef Library";
        RecRef: RecordRef;
    begin
        if Preview then
          exit;

        RecRefLib.ConvertToRecRef(Rec, RecRef);
        FindAndUpdateField(RecRef);
    end;

    local procedure FindAndUpdateField(var RecRef: RecordRef)
    var
        "Field": Record "Field";
        FldRef: FieldRef;
        NoPrinted: Integer;
        NotAValidTableErr: label 'This table is not valid to be used with the Update No. Printed Function. Please contact your system administrator or ForNAV support.';
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, 'No. Printed');
        if not Field.FindFirst then
          Error(NotAValidTableErr);

        FldRef := RecRef.Field(Field."No.");
        NoPrinted := FldRef.Value;
        NoPrinted +=1;
        FldRef.Value := NoPrinted;
        RecRef.Modify;
        Commit;
    end;
}

