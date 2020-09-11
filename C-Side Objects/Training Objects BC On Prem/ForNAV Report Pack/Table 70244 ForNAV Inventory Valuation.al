Table 70244 "ForNAV Inventory Valuation"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Item No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(2;"Inventory Posting Group";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(3;"Location Code";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(4;"Variant Code";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(8;Description;Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(9;"Print Expected Cost";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(10;StartingInvoicedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(11;StartingInvoicedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(12;StartingExpectedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(13;StartingExpectedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(14;IncreaseInvoicedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(15;IncreaseInvoicedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(16;IncreaseExpectedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(17;IncreaseExpectedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(18;DecreaseInvoicedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(19;DecreaseInvoicedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(20;DecreaseExpectedValue;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(21;DecreaseExpectedQty;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(22;CostPostedToGL;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(23;InvCostPostedToGL;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(24;ExpCostPostedToGL;Decimal)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Item No.","Location Code","Variant Code")
        {
        }
        key(Key2;"Inventory Posting Group")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetPrintExpectedCost(Args: Record "ForNAV Inv. Valuation Args.")
    begin
        "Print Expected Cost" := PrintExpectedCost(Args);
    end;

    local procedure PrintExpectedCost(Args: Record "ForNAV Inv. Valuation Args."): Boolean
    begin
        if not Args."Expected Cost" then
          exit(false);

        if StartingExpectedQty <> StartingInvoicedQty then
          exit(true);

        if IncreaseExpectedQty <> IncreaseInvoicedQty then
          exit(true);

        if DecreaseExpectedQty <> DecreaseInvoicedQty then
          exit(true);

        if StartingInvoicedValue <> StartingExpectedValue then
          exit(true);

        if IncreaseInvoicedValue <> IncreaseExpectedValue then
          exit(true);

        if DecreaseInvoicedValue <> DecreaseExpectedValue then
          exit(true);

        exit(false);
    end;
}

