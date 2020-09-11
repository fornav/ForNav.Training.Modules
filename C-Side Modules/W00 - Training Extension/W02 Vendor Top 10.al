Report 89001 "ForNAV W02 Vendor Top 10"
{
    // Copyright (c) 2019 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    WordLayout = './Layouts/ForNAV W02 Vendor Top 10.docx';
    DefaultLayout = Word;
    Caption = 'W02 Vendor Top 10';
    ApplicationArea = all;
    UsageCategory = ReportsandAnalysis;

    dataset
    {
        DataItem(List; Vendor)
        {
            DataItemTableView = sorting ("Balance (LCY)") order(Descending);
            CalcFields = "Balance (LCY)", "Purchases (LCY)";
            MaxIteration = 10;
            column(ReportForNavId_2; 2) { }
            column(ReportForNav_List; ReportForNavWriteDataItem('List', List)) { }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ForNavOpenDesigner; ReportForNavOpenDesigner)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Design';
                        Visible = ReportForNavAllowDesign;
                    }
                    field(NewLanguage; NewLanguage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Language';
                        TableRelation = Language;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnInitReport()
    begin
        ;
        ReportForNav.OnInit(89001, ReportForNavAllowDesign);
    end;

    trigger OnPostReport()
    begin
    end;

    trigger OnPreReport()
    begin
        ;
        if ReportForNav.LaunchDesigner(ReportForNavOpenDesigner) then CurrReport.Quit();
    end;

    local procedure SetLanguage()
    var
        Language: Record Language;
    begin
        if NewLanguage <> '' then
            CurrReport.Language(Language.GetLanguageID(NewLanguage));
    end;

    var
        NewLanguage: Code[10];

        // --> Reports ForNAV Autogenerated code - do not delete or modify
    var
        ReportForNavInitialized: Boolean;
        ReportForNavShowOutput: Boolean;
        ReportForNavTotalsCausedBy: Boolean;
        ReportForNavOpenDesigner: Boolean;
        [InDataSet]
        ReportForNavAllowDesign: Boolean;
        ReportForNav: Codeunit "ForNAV Report Management";

    local procedure ReportForNavSetTotalsCausedBy(value: Boolean)
    begin
        ReportForNavTotalsCausedBy := value;
    end;

    local procedure ReportForNavSetShowOutput(value: Boolean)
    begin
        ReportForNavShowOutput := value;
    end;

    local procedure ReportForNavInit(jsonObject: JsonObject)
    begin
        ReportForNav.Init(jsonObject, CurrReport.ObjectId);
    end;

    local procedure ReportForNavWriteDataItem(dataItemId: Text; rec: Variant): Text
    var
        values: Text;
        jsonObject: JsonObject;
        currLanguage: Integer;
    begin
        if not ReportForNavInitialized then begin
            ReportForNavInit(jsonObject);
            ReportForNavInitialized := true;
        end;

        case (dataItemId) of
        end;
        ReportForNav.AddDataItemValues(jsonObject, dataItemId, rec);
        jsonObject.WriteTo(values);
        exit(values);
    end;
    // Reports ForNAV Autogenerated code - do not delete or modify -->
}
