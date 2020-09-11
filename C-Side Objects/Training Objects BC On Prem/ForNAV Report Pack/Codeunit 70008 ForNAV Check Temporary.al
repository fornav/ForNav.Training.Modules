Codeunit 70008 "ForNAV Check Temporary"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // We use this codeunit because ReportsForNAV is backwards compatible with NAV 2015. This version does not support ISTEMPORARY on record variables


    trigger OnRun()
    begin
    end;

    procedure IsTemporary(Rec: Variant;ThrowError: Boolean): Boolean
    var
        RecRef: RecordRef;
        RecordRefLibrary: Codeunit "ForNAV RecordRef Library";
        RecordShouldBeTempErr: label 'The Record Variable (%1) must be temporary when callng this API.';
    begin
        RecordRefLibrary.ConvertToRecRef(Rec, RecRef);
        if RecRef.IsTemporary then
          exit(false);

        if ThrowError then
          Error(RecordShouldBeTempErr, RecRef.Name);

        exit(true);
    end;
}

