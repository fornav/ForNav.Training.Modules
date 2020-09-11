Page 70016 "ForNAV Replace Reports"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    Caption = 'ForNAV Replace With Report';
    PageType = List;
    SourceTable = "ForNAV Report Replacement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Report ID";"Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("User-ID";"User-ID")
                {
                    ApplicationArea = Basic;
                }
                field("Replace-With Report ID";"Replace-With Report ID")
                {
                    ApplicationArea = Basic;
                }
                field("Report Name";"Report Name")
                {
                    ApplicationArea = Basic;
                }
                field("Replace-With Report Name";"Replace-With Report Name")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ReplaceReports)
            {
                ApplicationArea = Basic;
                Caption = 'Replace Report Selections';
                Image = Default;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CreateForNAVDefaultReportReplacement;
                end;
            }
            action(Test)
            {
                ApplicationArea = Basic;
                Caption = 'Test';
                Image = TestReport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TestReport;
                end;
            }
        }
    }
}

