Page 70005 "ForNAV Setup Wizard"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Setup';
    PageType = NavigatePage;
    SourceTable = "ForNAV Setup";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Control4)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible and not FinalStepVisible;
                field("MediaRepositoryStandard.Image";MediaRepositoryStandard.Image)
                {
                    ApplicationArea = Basic,Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Control2)
            {
                Editable = false;
                ShowCaption = false;
                Visible = TopBannerVisible and FinalStepVisible;
                field("MediaRepositoryDone.Image";MediaRepositoryDone.Image)
                {
                    ApplicationArea = Basic,Suite;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(Control11)
            {
                ShowCaption = false;
                Visible = FirstStepVisible;
                group("Welcome to ForNAV Setup")
                {
                    Caption = 'Welcome to ForNAV Setup';
                    Visible = FirstStepVisible;
                    group(Control9)
                    {
                        InstructionalText = 'The ForNAV report package contains several documents that are optimized to work with our designer. ';
                        ShowCaption = false;
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Control6)
                    {
                        InstructionalText = 'Choose Next so you can set up the ForNAV report package.';
                        ShowCaption = false;
                    }
                }
            }
            group(Control15)
            {
                ShowCaption = false;
                Visible = FinalStepVisible;
                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Control12)
                    {
                        InstructionalText = 'To enable the ForNAV report package choose Finish.';
                        ShowCaption = false;
                    }
                }
            }
            group(Control21)
            {
                InstructionalText = 'Step1. Select your payment note and legal clause.';
                ShowCaption = false;
                Visible = Step1Visible;
                field("Payment Note";"Payment Note")
                {
                    ApplicationArea = Basic;
                }
                field("Legal Conditions";"Legal Conditions")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Control1000000003)
            {
                InstructionalText = 'How to you want to print VAT on your documents?';
                ShowCaption = false;
                Visible = Step2Visible and (not IsSalesTax);
                field("VAT Report Type";"VAT Report Type")
                {
                    ApplicationArea = Basic;
                    Visible = not IsSalesTax;
                }
            }
            group(Control22)
            {
                InstructionalText = 'Which check layout are you using?';
                ShowCaption = false;
                Visible = Step2Visible and IsSalesTax;
                field(CheckLayout;CheckSetup.Layout)
                {
                    ApplicationArea = Basic;
                    Caption = 'Layout';
                    Visible = IsSalesTax;
                }
            }
            group(Control17)
            {
                InstructionalText = 'Do you want to replace the current report selections with the ForNAV reports?';
                ShowCaption = false;
                Visible = Step3Visible;
                field(ReplaceReports;ReplaceReports)
                {
                    ApplicationArea = Basic;
                    Caption = 'Replace Report Selections';
                }
            }
            group(Control30)
            {
                InstructionalText = 'Do you want to create the fields webservice?';
                ShowCaption = false;
                Visible = Step3Visible;
                field(CreateTheWebService;CreateTheWebService)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create The ForNAV Web Services';
                }
            }
            group(Control1000000001)
            {
                InstructionalText = 'A watermark can make your reports look nicer. Do you want to import one?';
                ShowCaption = false;
                Visible = Step2Visible;
                field(ImportWatermark;WatermarkTxt)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;

                    trigger OnDrillDown()
                    begin
                        ImportWatermarkFromClientFile(FieldNo("Document Watermark"));
                    end;
                }
                field(ImportWatermarkList;WatermarkListTxt)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;

                    trigger OnDrillDown()
                    begin
                        ImportWatermarkFromClientFile(FieldNo("List Report Watermark"));
                    end;
                }
                field(ImportCompanyLogo;CompanyLogoTxt)
                {
                    ApplicationArea = Basic;
                    Editable = false;
                    ShowCaption = false;

                    trigger OnDrillDown()
                    begin
                        ImportWatermarkFromClientFile(FieldNo(Logo));
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ActionBack)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Back';
                Enabled = BackActionEnabled;
                Image = PreviousRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Next';
                Enabled = NextActionEnabled;
                Image = NextRecord;
                InFooterBar = true;

                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = Basic,Suite;
                Caption = 'Finish';
                Enabled = FinishActionEnabled;
                Image = Approve;
                InFooterBar = true;

                trigger OnAction()
                begin
                    FinishAction;
                end;
            }
        }
    }

    trigger OnInit()
    begin
        LoadTopBanners;
    end;

    trigger OnOpenPage()
    begin
        Init;
        IsSalesTax := CheckSalesTax.CheckIsSalesTax;
        if Setup.Get then
          TransferFields(Setup)
        else begin
          CheckIsSalesTax;
          "Legal Conditions" := LegalConditionsTxt;
          "Payment Note" := PaymentNoteTxt;
          "VAT Report Type" := "vat report type"::"Multiple Lines";
        end;
        Insert;

        Step := Step::Start;
        EnableControls(false);
    end;

    var
        MediaRepositoryStandard: Record "Media Repository";
        MediaRepositoryDone: Record "Media Repository";
        Setup: Record "ForNAV Setup";
        CheckSetup: Record "ForNAV Check Setup";
        CheckSalesTax: Codeunit "ForNAV Is Sales Tax";
        IsSalesTax: Boolean;
        TopBannerVisible: Boolean;
        FinalStepVisible: Boolean;
        FirstStepVisible: Boolean;
        FinishActionEnabled: Boolean;
        BackActionEnabled: Boolean;
        NextActionEnabled: Boolean;
        Step1Visible: Boolean;
        Step2Visible: Boolean;
        Step3Visible: Boolean;
        ReplaceReports: Boolean;
        CreateTheWebService: Boolean;
        Step: Option Start,Step1,Step2,Step3,Finish;
        WatermarkTxt: label 'Click to import a watermark for document reports';
        WatermarkListTxt: label 'Click to import a watermark for list reports';
        CompanyLogoTxt: label 'Click to import a company logo';
        PaymentNoteTxt: label '- You can print a payment note here -';
        LegalConditionsTxt: label '- You can print your legal conditions here -';

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png',Format(CurrentClientType)) and
           MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png',Format(CurrentClientType))
        then
          TopBannerVisible := MediaRepositoryDone.Image.Hasvalue;
    end;

    local procedure EnableControls(Backwards: Boolean)
    begin
        ResetControls;

        case Step of
          Step::Start:
            ShowStartStep;
          Step::Step1:
            ShowStep1;
          Step::Step2:
            ShowStep2;
          Step::Step3:
            ShowStep3;
          Step::Finish:
            ShowFinishStep;
        end;
    end;

    local procedure ShowStartStep()
    begin
        FirstStepVisible := true;
        FinishActionEnabled := false;
        BackActionEnabled := false;
    end;

    local procedure ShowStep1()
    begin
        Step1Visible := true;
    end;

    local procedure ShowStep2()
    begin
        Step2Visible := true;
    end;

    local procedure ShowStep3()
    begin
        Step3Visible := true;
    end;

    local procedure ShowFinishStep()
    begin
        FinalStepVisible := true;
        NextActionEnabled := false;
    end;

    local procedure ResetControls()
    begin
        FinishActionEnabled := 1=1;
        BackActionEnabled := true;
        NextActionEnabled := true;

        FirstStepVisible := false;
        Step1Visible := false;
        Step2Visible := false;
        Step3Visible := false;
        FinalStepVisible := false;
    end;

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
          Step := Step - 1
        else
          Step := Step + 1;

        EnableControls(Backwards);
    end;

    local procedure FinishAction()
    begin
        StoreSetup;
        CurrPage.Close;
    end;

    local procedure StoreSetup()
    var
        SetCheckSetup: Codeunit "ForNAV Check Setup";
    begin
        if not Setup.Get then begin
          Setup.Init;
          Setup.Insert;
        end;

        if not CheckSetup.Get then begin
          CheckSetup.Init;
          CheckSetup.Insert;
        end;

        CalcFields(Logo, "Document Watermark", "List Report Watermark");
        Setup.TransferFields(Rec);

        if not Setup.Logo.Hasvalue then
          Setup.GetCompanyLogo;

        Setup.Modify;
        if ReplaceReports then
          Setup.ReplaceReportSelection(true);
        if CreateTheWebService then
          CreateWebService;

        SetCheckSetup.SetCheckType(Setup, CheckSetup);
    end;
}

