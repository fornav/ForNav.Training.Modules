Table 70000 "ForNAV Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Setup';

    fields
    {
        field(1;"Primary Key";Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(9;Region;Option)
        {
            Caption = 'Region';
            DataClassification = CustomerContent;
            ObsoleteReason = 'Too complex';
            ObsoleteState = Removed;
            OptionCaption = 'World Wide,North America,Other';
            OptionMembers = "World Wide","North America",Other;
        }
        field(10;"VAT Report Type";Option)
        {
            Caption = 'VAT Report Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Multiple Lines,Always,Never';
            OptionMembers = "Multiple Lines",Always,Never,"N/A. (Sales Tax)";
        }
        field(14;"Inherit Language Code";Boolean)
        {
            Caption = 'Inherit Language Code';
            DataClassification = SystemMetadata;
            InitValue = true;
        }
        field(15;"Use Preprinted Paper";Boolean)
        {
            Caption = 'Use Preprinted Paper';
            DataClassification = SystemMetadata;
        }
        field(20;Logo;Blob)
        {
            Caption = 'Logo';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(21;"Logo File Name";Text[250])
        {
            Caption = 'Logo File Name';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            InitValue = 'Click to import...';
        }
        field(50;"Document Watermark File Name";Text[250])
        {
            Caption = 'Document Watermark File Name';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            InitValue = 'Click to import...';
        }
        field(51;"List Report Watermark File N.";Text[250])
        {
            Caption = 'List Report Watermark File Name';
            DataClassification = OrganizationIdentifiableInformation;
            Editable = false;
            InitValue = 'Click to import...';
        }
        field(60;"Document Watermark";Blob)
        {
            Caption = 'Document Watermark';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(61;"List Report Watermark";Blob)
        {
            Caption = 'List Report Watermark';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(70;"Payment Note";Text[250])
        {
            Caption = 'Payment Note';
            DataClassification = OrganizationIdentifiableInformation;
        }
        field(80;"Legal Conditions";Text[250])
        {
            Caption = 'Legal Conditions';
            DataClassification = OrganizationIdentifiableInformation;
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

    procedure ReplaceReportSelection(HideDialog: Boolean)
    var
        DoYouWantToQst: label 'Do you want to replace the current reports with the ForNAV reports?';
        ReplaceReportSel: Codeunit "ForNAV Replace Report Sel.";
    begin
        if not HideDialog then
          if not Confirm(DoYouWantToQst, true) then
            exit;

        ReplaceReportSel.Run;
    end;

    procedure DesignTemplatePortrait()
    var
        Template: Report "ForNAV Template";
    begin
        Template.RunModal;
    end;

    procedure DesignTemplateLandscape()
    var
        Template: Report "ForNAV Template - Landscape";
    begin
        Template.RunModal;
    end;

    procedure DesignSalesTemplate()
    var
        SalesTemplateVAT: Report "ForNAV Sales Template";
        SalesTemplSalesTax: Report "ForNAV Sales Templ. Sales Tax";
    begin
        if CheckIsSalesTax then
          SalesTemplSalesTax.RunModal
        else
          SalesTemplateVAT.RunModal;
    end;

    procedure DesignPurchaseTemplate()
    var
        PurchaseTemplVAT: Report "ForNAV Purchase Template";
        PurchaseTemplTax: Report "ForNAV Tax Purchase Templ.";
    begin
        if CheckIsSalesTax then
          PurchaseTemplTax.RunModal
        else
          PurchaseTemplVAT.RunModal;
    end;

    procedure DesignReminderTemplate()
    var
        Template: Report "ForNAV Reminder Template";
    begin
        Template.RunModal;
    end;

    procedure ImportWatermarkFromClientFile(Which: Integer): Boolean
    var
        ForNAVReadWatermarks: Codeunit "ForNAV Read Watermarks";
    begin
        exit(ForNAVReadWatermarks.ReadFromFile(Rec, Which));
    end;

    procedure GetLegalConditions(LanguageCode: Code[10]): Text
    var
        LegalCondTranslation: Record "ForNAV Legal Cond. Translation";
    begin
        if LegalCondTranslation.Get(LanguageCode) then
          exit(LegalCondTranslation."Legal Conditions");

        exit("Legal Conditions");
    end;

    procedure DownloadWatermarks()
    begin
        Hyperlink('http://www.fornav.com/report-watermarks/');
    end;

    procedure DownloadDesigner()
    var
        DownloadDesigner: Codeunit "ForNAV Download Designer";
    begin
        DownloadDesigner.Run;
    end;

    procedure CreateWebService()
    var
        CreateWebServices: Codeunit "ForNAV Create Web Services";
    begin
        CreateWebServices.Run;
    end;

    procedure GetCompanyLogo()
    var
        CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
        Logo := CompanyInformation.Picture;
    end;

    procedure GetDocumentWatermark(): Text
    var
        TempBlob: Record TempBlob;
    begin
        CalcFields("Document Watermark");
        TempBlob.Blob := "Document Watermark";
        exit(TempBlob.ToBase64String);
    end;

    procedure GetListReportWatermark(): Text
    var
        TempBlob: Record TempBlob;
    begin
        CalcFields("List Report Watermark");
        TempBlob.Blob := "List Report Watermark";
        exit(TempBlob.ToBase64String);
    end;

    procedure CheckIsSalesTax(): Boolean
    var
        IsSalesTax: Codeunit "ForNAV Is Sales Tax";
    begin
        exit(IsSalesTax.CheckIsSalesTax);
    end;
}

