pageextension 80100 "PageExtension80100" extends "Customer Card"
{
    actions
    {
        addlast(Reporting)
        {
            action(Labels)
            {
                Caption = 'ForNAV Create New Reports';
                Image = "PrintCover";
                Promoted = False;

                ApplicationArea = All;
                trigger OnAction()
                var
                    reportRec: Record "Customer";
                begin
                    reportRec := Rec;
                    reportRec.SetRecFilter;
                    Report.Run(Report::"ForNAV Create New Reports", true, false, reportRec);
                end;
            }
        }
    }
}
pageextension 80101 "PageExtension80101" extends "Customer List"
{
    actions
    {
        addlast(Reporting)
        {
            action(Labels)
            {
                Caption = 'ForNAV Create New Reports';
                Image = "PrintCover";
                Promoted = False;

                ApplicationArea = All;
                trigger OnAction()
                var
                    reportRec: Record "Customer";
                begin
                    reportRec.CopyFilters(Rec);
                    Report.Run(Report::"ForNAV Create New Reports", true, false, reportRec);
                end;
            }
        }
    }
}
