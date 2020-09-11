Page 70000 "ForNAV Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "ForNAV Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Inherit Language Code";"Inherit Language Code")
                {
                    ApplicationArea = Basic;
                }
                field("Use Preprinted Paper";"Use Preprinted Paper")
                {
                    ApplicationArea = Basic;
                }
            }
            group("Tax Setup")
            {
                Caption = 'Tax Setup';
                field("VAT Report Type";"VAT Report Type")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Text)
            {
                Caption = 'Text';
                field("Payment Note";"Payment Note")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field("Legal Conditions";"Legal Conditions")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
            }
            group(Logo)
            {
                Caption = 'Logo';
                field("Logo File Name";"Logo File Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Logo';

                    trigger OnDrillDown()
                    var
                        TempBlob: Record TempBlob;
                        FileManagement: Codeunit "File Management";
                    begin
                        CalcFields(Logo);
                        if "Logo File Name" <> 'Click to import...' then begin
                          TempBlob.Blob := Logo;
                          Hyperlink(FileManagement.BLOBExport(TempBlob, "Logo File Name", false));
                        end else
                          ImportWatermarkFromClientFile(FieldNo(Logo));
                        Modify;
                    end;
                }
                field("Document Watermark File Name";"Document Watermark File Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Document Watermark';
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        TempBlob: Record TempBlob;
                        FileManagement: Codeunit "File Management";
                    begin
                        CalcFields("Document Watermark");
                        if "Document Watermark File Name" <> 'Click to import...' then begin
                          TempBlob.Blob := "Document Watermark";
                          Hyperlink(FileManagement.BLOBExport(TempBlob, "Document Watermark File Name", false));
                        end else
                          ImportWatermarkFromClientFile(FieldNo("Document Watermark"));
                        Modify;
                    end;
                }
                field("List Report Watermark File N.";"List Report Watermark File N.")
                {
                    ApplicationArea = Basic;
                    Caption = 'List Report Watermark';

                    trigger OnDrillDown()
                    var
                        TempBlob: Record TempBlob;
                        FileManagement: Codeunit "File Management";
                    begin
                        CalcFields("List Report Watermark");
                        if "List Report Watermark File N." <> 'Click to import...' then begin
                          TempBlob.Blob := "List Report Watermark";
                          Hyperlink(FileManagement.BLOBExport(TempBlob, "List Report Watermark File N.", false));
                        end else
                          ImportWatermarkFromClientFile(FieldNo("List Report Watermark"));
                        Modify;
                    end;
                }
            }
        }
        area(factboxes)
        {
            systempart(MyNotes;MyNotes)
            {
            }
            systempart(RecordLinks;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Watermark)
            {
                Caption = 'Watermark';
                action(DownloadWatermark)
                {
                    ApplicationArea = Basic;
                    Caption = 'Download Watermark';
                    Image = Link;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DownloadWatermarks;
                    end;
                }
            }
            group(Delete)
            {
                Caption = 'Delete';
                action(DeleteDocWatermark)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document Watermark';
                    Image = Delete;

                    trigger OnAction()
                    var
                        AreYouSureQst: label 'Are you sure you want to clear %1?';
                    begin
                        if not Confirm(AreYouSureQst, false, FieldCaption("Document Watermark")) then
                          exit;

                        "Document Watermark File Name" := 'Click to import...';
                        Clear("Document Watermark");
                        Modify;
                    end;
                }
                action(DeleteListWatermark)
                {
                    ApplicationArea = Basic;
                    Caption = 'List Report Watermark';
                    Image = Delete;

                    trigger OnAction()
                    var
                        AreYouSureQst: label 'Are you sure you want to clear %1?';
                    begin
                        if not Confirm(AreYouSureQst, false, FieldCaption("List Report Watermark")) then
                          exit;

                        "List Report Watermark File N." := 'Click to import...';
                        Clear("List Report Watermark");
                        Modify;
                    end;
                }
                action(DeleteLogo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Logo';
                    Image = Delete;

                    trigger OnAction()
                    var
                        AreYouSureQst: label 'Are you sure you want to clear %1?';
                    begin
                        if not Confirm(AreYouSureQst, false, FieldCaption(Logo)) then
                          exit;

                        "Logo File Name" := 'Click to import...';
                        Clear(Logo);
                        Modify;
                    end;
                }
            }
            group(ForNAV)
            {
                Caption = 'ForNAV';
                action(ReplaceReports)
                {
                    ApplicationArea = Basic;
                    Caption = 'Replace Report Selections';
                    Image = SwitchCompanies;

                    trigger OnAction()
                    begin
                        ReplaceReportSelection(false);
                    end;
                }
                action(CreateWebservice)
                {
                    ApplicationArea = Basic;
                    Caption = 'Web Service';
                    Image = ServiceSetup;

                    trigger OnAction()
                    begin
                        CreateWebService;
                    end;
                }
            }
            group(Template)
            {
                Caption = 'Template';
                action(DesignTemplatePortrait)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design General Template (Portrait)';
                    Image = UnitOfMeasure;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DesignTemplatePortrait;
                    end;
                }
                action(DesignTemplateLandscape)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design General Template (Landscape)';
                    Image = VATPostingSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DesignTemplateLandscape;
                    end;
                }
                action(DesignSalesTemplate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design Sales Template';
                    Image = Design;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        DesignSalesTemplate;
                    end;
                }
                action(DesignPurchaseTemplate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design Purchase Template';
                    Image = DesignCodeBehind;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        DesignPurchaseTemplate;
                    end;
                }
                action(DesignReminderTemplate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design Reminder Template';
                    Image = CreateElectronicReminder;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        DesignReminderTemplate;
                    end;
                }
            }
        }
        area(navigation)
        {
            action(Translations)
            {
                ApplicationArea = Basic;
                Caption = 'Translations';
                Image = Translations;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                RunObject = Page "ForNAV Legal Cond. Translation";
            }
        }
    }

    trigger OnOpenPage()
    begin
        InitSetup;
    end;
}

