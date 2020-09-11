Table 70303 "ForNAV Check Model"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Page No.";Integer)
        {
            DataClassification = SystemMetadata;
            InitValue = 1;
        }
        field(2;"Part No.";Option)
        {
            DataClassification = SystemMetadata;
            InitValue = "1";
            OptionMembers = " ","1","2","3";
        }
        field(3;"Line No.";Integer)
        {
            DataClassification = SystemMetadata;
            InitValue = 1;
        }
        field(6;Test;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(7;Void;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(8;Type;Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = " ",Check,Stub;
        }
        field(10;"Check No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(11;"Amount Written in Text";Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(12;"Amount in Numbers";Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(13;"Pay-to Name";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(14;"Bank Name";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(30;"Pay-to Vendor No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(31;"Pay-to Name 2";Text[50])
        {
            Caption = 'Pay-to Name 2';
            DataClassification = SystemMetadata;
        }
        field(32;"Pay-to Address";Text[50])
        {
            Caption = 'Pay-to Address';
            DataClassification = SystemMetadata;
        }
        field(33;"Pay-to Address 2";Text[50])
        {
            Caption = 'Pay-to Address 2';
            DataClassification = SystemMetadata;
        }
        field(34;"Pay-to City";Text[30])
        {
            Caption = 'Pay-to City';
            DataClassification = SystemMetadata;
            TableRelation = if ("Country/Region Code"=const('')) "Post Code".City
                            else if ("Country/Region Code"=filter(<>'')) "Post Code".City where ("Country/Region Code"=field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35;"Pay-to Post Code";Code[20])
        {
            Caption = 'Pay-to Post Code';
            DataClassification = SystemMetadata;
            TableRelation = if ("Country/Region Code"=const('')) "Post Code".Code
                            else if ("Country/Region Code"=filter(<>'')) "Post Code".Code where ("Country/Region Code"=field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(36;"Pay-to County";Text[30])
        {
            Caption = 'Pay-to County';
            DataClassification = SystemMetadata;
        }
        field(37;"Pay-to Country/Region Code";Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";
        }
        field(40;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(41;"Name 2";Text[50])
        {
            Caption = 'Name 2';
            DataClassification = SystemMetadata;
        }
        field(42;Address;Text[50])
        {
            Caption = 'Address';
            DataClassification = SystemMetadata;
        }
        field(43;"Address 2";Text[50])
        {
            Caption = 'Address 2';
            DataClassification = SystemMetadata;
        }
        field(44;City;Text[30])
        {
            Caption = 'City';
            DataClassification = SystemMetadata;
            TableRelation = if ("Country/Region Code"=const('')) "Post Code".City
                            else if ("Country/Region Code"=filter(<>'')) "Post Code".City where ("Country/Region Code"=field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(45;"Post Code";Code[20])
        {
            Caption = 'Post Code';
            DataClassification = SystemMetadata;
            TableRelation = if ("Country/Region Code"=const('')) "Post Code".Code
                            else if ("Country/Region Code"=filter(<>'')) "Post Code".Code where ("Country/Region Code"=field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(46;County;Text[30])
        {
            Caption = 'County';
            DataClassification = SystemMetadata;
        }
        field(47;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";
        }
        field(50;"Document Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(55;"Document No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(60;"External Document No.";Text[35])
        {
            DataClassification = SystemMetadata;
        }
        field(65;Amount;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(70;"Discount Amount";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(75;"Net Amount";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(80;"Document Type";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(85;"Amount Paid";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(90;"Job No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(95;"Currency Code";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(100;"Posting Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(110;"Micr Line";Text[100])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Page No.","Part No.","Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetPageAndLineNo(var NextLineNo: Integer)
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CheckSetup.Get;
        NextLineNo += 1;
        "Part No." := 1;
        if "Line No." = CheckSetup."No. of Lines (Stub)" then begin
          "Page No." += 1;
          NextLineNo := 1;
        end;
        "Line No." := NextLineNo;
    end;

    procedure Duplicate()
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CheckSetup.Get;
        if CheckSetup.Layout = CheckSetup.Layout::"3 Checks" then
          exit;

        "Part No." := 2;
        Insert;

        if CheckSetup.Layout = CheckSetup.Layout::"Top Check with one Stub" then
          exit;

        "Part No." := 3;
        Insert;
    end;

    procedure SetType()
    var
        CheckSetup: Record "ForNAV Check Setup";
    begin
        CheckSetup.Get;
        Type := CheckSetup.GetTypeBasedOnLayout("Part No.");
    end;

    procedure SetIsVoid()
    begin
        Void := "Page No." <> 1;
    end;

    procedure SetAddress()
    var
        CompInfo: Record "Company Information";
    begin
        if Void or Test then begin
          Name := 'XXXXXXXXXXXXXXXXXXXXXXXX';
          Address := 'XXXXXXXXXXXXXXXXXXXXXXXX';
          "Post Code" := 'XXXXX';
          "Country/Region Code" := 'XX';
        end else begin
          CompInfo.Get;
          Name := CompInfo.Name;
          "Name 2" := CompInfo."Name 2";
          Address := CompInfo.Address;
          "Address 2" := CompInfo."Address 2";
          "Post Code" := CompInfo."Post Code";
          City := CompInfo.City;
          County := CompInfo.County;
          "Country/Region Code" := CompInfo."Country/Region Code";
        end;
    end;

    procedure VoidCheckFields()
    begin
        if not (Void or Test) then
          exit;

        "Check No." := 'XXXXX';
        "Amount Written in Text" := 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        "Amount in Numbers" := 'XXXXXXXXXXXXX';
    end;

    procedure SetPayToAddress()
    begin
        if Void or Test then begin
          "Pay-to Name" := 'XXXXXXXXXXXXXXXXXXXXXXXX';
          "Pay-to Name 2" := '';
          "Pay-to Address" := 'XXXXXXXXXXXXXXXXXXXXXXXX';
          "Pay-to Address 2" := '';
          "Pay-to Post Code" := 'XXXXX';
          "Pay-to County" := '';
          "Pay-to Country/Region Code" := 'XX';
        end;
    end;

    procedure SetMICRLine()
    var
        Handled: Boolean;
    begin
        SetMICRLineEvent("Micr Line", Handled);
        if Handled then
          exit;

        "Micr Line" := '#TBD...';
    end;

    [IntegrationEvent(false, false)]
    local procedure SetMICRLineEvent(var Value: Text[100];var Handled: Boolean)
    begin
    end;
}

