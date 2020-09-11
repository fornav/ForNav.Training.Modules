Table 70999 "ForNAV Document Line Buffer"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"VAT %";Decimal)
        {
            DataClassification = SystemMetadata;
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(2;"VAT Base";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(3;"VAT Amount";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
        }
        field(4;"Amount Including VAT";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(5;"VAT Identifier";Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(6;"Line Amount";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(7;"Inv. Disc. Base Amount";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(8;"Invoice Discount Amount";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
        }
        field(9;"VAT Calculation Type";Option)
        {
            DataClassification = SystemMetadata;
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(10;"Tax Group Code";Code[20])
        {
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "Tax Group";
        }
        field(11;Quantity;Decimal)
        {
            DataClassification = SystemMetadata;
            DecimalPlaces = 0:5;
            Editable = false;
        }
        field(12;Modified;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(13;"Use Tax";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(14;"Calculated VAT Amount";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(15;"VAT Difference";Decimal)
        {
            AutoFormatType = 1;
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(16;Positive;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(17;"Includes Prepayment";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(18;"VAT Clause Code";Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "VAT Clause";
        }
        field(19;"Tax Category";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(70000;"Line No.";Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(70001;Amount;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(70002;"Allow Invoice Disc.";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(70003;"Inv. Discount Amount";Decimal)
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateForRecRef(var RecRef: RecordRef)
    var
        Fld: Record "Field";
    begin
        FindAndSetField(RecRef, 'Line No.', 70000);

        Fld.SetRange(TableNo, Database::"ForNAV Document Line Buffer");
        Fld.SetFilter("No.", '<>70000');
        Fld.FindSet;
        repeat
          FindAndSetField(RecRef, Fld.FieldName, Fld."No.");
        until Fld.Next = 0;
    end;

    local procedure FindAndSetField(var RecRef: RecordRef;FieldName: Text;FieldNo: Integer)
    var
        FldRef: FieldRef;
        Fld: Record "Field";
        ThisRecRef: RecordRef;
        ThisFld: FieldRef;
    begin
        Fld.SetRange(TableNo, RecRef.Number);
        Fld.SetRange(FieldName, FieldName);
        if not Fld.FindFirst then
          exit;

        FldRef := RecRef.Field(Fld."No.");

        ThisRecRef.GetTable(Rec);
        ThisFld := ThisRecRef.Field(FieldNo);
        ThisFld.Value := FldRef.Value;

        ThisRecRef.SetTable(Rec);
        if FieldNo = 70000 then
          Insert
        else
          Modify;
    end;
}

