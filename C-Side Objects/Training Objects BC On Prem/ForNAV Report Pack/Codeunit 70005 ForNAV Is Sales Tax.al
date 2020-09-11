Codeunit 70005 "ForNAV Is Sales Tax"
{
    // version FORNAV3.2.0.1579/RP2.0.0


    trigger OnRun()
    begin
    end;

    procedure CheckIsSalesTax(): Boolean
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        with AllObjWithCaption do begin
          SetRange("Object Type", "object type"::Table);
          SetRange("Object ID", 10000);
          exit(not IsEmpty);
        end;
    end;
}

