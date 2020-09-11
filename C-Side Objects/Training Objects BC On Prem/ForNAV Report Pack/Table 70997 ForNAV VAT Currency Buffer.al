Table 70997 "ForNAV VAT Currency Buffer"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Currency Code";Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(2;"Currency Factor";Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = SystemMetadata;
        }
        field(3;"VAT Base Amount";Decimal)
        {
            Caption = 'VAT Base Amount';
            DataClassification = SystemMetadata;
        }
        field(4;"VAT Amount";Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = SystemMetadata;
        }
        field(5;"VAT %";Decimal)
        {
            Caption = 'VAT %';
            DataClassification = SystemMetadata;
        }
        field(6;"VAT Identifier";Code[20])
        {
            Caption = 'VAT Identifier';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Currency Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure InsertLine()
    var
        VATCurrency: Record "ForNAV VAT Currency Buffer";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get;
        "Currency Code" := GLSetup."LCY Code";

        VATCurrency := Rec;
        if Find then begin
          "VAT Base Amount" := "VAT Base Amount" + VATCurrency."VAT Amount";
          "VAT Amount" := "VAT Amount" + VATCurrency."VAT Amount";
          Modify;
        end else begin
          Insert;
        end;
    end;
}

