Codeunit 70219 "ForNAV Aging Calculation"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure GetAging(Rec: Variant;var AgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.")
    var
        CustomerAging: Codeunit "ForNAV Customer Aging";
        VendorAging: Codeunit "ForNAV Vendor Aging";
    begin
        case GetAccountType(Rec) of
          AgingBuffer."account type"::Customer:
            CustomerAging.GetAging(Rec, AgingBuffer, Args);
          AgingBuffer."account type"::Vendor:
            VendorAging.GetAging(Rec, AgingBuffer, Args);
        end;
    end;

    procedure GetAgingWithCurrency(Rec: Variant;var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var Args: Record "ForNAV Aged Accounts Args.";var TempCurrency: Record Currency temporary)
    var
        CustomerAging: Codeunit "ForNAV Customer Aging";
        VendorAging: Codeunit "ForNAV Vendor Aging";
    begin
        case GetAccountType(Rec) of
          AgingBuffer."account type"::Customer:
            CustomerAging.GetAgingWithCurrency(Rec, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
          AgingBuffer."account type"::Vendor:
            VendorAging.GetAgingWithCurrency(Rec, AgingBuffer, CurrAgingBuffer, Args, TempCurrency);
        end;
    end;

    local procedure GetAccountType(Rec: Variant): Integer
    var
        AgingBuffer: Record "ForNAV Aging Buffer";
        RecordRefLibrary: Codeunit "ForNAV RecordRef Library";
        UnsupportedTableErr: label 'Unsupported Table';
        RecRef: RecordRef;
    begin
        RecordRefLibrary.ConvertToRecRef(Rec, RecRef);
        case RecRef.Number of
          Database::Customer:
            exit(AgingBuffer."account type"::Customer);
          Database::Vendor:
            exit(AgingBuffer."account type"::Vendor);
          else
            Error(UnsupportedTableErr);;
        end;
    end;

    procedure UpdateCurrencyTotals(var AgingBuffer: Record "ForNAV Aging Buffer";var CurrAgingBuffer: Record "ForNAV Aging Buffer";var TempCurrency: Record Currency temporary)
    var
        i: Integer;
    begin
        CurrAgingBuffer.Reset;
        CurrAgingBuffer.SetRange("Currency Code", AgingBuffer."Currency Code");
        if not TempCurrency.Get(AgingBuffer."Currency Code") then begin
          TempCurrency.Code := AgingBuffer."Currency Code";
          TempCurrency.Insert;
          CurrAgingBuffer."Entry No." :=  TempCurrency.Count;
          CurrAgingBuffer."Currency Code" := AgingBuffer."Currency Code";
          CurrAgingBuffer.Amount := AgingBuffer.Amount;
          CurrAgingBuffer.Balance := AgingBuffer.Balance;
          CurrAgingBuffer."Amount 1" := AgingBuffer."Amount 1";
          CurrAgingBuffer."Amount 2" := AgingBuffer."Amount 2";
          CurrAgingBuffer."Amount 3" := AgingBuffer."Amount 3";
          CurrAgingBuffer."Amount 4" := AgingBuffer."Amount 4";
          CurrAgingBuffer."Amount 5" := AgingBuffer."Amount 5";
          CurrAgingBuffer.Insert;
        end else begin
          CurrAgingBuffer.SetRange("Currency Code", AgingBuffer."Currency Code");
          CurrAgingBuffer.FindFirst;
          CurrAgingBuffer.Amount += AgingBuffer.Amount;
          CurrAgingBuffer.Balance += AgingBuffer.Balance;
          CurrAgingBuffer."Amount 1" += AgingBuffer."Amount 1";
          CurrAgingBuffer."Amount 2" += AgingBuffer."Amount 2";
          CurrAgingBuffer."Amount 3" += AgingBuffer."Amount 3";
          CurrAgingBuffer."Amount 4" += AgingBuffer."Amount 4";
          CurrAgingBuffer."Amount 5" += AgingBuffer."Amount 5";
          CurrAgingBuffer.Modify;
          CurrAgingBuffer.Reset;
        end;
    end;

    procedure GetCurrencyCode(Value: Code[10]): Code[10]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if Value <> '' then
          exit(Value);

        GLSetup.Get;
        exit(GLSetup."LCY Code");
    end;

    procedure MoveValuesToPeriod(var AgingBuffer: Record "ForNAV Aging Buffer";PeriodIndex: Integer)
    var
        Fld: Record "Field";
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        RecRef.GetTable(AgingBuffer);
        Fld.SetRange(TableNo, RecRef.Number);
        Fld.SetRange(FieldName, 'Amount ' + Format(PeriodIndex));
        Fld.FindFirst;
        FldRef := RecRef.Field(Fld."No.");

        FldRef.Value := AgingBuffer.Balance;

        Fld.SetRange(FieldName, 'Amount ' + Format(PeriodIndex) + ' (LCY)');
        Fld.FindFirst;
        FldRef := RecRef.Field(Fld."No.");

        FldRef.Value := AgingBuffer."Balance (LCY)";

        RecRef.SetTable(AgingBuffer);
    end;
}

