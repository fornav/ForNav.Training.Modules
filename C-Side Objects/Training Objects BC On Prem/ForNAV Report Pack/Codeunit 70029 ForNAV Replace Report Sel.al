Codeunit 70029 "ForNAV Replace Report Sel."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    trigger OnRun()
    var
        Dlg: Dialog;
    begin
        Dlg.Open('#1#####################################');
        Dlg.Update(1, 'Create Object Buffer');

        CreateBuffer;

        ReplaceSalesOrderConfirmation;                          Dlg.Update(1, 'Sales Order Confirmation');
        ReplaceSalesInvoice;                                    Dlg.Update(1, 'Sales Invoice');
        ReplaceSalesCreditMemo;                                 Dlg.Update(1, 'Sales Credit Memo');
        ReplaceSalesShipment;                                   Dlg.Update(1, 'Sales Shipment');
        ReplaceSalesQuote;                                      Dlg.Update(1, 'Sales Quote');
        ReplacePurchaseOrder;                                   Dlg.Update(1, 'Purchase Order');
        ReplacePurchaseInvoice;                                 Dlg.Update(1, 'Purchase Invoice');
        ReplacePurchaseQuote;                                   Dlg.Update(1, 'Purchase Quote');
        ReplacePurchaseCreditMemo;                              Dlg.Update(1, 'Purchase Credit Memo');
        ReplaceCheck;                                           Dlg.Update(1, 'Check');
        ReplaceStatement;                                       Dlg.Update(1, 'Statement');
        ReplaceReminder;                                        Dlg.Update(1, 'Reminder');
        ReplaceReminderTest;                                    Dlg.Update(1, 'Reminder Test');
        ReplaceFinanceChargeMemo;                               Dlg.Update(1, 'Finance Charge Memo');
        ReplaceFinanceChargeMemoTest;                           Dlg.Update(1, 'Finance Charge Memo Test');
    end;

    var
        "Object": Record "ForNAV Object" temporary;

    local procedure ReplaceSalesOrderConfirmation()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"S.Order");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"S.Order";
          Sequence := '1';
          "Report ID" := FindReportID('Order Confirmation', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplaceSalesInvoice()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"S.Invoice");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"S.Invoice";
          Sequence := '1';
          "Report ID" := FindReportID('Sales Invoice', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplaceSalesCreditMemo()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"S.Cr.Memo");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"S.Cr.Memo";
          Sequence := '1';
          "Report ID" := FindReportID('Credit Memo', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplaceSalesShipment()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"S.Shipment");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"S.Shipment";
          Sequence := '1';
          "Report ID" := FindReportID('Sales Shipment', '');
          Insert;
        end;
    end;

    local procedure ReplaceSalesQuote()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"S.Quote");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"S.Quote";
          Sequence := '1';
          "Report ID" := FindReportID('Sales Quote', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplacePurchaseOrder()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"P.Order");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"P.Order";
          Sequence := '1';
          "Report ID" := FindReportID('Purchase Order', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplacePurchaseQuote()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"P.Quote");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"P.Quote";
          Sequence := '1';
          "Report ID" := FindReportID('Purchase Quote', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplacePurchaseInvoice()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"P.Invoice");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"P.Invoice";
          Sequence := '1';
          "Report ID" := FindReportID('Purchase Invoice', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplacePurchaseCreditMemo()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"P.Cr.Memo");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"P.Cr.Memo";
          Sequence := '1';
          "Report ID" := FindReportID('Purchase Cr. Memo', GetPrefix);
          Insert;
        end;
    end;

    local procedure ReplaceCheck()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"B.Check");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"B.Check";
          Sequence := '1';
          "Report ID" := FindReportID('US Check', '');
          Insert;
        end;
    end;

    local procedure ReplaceStatement()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"C.Statement");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"C.Statement";
          Sequence := '1';
          "Report ID" := FindReportID('Statement', '');
          Insert;
        end;
    end;

    local procedure ReplaceReminder()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::Reminder);
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::Reminder;
          Sequence := '1';
          "Report ID" := FindReportID('Reminder', '');
          Insert;
        end;
    end;

    local procedure ReplaceReminderTest()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"Rem.Test");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"Rem.Test";
          Sequence := '1';
          "Report ID" := FindReportID('Reminder Test', '');
          Insert;
        end;
    end;

    local procedure ReplaceFinanceChargeMemo()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"Fin.Charge");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"Fin.Charge";
          Sequence := '1';
          "Report ID" := FindReportID('Finance Charge Memo', '');
          Insert;
        end;
    end;

    local procedure ReplaceFinanceChargeMemoTest()
    var
        ReportSelections: Record "Report Selections";
    begin
        with ReportSelections do begin
          SetRange(Usage, Usage::"F.C.Test");
          if not IsEmpty then
            DeleteAll;

          Usage := Usage::"F.C.Test";
          Sequence := '1';
          "Report ID" := FindReportID('Finance Charge Memo T.', '');
          Insert;
        end;
    end;

    local procedure FindReportID(ReportName: Text;Prefix: Text): Integer
    begin
        with Object do begin
          SetCurrentkey(Name);
          SetRange(Name, 'ForNAV ' + Prefix +ReportName);
          FindFirst;
          exit(ID);
        end;
    end;

    local procedure GetPrefix(): Text
    var
        ForNAVSetup: Record "ForNAV Setup";
    begin
        ForNAVSetup.Get;
        if ForNAVSetup.CheckIsSalesTax then
          exit('Tax ');

        exit('VAT ');
    end;

    local procedure CreateBuffer()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        with AllObjWithCaption do begin
          SetRange("Object Type", "object type"::Report);
          if FindSet then repeat
            Object.ID := AllObjWithCaption."Object ID";
            Object.Name := AllObjWithCaption."Object Name";
            Object.Insert;
          until Next = 0;
        end;
    end;
}

