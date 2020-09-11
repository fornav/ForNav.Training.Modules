Codeunit 70007 "ForNAV Get No. of Copies"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    begin
    end;

    procedure GetNoOfCopies(Rec: Variant): Integer
    var
        RecRefLib: Codeunit "ForNAV RecordRef Library";
        TestValidDociFace: Codeunit "ForNAV Test Valid Doc iFace";
        RecRef: RecordRef;
    begin
        RecRefLib.ConvertToRecRef(Rec, RecRef);
        if not TestValidDociFace.CheckValid(RecRef) then
          exit(0);

        exit(FindNoOfCopiesFromBillToCustomerNo(RecRef));
    end;

    local procedure FindNoOfCopiesFromBillToCustomerNo(var RecRef: RecordRef): Integer
    var
        Customer: Record Customer;
        "Field": Record "Field";
        FldRef: FieldRef;
    begin
        Field.SetRange(TableNo, RecRef.Number);
        Field.SetRange(FieldName, 'Bill-to Customer No.');
        if not Field.FindFirst then
          exit(0);

        FldRef := RecRef.Field(Field."No.");
        Customer.Get(FldRef.Value);
        exit(Customer."Invoice Copies");
    end;
}

