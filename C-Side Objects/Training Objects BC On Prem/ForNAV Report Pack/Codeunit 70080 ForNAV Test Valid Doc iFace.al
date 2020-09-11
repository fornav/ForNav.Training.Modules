Codeunit 70080 "ForNAV Test Valid Doc iFace"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure ThrowErrorIfNotValid(var RecRef: RecordRef)
    var
        NotValidTableErr: label 'This table (%1) is not supported for this function.';
    begin
        if not CheckValid(RecRef) then
          Error(NotValidTableErr, RecRef.Caption);
    end;

    procedure CheckValid(var RecRef: RecordRef): Boolean
    begin
        case RecRef.Number of
          Database::"Sales Header":
            exit(true);
          Database::"Sales Shipment Header":
            exit(true);
          Database::"Sales Invoice Header":
            exit(true);
          Database::"Sales Cr.Memo Header":
            exit(true);
          Database::"Purchase Header":
            exit(true);
          Database::"Purch. Rcpt. Header":
            exit(true);
          Database::"Purch. Inv. Header":
            exit(true);
          Database::"Purch. Cr. Memo Hdr.":
            exit(true);
          Database::"Reminder Header":
            exit(true);
          Database::"Issued Reminder Header":
            exit(true);
          Database::"Finance Charge Memo Header":
            exit(true);
          Database::"Issued Fin. Charge Memo Header":
            exit(true);
        end;

        exit(false);
    end;
}

