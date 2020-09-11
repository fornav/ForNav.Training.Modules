Table 70300 "ForNAV Check Arguments"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Primary Key";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(7;"Test Print";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(8;"Bank Account No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(12;"Reprint Checks";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(20;"One Check Per Vendor";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(25;"Check No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetNextCheckNo(): Code[20]
    begin
        "Check No." := IncStr("Check No.");
        if "Test Print" then
          "Check No." := 'XXXX';

        exit("Check No.");
    end;

    procedure TestMandatoryFields()
    begin
        TestField("Bank Account No.");
        TestField("Check No.");
    end;

    procedure CreateModelFromGenJnlLn(var GenJnlLn: Record "Gen. Journal Line";var Model: Record "ForNAV Check Model"): Boolean
    var
        CreateCheckModel: Codeunit "ForNAV Create Check Model";
    begin
        exit(CreateCheckModel.CreateFromGenJnlLn(Rec, GenJnlLn, Model));
    end;
}

