Codeunit 70006 "ForNAV Read Watermarks"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure ReadFromFile(var ForNAVSetup: Record "ForNAV Setup";Which: Integer): Boolean
    var
        TempBlob: Record TempBlob temporary;
        FileName: Text;
        InStream: InStream;
        OutStream: OutStream;
    begin
        UploadIntoStream('Select a file', '', 'PDF files (*.pdf)|*.pdf|All files (*.*)|*.*', FileName, InStream);
        TempBlob.Blob.CreateOutstream(OutStream);
        CopyStream(OutStream, InStream);

        with ForNAVSetup do
          if FileName <> '' then begin
            case Which of
              FieldNo(Logo):
                begin
                  Logo := TempBlob.Blob;
                  "Logo File Name" := GetFileNameFromFile(FileName);
                end;
              FieldNo("Document Watermark"):
                begin
                 "Document Watermark" := TempBlob.Blob;
                  "Document Watermark File Name" := GetFileNameFromFile(FileName);
                end;
              FieldNo("List Report Watermark"):
                begin
                  "List Report Watermark" := TempBlob.Blob;
                  "List Report Watermark File N." := GetFileNameFromFile(FileName);
                end;
            end;
            exit(true);
          end;

        exit(false);
    end;

    local procedure GetFileNameFromFile(Value: Text): Text
    var
        LastPos: Integer;
        i: Integer;
    begin
        while i < StrLen(Value) do begin
          i := i + 1;
          if Value[i] = '\' then
            LastPos := i;
        end;

        exit(CopyStr(Value, LastPos + 1));
    end;
}

