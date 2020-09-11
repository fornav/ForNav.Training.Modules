Codeunit 70011 "ForNAV Create Web Services"
{
    // version FORNAV3.2.0.1579/RP2.0.0


    trigger OnRun()
    begin
        CreateWebService;
    end;

    local procedure CreateWebService()
    var
        TempWebService: Record "ForNAV Web Service" temporary;
        RecRef: RecordRef;
        FldRef: FieldRef;
    begin
        CreateTempWebService(TempWebService);

        RecRef.Open(GetObjectID);

        with TempWebService do begin
          FindSet;
          repeat
            FldRef := RecRef.Field(FieldNo("Object Type"));
            FldRef.Value := "Object Type";

            FldRef := RecRef.Field(FieldNo("Object ID"));
            FldRef.Value := "Object ID";

            FldRef := RecRef.Field(FieldNo("Service Name"));
            FldRef.Value := "Service Name";
            FldRef.Validate;

            if not RecRef.Insert then
              exit;

            FldRef := RecRef.Field(FieldNo(Published));
            FldRef.Validate(true);

            RecRef.Modify;
          until Next = 0;
        end;
    end;

    local procedure GetObjectID(): Integer
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        with AllObjWithCaption do begin
          SetRange("Object Type", "object type"::Table);
          SetRange("Object ID", 2000000168);
          if not IsEmpty then
            exit(2000000168);
        end;

        exit(2000000076);
    end;

    local procedure CreateTempWebService(var WebService: Record "ForNAV Web Service")
    begin
        WebService."Object Type" := WebService."object type"::Page;
        WebService."Object ID" := Page::Fields;
        WebService."Service Name" := 'Fields';
        WebService.Insert;

        WebService."Object Type" := WebService."object type"::Page;
        WebService."Object ID" := Page::"ForNAV Fields Webservice";
        WebService."Service Name" := 'FieldsEx';
        WebService.Insert;

        if not IsCloud then
          exit;

        WebService."Object Type" := WebService."object type"::Codeunit;
        WebService."Object ID" := ObjectIDForCloudWS;
        WebService."Service Name" := 'ForNavBc';
        WebService.Insert;
    end;

    local procedure IsCloud(): Boolean
    var
        AllObj: Record AllObj;
    begin
        with AllObj do begin
          SetRange("Object Type", AllObj."object type"::Codeunit);
          SetRange("Object ID", ObjectIDForCloudWS);
          exit(not IsEmpty);
        end;
    end;

    local procedure ObjectIDForCloudWS(): Integer
    begin
        exit(6189102);
    end;
}

