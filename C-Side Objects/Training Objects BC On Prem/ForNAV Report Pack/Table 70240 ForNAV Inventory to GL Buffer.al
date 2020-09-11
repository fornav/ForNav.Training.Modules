Table 70240 "ForNAV Inventory to G/L Buffer"
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
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
        }
        field(2;"Variant Code";Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = SystemMetadata;
        }
        field(3;"Location Code";Code[10])
        {
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
        }
        field(8;"Inventory Value";Decimal)
        {
            Caption = 'Inventory Value';
            DataClassification = SystemMetadata;
        }
        field(9;"Received Not Invoiced";Decimal)
        {
            Caption = 'Received Not Invoiced';
            DataClassification = SystemMetadata;
        }
        field(10;"Shipped Not Invoiced";Decimal)
        {
            Caption = 'Shipped Not Invoiced';
            DataClassification = SystemMetadata;
        }
        field(11;"Total Expected Cost";Decimal)
        {
            Caption = 'Total Expected Cost';
            DataClassification = SystemMetadata;
        }
        field(12;"Received Not Invoiced Posted";Decimal)
        {
            Caption = 'Received Not Invoiced (Posted)';
            DataClassification = SystemMetadata;
        }
        field(13;"Shipped Not Invoiced Posted";Decimal)
        {
            Caption = 'Shipped Not Invoiced (Posted)';
            DataClassification = SystemMetadata;
        }
        field(14;"Net Expected Cost Posted";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(15;"Net Expected Cost Not Posted";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(16;"Total Invoiced Value";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(17;"Invoiced Value Posted";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(18;"Invoiced Value Not Posted";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(19;"Cost Amount (Expected)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(20;"Cost Amount (Expected) (ACY)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(30;"Expected Cost Posted to G/L";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(40;"Exp. Cost Posted to G/L (ACY)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(50;"Valued Quantity";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(60;"Invoiced Quantity";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(70;"Cost Amount (Actual)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(80;"Cost Amount (Actual) (ACY)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(90;"Cost Posted to G/L";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(100;"Cost Posted to G/L (ACY)";Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(200;"Pending Adj.";Boolean)
        {
            CalcFormula = exist("Post Value Entry to G/L" where ("Item No."=field("Item No.")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1;"Item No.","Variant Code","Location Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateValues(var Args: Record "ForNAV Inv. to G/L Arguments";Received: Boolean;Shipped: Boolean)
    var
        WrongCallErr: label 'Wrong Function Call';
        CheckTemporary: Codeunit "ForNAV Check Temporary";
    begin
        if (Received = Shipped) or (CheckTemporary.IsTemporary(Rec, false)) then
          Error(WrongCallErr);

        if "Valued Quantity" = 0 then
          "Valued Quantity" := "Invoiced Quantity"
        else
          if "Valued Quantity" > 0 then begin
            if Args."Amounts in Add. Currency" then begin
              "Received Not Invoiced" := "Cost Amount (Expected) (ACY)";
              "Received Not Invoiced Posted" := "Exp. Cost Posted to G/L (ACY)";
            end else begin
              "Received Not Invoiced" := "Cost Amount (Expected)";
              "Received Not Invoiced Posted" := "Expected Cost Posted to G/L";
            end;
          end else
            if "Valued Quantity" < 0 then
              if Args."Amounts in Add. Currency" then begin
                "Shipped Not Invoiced" := "Cost Amount (Expected) (ACY)";
                "Shipped Not Invoiced Posted" := "Exp. Cost Posted to G/L (ACY)";
              end else begin
                "Shipped Not Invoiced" := "Cost Amount (Expected)";
                "Shipped Not Invoiced Posted" := "Expected Cost Posted to G/L";
              end;

        "Total Expected Cost" := "Received Not Invoiced" + "Shipped Not Invoiced";
        "Net Expected Cost Posted" := "Received Not Invoiced Posted" + "Shipped Not Invoiced Posted";
        "Net Expected Cost Not Posted" := "Total Expected Cost" - "Net Expected Cost Posted";

        if Args."Amounts in Add. Currency" then begin
          "Total Invoiced Value" := "Cost Amount (Actual) (ACY)";
          "Invoiced Value Posted" := "Cost Posted to G/L (ACY)";
        end else begin
          "Total Invoiced Value" := "Cost Amount (Actual)";
          "Invoiced Value Posted" := "Cost Posted to G/L";
        end;

        "Invoiced Value Not Posted" := "Total Invoiced Value" - "Invoiced Value Posted";
        "Inventory Value" := "Total Invoiced Value" + "Total Expected Cost";
    end;
}

