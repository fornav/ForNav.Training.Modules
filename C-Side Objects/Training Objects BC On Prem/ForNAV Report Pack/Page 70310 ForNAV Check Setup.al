Page 70310 "ForNAV Check Setup"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "ForNAV Check Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Layout";Layout)
                {
                    ApplicationArea = Basic;
                }
                field("No. of Lines (Stub)";"No. of Lines (Stub)")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Visuals)
            {
                field("Watermark File Name";"Watermark File Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Watermark';

                    trigger OnDrillDown()
                    var
                        TempBlob: Record TempBlob;
                        FileManagement: Codeunit "File Management";
                    begin
                        CalcFields(Watermark);
                        if "Watermark File Name" <> 'Click to import...' then begin
                          TempBlob.Blob := Watermark;
                          Hyperlink(FileManagement.BLOBExport(TempBlob, "Watermark File Name", false));
                        end else
                          ImportWatermarkFromClientFile(FieldNo(Watermark));
                        Modify;
                    end;
                }
                field("Signature File Name";"Signature File Name")
                {
                    ApplicationArea = Basic;

                    trigger OnDrillDown()
                    var
                        TempBlob: Record TempBlob;
                        FileManagement: Codeunit "File Management";
                    begin
                        CalcFields(Signature);
                        if "Signature File Name" <> 'Click to import...' then begin
                          TempBlob.Blob := Signature;
                          Hyperlink(FileManagement.BLOBExport(TempBlob, "Signature File Name", false));
                        end else
                          ImportWatermarkFromClientFile(FieldNo(Signature));
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
                action(DownloadWatermark)
                {
                    ApplicationArea = Basic;
                    Caption = 'Download Watermarks';
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
            group("Delete Visuals")
            {
                action(DeleteWatermark)
                {
                    ApplicationArea = Basic;
                    Caption = 'Watermark';
                    Image = Delete;

                    trigger OnAction()
                    var
                        AreYouSureQst: label 'Are you sure you want to clear %1?';
                    begin
                        if not Confirm(AreYouSureQst, false, FieldCaption(Watermark)) then
                          exit;

                        "Watermark File Name" := 'Click to import...';
                        Clear(Watermark);
                        Modify;
                    end;
                }
                action(DeleteSignature)
                {
                    ApplicationArea = Basic;
                    Caption = 'Signature';
                    Image = Delete;

                    trigger OnAction()
                    var
                        AreYouSureQst: label 'Are you sure you want to clear %1?';
                    begin
                        if not Confirm(AreYouSureQst, false, FieldCaption(Signature)) then
                          exit;

                        "Signature File Name" := 'Click to import...';
                        Clear(Signature);
                        Modify;
                    end;
                }
            }
            group(System)
            {
                action(ReplaceReports)
                {
                    ApplicationArea = Basic;
                    Caption = 'Replace Reportselection';
                    Image = SwitchCompanies;

                    trigger OnAction()
                    begin
                        Error('TODO');
                        //ReplaceReportSelection(FALSE);
                    end;
                }
            }
            group(Template)
            {
                action(DesignTemplate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Design';
                    Image = VATPostingSetup;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DesignTemplate;
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

