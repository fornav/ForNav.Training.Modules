Table 70205 "ForNAV Trial Balance Args."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Show by";Option)
        {
            Caption = 'Show by';
            DataClassification = SystemMetadata;
            OptionCaption = 'Last Year,Budget';
            OptionMembers = "Last Year",Budget;
        }
        field(2;"Net Change Actual";Boolean)
        {
            Caption = 'Net Change Actual';
            DataClassification = SystemMetadata;
        }
        field(3;"Net Change Actual Last Year";Boolean)
        {
            Caption = 'Net Change Actual Last Year';
            DataClassification = SystemMetadata;
        }
        field(4;"Variance in Changes";Boolean)
        {
            Caption = 'Difference';
            DataClassification = SystemMetadata;
        }
        field(5;"% Variance in Changes";Boolean)
        {
            Caption = 'Variance %';
            DataClassification = SystemMetadata;
        }
        field(6;"Balance at Date Actual";Boolean)
        {
            Caption = 'Balance at Date Actual';
            DataClassification = SystemMetadata;
        }
        field(7;"Balance at Date Act. Last Year";Boolean)
        {
            Caption = 'Balance at Date Act. Last Year';
            DataClassification = SystemMetadata;
        }
        field(8;"Variance in Balances";Boolean)
        {
            Caption = 'Difference';
            DataClassification = SystemMetadata;
        }
        field(9;"% Variance in Balances";Boolean)
        {
            Caption = 'Variance %';
            DataClassification = SystemMetadata;
        }
        field(10;"Rounding Factor";Option)
        {
            Caption = 'Rounding Factor';
            DataClassification = SystemMetadata;
            OptionCaption = 'None,1,1000,1000000';
            OptionMembers = "None","1","1000","1000000";
        }
        field(11;"Skip Accounts with all zero";Boolean)
        {
            Caption = 'Skip Accounts with all zero Amounts';
            DataClassification = SystemMetadata;
        }
        field(12;"All Amounts in LCY";Boolean)
        {
            Caption = 'All Amounts in LCY';
            DataClassification = SystemMetadata;
            InitValue = true;

            trigger OnValidate()
            begin
                GetReportingCurrency;
            end;
        }
        field(13;"From Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(14;"To Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(15;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Show by")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetNoOfColumns(): Integer
    var
        NoOfColumns: Integer;
    begin
        if "Net Change Actual" then
          NoOfColumns += 1;
        if "Net Change Actual Last Year" then
          NoOfColumns += 1;
        if "Variance in Changes" then
          NoOfColumns += 1;
        if "% Variance in Changes" then
          NoOfColumns += 1;
        if "Balance at Date Actual" then
          NoOfColumns += 1;
        if "Balance at Date Act. Last Year" then
          NoOfColumns += 1;
        if "Variance in Balances" then
          NoOfColumns += 1;
        if "% Variance in Balances" then
          NoOfColumns += 1;

        exit(NoOfColumns);
    end;

    local procedure GetReportingCurrency()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        "Currency Code" := '';

        if "All Amounts in LCY" then
          exit;

        GLSetup.Get;
        GLSetup.TestField("Additional Reporting Currency");
        "Currency Code" := GLSetup."Additional Reporting Currency";
    end;
}

