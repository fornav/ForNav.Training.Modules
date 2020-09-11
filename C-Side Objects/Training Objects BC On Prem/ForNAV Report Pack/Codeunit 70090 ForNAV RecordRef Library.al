Codeunit 70090 "ForNAV RecordRef Library"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure ConvertToRecRef(var Rec: Variant;RecRef: RecordRef)
    var
        WrongDataTypeErr: label 'Runtime Error: Wrong Datatype. Please contact your ForNAV reseller.';
    begin
        case true of
          Rec.IsRecordRef:
            RecRef := Rec;
          Rec.IsRecord:
            RecRef.GetTable(Rec);
          else
            Error(WrongDataTypeErr);
        end;
    end;

    procedure FindAndFilterFieldNo(var RecRef: RecordRef;var LineRec: RecordRef;var FldRef: FieldRef;Value: Text)
    var
        "Field": Record "Field";
        DocumentNoField: FieldRef;
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, Value);
        if not Field.FindFirst then
          exit;

        DocumentNoField := RecRef.Field(Field."No.");

        Field.Reset;
        Field.SetRange(TableNo, RecRef.Number + 1);
        Field.SetRange("No.", Field."No.");
        if not Field.FindFirst then
          exit;

        FldRef := LineRec.Field(Field."No.");
        FldRef.SetRange(DocumentNoField.Value);
    end;
}

