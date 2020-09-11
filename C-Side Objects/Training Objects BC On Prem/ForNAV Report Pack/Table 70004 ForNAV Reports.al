Table 70004 "ForNAV Reports"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Reports';

    fields
    {
        field(1;Category;Option)
        {
            Caption = 'Category';
            DataClassification = SystemMetadata;
            OptionCaption = 'Other,Sales,Purchase,Finance,Template,Example,Warehouse,Inventory';
            OptionMembers = Other,Sales,Purchase,Finance,Template,Example,Warehouse,Inventory;
        }
        field(2;ID;Integer)
        {
            Caption = 'Id';
            DataClassification = SystemMetadata;
        }
        field(10;Name;Text[250])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;Category,ID)
        {
        }
        key(Key2;ID)
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetCategory(Value: Text): Integer
    begin
        if StrPos(Value, 'Example') <> 0 then
          exit(Category::Example);

        if StrPos(Value, 'Templ') <> 0 then
          exit(Category::Template);

        if StrPos(Value, 'Warehouse') <> 0 then
          exit(Category::Warehouse);

        if StrPos(Value, 'Purch') <> 0 then
          exit(Category::Purchase);

        if (StrPos(Value, 'Order Confirmation') <> 0) or
          (StrPos(Value, 'Sales') <> 0) or
          (StrPos(Value, 'Salesperson') <> 0) or
          (StrPos(Value, 'Credit Memo') <> 0)
        then
          exit(Category::Sales);

        if (StrPos(Value, 'Inventory') <> 0) or
          (StrPos(Value, 'Item') <> 0)
        then
          exit(Category::Finance);

        if (StrPos(Value, 'Top 10') <> 0) or
          (StrPos(Value, 'Balance') <> 0) or
          (StrPos(Value, 'Reconcile') <> 0) or
          (StrPos(Value, 'Payments') <> 0) or
          (StrPos(Value, 'Statement') <> 0) or
          (StrPos(Value, 'Reminder') <> 0) or
          (StrPos(Value, 'Finance') <> 0) or
          (StrPos(Value, 'Aged Accounts') <> 0)
        then
          exit(Category::Finance);
    end;

    procedure IsValidForLocalization(Value: Text): Boolean
    var
        ForNAVSetup: Record "ForNAV Setup";
    begin
        if Category = Category::Example then
          exit(false);

        ForNAVSetup.Get;
        if (StrPos(Value, 'US Check') <> 0) and (ForNAVSetup."VAT Report Type" <> ForNAVSetup."vat report type"::"N/A. (Sales Tax)") then
          exit(false);

        if not (Category in [Category::Sales, Category::Purchase, Category::Template]) then
          exit(true);

        if (StrPos(Value, 'VAT') <> 0) and (ForNAVSetup."VAT Report Type" = ForNAVSetup."vat report type"::"N/A. (Sales Tax)") then
          exit(false);

        if (StrPos(Value, 'Tax') <> 0) and (ForNAVSetup."VAT Report Type" <> ForNAVSetup."vat report type"::"N/A. (Sales Tax)") then
          exit(false);

        exit(true);
    end;
}

