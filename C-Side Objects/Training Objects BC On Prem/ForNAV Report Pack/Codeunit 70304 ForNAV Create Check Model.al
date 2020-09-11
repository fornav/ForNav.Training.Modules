Codeunit 70304 "ForNAV Create Check Model"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure CreateFromGenJnlLn(var Args: Record "ForNAV Check Arguments";var GenJnlLn: Record "Gen. Journal Line";var Model: Record "ForNAV Check Model"): Boolean
    var
        Check: Record "ForNAV Check" temporary;
        Stub: Record "ForNAV Stub" temporary;
    begin
        if not ValidLine(Args, GenJnlLn, Model) then
          exit(false);

        Clear(Model);

        Check.CreateFromGenJnlLn(Args, GenJnlLn);
        Check.GetStub(Args, Stub, GenJnlLn);
        Check.UpdateJournal(Args, GenJnlLn);
        Check.CreateCheckLedgerEntry(Args, GenJnlLn);
        CreateModel(Check, Stub, Model);

        exit(true);
    end;

    procedure CreateModel(var Check: Record "ForNAV Check";var Stub: Record "ForNAV Stub";var Model: Record "ForNAV Check Model")
    var
        NextLineNo: Integer;
    begin
        Model.DeleteAll;

        ForEachStubCreateModel(Check, Stub, Model, NextLineNo);
        CreateEmptyLinesInStub(Model, NextLineNo);
        SetDataInModel(Model);
    end;

    local procedure ForEachStubCreateModel(var Check: Record "ForNAV Check";var Stub: Record "ForNAV Stub";var Model: Record "ForNAV Check Model";var NextLineNo: Integer)
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CheckSetup.Get;

        with Stub do begin
          FindSet;
          repeat
            CreateModelFromStub(Stub, Model, NextLineNo);
            UpdateModelWithCheck(Check, Model);
          until (Next = 0) or (CheckSetup.Layout = CheckSetup.Layout::"3 Checks");
        end;
    end;

    local procedure CreateModelFromStub(var Stub: Record "ForNAV Stub";var Model: Record "ForNAV Check Model";var NextLineNo: Integer)
    begin
        with Model do begin
          Init;
          "Document Date" := Stub."Document Date";
          "Document No." := Stub."Document No.";
          "External Document No." := Stub."External Document No.";
          Amount := Stub.Amount;
          "Discount Amount" := Stub."Discount Amount";
          "Net Amount" := Stub.Amount - Stub."Discount Amount";
          "Document Type" := Stub."Document Type";
          "Amount Paid" := Stub."Amount Paid";
          "Job No." := Stub."Job No.";
          "Currency Code" := Stub."Currency Code";
          SetPageAndLineNo(NextLineNo);
          Insert;
        end;
    end;

    local procedure UpdateModelWithCheck(var Check: Record "ForNAV Check";var Model: Record "ForNAV Check Model")
    begin
        with Model do begin
          "Posting Date" := Check."Posting Date";
          Test := Check.Test;
          "Check No." := Check."Check No.";
          "Amount Written in Text" := Check."Amount as Text (LCY)";
          "Amount in Numbers" := Check."Amount Filled as Text";
          "Pay-to Vendor No." := Check."Pay-to Vendor No.";
          "Pay-to Name" := Check."Pay-to Name";
          "Pay-to Name 2" := Check."Pay-to Name 2";
          "Pay-to Address" := Check."Pay-to Address";
          "Pay-to Address 2" := Check."Pay-to Address 2";
          "Pay-to Post Code" := Check."Pay-to Post Code";
          "Pay-to City" := Check."Pay-to City";
          "Pay-to County" := Check."Pay-to County";
          "Pay-to Country/Region Code" := Check."Pay-to Country/Region Code";
          "Bank Name" := Check."Bank Name";
          Modify;
          Duplicate;
        end;
    end;

    local procedure SetDataInModel(var Model: Record "ForNAV Check Model")
    begin
        with Model do begin
          Reset;
          FindSet;
          repeat
            SetType;
            SetIsVoid;
            SetAddress;
            SetMICRLine;
            SetPayToAddress;
            VoidCheckFields;
            Modify;
          until Next = 0;
        end;
    end;

    local procedure CreateEmptyLinesInStub(var Model: Record "ForNAV Check Model";var NextLineNo: Integer)
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CheckSetup.Get;
        if NextLineNo >= CheckSetup."No. of Lines (Stub)" then
          exit;

        while NextLineNo < CheckSetup."No. of Lines (Stub)" do
          with Model do begin
            Init;
            "Part No." := 1;
            NextLineNo  += 1;
            "Line No." := NextLineNo;
            Insert;
            Duplicate;
          end;
    end;

    local procedure ValidLine(var Args: Record "ForNAV Check Arguments";var GenJnlLn: Record "Gen. Journal Line";var Model: Record "ForNAV Check Model"): Boolean
    begin
        with Args do
          if not "One Check Per Vendor" then
            exit(true);

        if not Model.FindFirst then
          exit(true);

        exit(GenJnlLn."Account No." <> Model."Pay-to Vendor No.");
    end;
}

