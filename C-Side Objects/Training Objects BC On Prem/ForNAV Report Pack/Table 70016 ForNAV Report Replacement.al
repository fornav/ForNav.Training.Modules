Table 70016 "ForNAV Report Replacement"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    Caption = 'Replace With Report';
    DataClassification = CustomerContent;

    fields
    {
        field(1;"Report ID";Integer)
        {
            Caption = 'Report ID';
            DataClassification = CustomerContent;
        }
        field(2;"User-ID";Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(3;"Responsibility Center";Code[20])
        {
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
        }
        field(4;"Replace-With Report ID";Integer)
        {
            Caption = 'Replace With Report ID';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(5;"Report Name";Text[50])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),
                                                                           "Object ID"=field("Report ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6;"Replace-With Report Name";Text[50])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where ("Object Type"=const(Report),
                                                                           "Object ID"=field("Replace-With Report ID")));
            Caption = 'Report Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Report ID","User-ID","Responsibility Center")
        {
        }
    }

    fieldgroups
    {
    }

    procedure TestReport()
    begin
        Report.Run("Report ID");
    end;

    procedure CreateForNAVDefaultReportReplacement()
    begin
        // To Do - Different List for Each Localization

        ReplaceReport(111, Report::"ForNAV Customer Top 10 List");
        ReplaceReport(311, Report::"ForNAV Vendor Top 10 List");
        ReplaceReport(6, Report::"ForNAV Trial Balance");
        //ReplaceReport( ,70207); //ForNAV Reconcile A/P to G/L
        //ReplaceReport( ,70210); //ForNAV Customer Payments
        //ReplaceReport( ,70211); //ForNAV Vendor Payments
        ReplaceReport(115, Report::"ForNAV Salesperson-Commission");
        ReplaceReport(120, Report::"ForNAV Aged Accounts Receivbl.");
        ReplaceReport(322, Report::"ForNAV Aged Accounts Payables");
        ReplaceReport(112, Report::"ForNAV Sales Statistics");
        ReplaceReport(312, Report::"ForNAV Purchase Statistics");
        //ReplaceReport( ,70240); //ForNAV Inv. to G/L Reconcile
        ReplaceReport(1001, Report::"ForNAV Inventory Valuation");
        ReplaceReport(712, Report::"ForNAV Cust./Item Statistics");
    end;

    local procedure ReplaceReport(ID: Integer;WithID: Integer)
    begin
        "Report ID" := ID;
        "Replace-With Report ID" := WithID;
        Insert;
    end;
}

