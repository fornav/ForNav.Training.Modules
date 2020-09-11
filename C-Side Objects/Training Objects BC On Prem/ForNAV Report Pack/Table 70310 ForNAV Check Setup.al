Table 70310 "ForNAV Check Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(10;"Layout";Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = " ","Check-Stub-Stub","Stub-Stub-Check","Stub-Check-Stub","3 Checks","Top Check with one Stub","Bottom Check with one Stub",,,Other;

            trigger OnValidate()
            begin
                "No. of Lines (Stub)" := MaxLineNo;
            end;
        }
        field(11;"No. of Lines (Stub)";Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(20;Watermark;Blob)
        {
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(21;"Watermark File Name";Text[250])
        {
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            InitValue = 'Click to import...';
        }
        field(30;Signature;Blob)
        {
            DataClassification = EndUserIdentifiableInformation;
        }
        field(31;"Signature File Name";Text[250])
        {
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            InitValue = 'Click to import...';
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    procedure InitSetup()
    begin
        if Get then
          exit;

        Init;
        Insert;
    end;

    local procedure MaxLineNo(): Integer
    begin
        case Layout of
          Layout::"3 Checks":
            exit(0);
          Layout::"Top Check with one Stub", Layout::"Bottom Check with one Stub":
            exit(20);
          else
            exit(9);
        end;
    end;

    procedure GetTypeBasedOnLayout(PartNo: Integer): Integer
    var
        Model: Record "ForNAV Check Model";
        NoImplementedErr: label 'This is not implemented, please contact your ForNAV partner.';
    begin
        case Layout of
          Layout::"3 Checks":
            exit(Model.Type::Check);
          Layout::"Top Check with one Stub":
            case PartNo of
              1: exit(Model.Type::Check);
              2: exit(Model.Type::Stub);
              3: exit(Model.Type::" ");
            end;
          Layout::"Bottom Check with one Stub":
            case PartNo of
              1: exit(Model.Type::Stub);
              2: exit(Model.Type::Check);
              3: exit(Model.Type::" ");
            end;
          Layout::"Check-Stub-Stub":
            case PartNo of
              1: exit(Model.Type::Check);
              2: exit(Model.Type::Stub);
              3: exit(Model.Type::Stub);
            end;
          Layout::Other:
            Error(NoImplementedErr);
          Layout::"Stub-Check-Stub":
            case PartNo of
              1: exit(Model.Type::Stub);
              2: exit(Model.Type::Check);
              3: exit(Model.Type::Stub);
            end;
          Layout::"Stub-Stub-Check":
            case PartNo of
              1: exit(Model.Type::Stub);
              2: exit(Model.Type::Stub);
              3: exit(Model.Type::Check);
            end;
        end;
    end;

    procedure ImportWatermarkFromClientFile(Which: Integer): Boolean
    var
        ReadCheckWatermarks: Codeunit "ForNAV Read Check Watermarks";
    begin
        exit(ReadCheckWatermarks.ReadFromFile(Rec, Which));
    end;

    procedure DesignTemplate()
    var
        Template: Report "ForNAV US Check";
    begin
        Template.RunModal;
    end;

    procedure DownloadWatermarks()
    begin
        Hyperlink('http://www.fornav.com/report-watermarks/');
    end;

    procedure SetDefault(Setup: Record "ForNAV Setup")
    var
        CheckSetup: Codeunit "ForNAV Check Setup";
    begin
        CheckSetup.SetCheckType(Setup, Rec);
    end;

    procedure GetCheckWatermark(): Text
    var
        TempBlob: Record TempBlob;
    begin
        CalcFields(Watermark);
        TempBlob.Blob := Watermark;
        exit(TempBlob.ToBase64String);
    end;
}

