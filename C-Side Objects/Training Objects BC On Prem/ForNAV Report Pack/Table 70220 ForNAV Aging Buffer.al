Table 70220 "ForNAV Aging Buffer"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Entry No.";Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(20;"Account Type";Option)
        {
            Caption = 'Account Type';
            DataClassification = SystemMetadata;
            OptionMembers = Customer,Vendor;
        }
        field(30;"Account No.";Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            TableRelation = if ("Account Type"=const(Customer)) Customer
                            else if ("Account Type"=const(Vendor)) Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(31;"Account Name";Text[50])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(35;"Credit Limit (LCY)";Decimal)
        {
            Caption = 'Credit Limit (LCY)';
            DataClassification = SystemMetadata;
        }
        field(40;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(50;"Document Type";Option)
        {
            Caption = 'Document Type';
            DataClassification = SystemMetadata;
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(60;"Document No.";Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
        field(61;"External Document No.";Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = SystemMetadata;
        }
        field(65;"Document Date";Date)
        {
            Caption = 'Document Date';
            DataClassification = SystemMetadata;
        }
        field(70;"Posting Date";Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(80;"Due Date";Date)
        {
            Caption = 'Due Date';
            DataClassification = SystemMetadata;
        }
        field(90;Amount;Decimal)
        {
            Caption = 'Amount';
            DataClassification = SystemMetadata;
        }
        field(95;"Amount (LCY)";Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = SystemMetadata;
        }
        field(100;Balance;Decimal)
        {
            Caption = 'Balance';
            DataClassification = SystemMetadata;
        }
        field(105;"Balance (LCY)";Decimal)
        {
            Caption = 'Balance (LCY)';
            DataClassification = SystemMetadata;
        }
        field(110;"Amount 1";Decimal)
        {
            CaptionClass = GetCaptionClass(1);
            DataClassification = SystemMetadata;
        }
        field(115;"Amount 1 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(1);
            DataClassification = SystemMetadata;
        }
        field(120;"Amount 2";Decimal)
        {
            CaptionClass = GetCaptionClass(2);
            DataClassification = SystemMetadata;
        }
        field(125;"Amount 2 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(2);
            DataClassification = SystemMetadata;
        }
        field(130;"Amount 3";Decimal)
        {
            CaptionClass = GetCaptionClass(3);
            DataClassification = SystemMetadata;
        }
        field(135;"Amount 3 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(3);
            DataClassification = SystemMetadata;
        }
        field(140;"Amount 4";Decimal)
        {
            CaptionClass = GetCaptionClass(4);
            DataClassification = SystemMetadata;
        }
        field(145;"Amount 4 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(4);
            DataClassification = SystemMetadata;
        }
        field(150;"Amount 5";Decimal)
        {
            CaptionClass = GetCaptionClass(5);
            DataClassification = SystemMetadata;
        }
        field(155;"Amount 5 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(5);
            DataClassification = SystemMetadata;
        }
        field(160;"Amount 6";Decimal)
        {
            CaptionClass = GetCaptionClass(6);
            DataClassification = SystemMetadata;
        }
        field(165;"Amount 6 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(6);
            DataClassification = SystemMetadata;
        }
        field(167;"Amount 7";Decimal)
        {
            CaptionClass = GetCaptionClass(7);
            DataClassification = SystemMetadata;
        }
        field(170;"Amount 7 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(7);
            DataClassification = SystemMetadata;
        }
        field(175;"Amount 8";Decimal)
        {
            CaptionClass = GetCaptionClass(8);
            DataClassification = SystemMetadata;
        }
        field(180;"Amount 8 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(8);
            DataClassification = SystemMetadata;
        }
        field(182;"Amount 9";Decimal)
        {
            CaptionClass = GetCaptionClass(9);
            DataClassification = SystemMetadata;
        }
        field(185;"Amount 9 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(9);
            DataClassification = SystemMetadata;
        }
        field(190;"Amount 10";Decimal)
        {
            CaptionClass = GetCaptionClass(10);
            DataClassification = SystemMetadata;
        }
        field(195;"Amount 10 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(10);
            DataClassification = SystemMetadata;
        }
        field(200;"Amount 11";Decimal)
        {
            CaptionClass = GetCaptionClass(11);
            DataClassification = SystemMetadata;
        }
        field(205;"Amount 11 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(11);
            DataClassification = SystemMetadata;
        }
        field(210;"Amount 12";Decimal)
        {
            CaptionClass = GetCaptionClass(12);
            DataClassification = SystemMetadata;
        }
        field(215;"Amount 12 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(12);
            DataClassification = SystemMetadata;
        }
        field(220;"Amount 13";Decimal)
        {
            CaptionClass = GetCaptionClass(13);
            DataClassification = SystemMetadata;
        }
        field(225;"Amount 13 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(13);
            DataClassification = SystemMetadata;
        }
        field(230;"Amount 14";Decimal)
        {
            CaptionClass = GetCaptionClass(14);
            DataClassification = SystemMetadata;
        }
        field(235;"Amount 14 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(14);
            DataClassification = SystemMetadata;
        }
        field(240;"Amount 15";Decimal)
        {
            CaptionClass = GetCaptionClass(15);
            DataClassification = SystemMetadata;
        }
        field(245;"Amount 15 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(15);
            DataClassification = SystemMetadata;
        }
        field(250;"Amount 16";Decimal)
        {
            CaptionClass = GetCaptionClass(16);
            DataClassification = SystemMetadata;
        }
        field(255;"Amount 16 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(16);
            DataClassification = SystemMetadata;
        }
        field(260;"Amount 17";Decimal)
        {
            CaptionClass = GetCaptionClass(17);
            DataClassification = SystemMetadata;
        }
        field(265;"Amount 17 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(17);
            DataClassification = SystemMetadata;
        }
        field(270;"Amount 18";Decimal)
        {
            CaptionClass = GetCaptionClass(18);
            DataClassification = SystemMetadata;
        }
        field(275;"Amount 18 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(18);
            DataClassification = SystemMetadata;
        }
        field(280;"Amount 19";Decimal)
        {
            CaptionClass = GetCaptionClass(19);
            DataClassification = SystemMetadata;
        }
        field(285;"Amount 19 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(19);
            DataClassification = SystemMetadata;
        }
        field(290;"Amount 20";Decimal)
        {
            CaptionClass = GetCaptionClass(20);
            DataClassification = SystemMetadata;
        }
        field(295;"Amount 20 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(20);
            DataClassification = SystemMetadata;
        }
        field(300;"Amount 21";Decimal)
        {
            CaptionClass = GetCaptionClass(21);
            DataClassification = SystemMetadata;
        }
        field(305;"Amount 21 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(21);
            DataClassification = SystemMetadata;
        }
        field(310;"Amount 22";Decimal)
        {
            CaptionClass = GetCaptionClass(22);
            DataClassification = SystemMetadata;
        }
        field(315;"Amount 22 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(22);
            DataClassification = SystemMetadata;
        }
        field(320;"Amount 23";Decimal)
        {
            CaptionClass = GetCaptionClass(23);
            DataClassification = SystemMetadata;
        }
        field(325;"Amount 23 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(23);
            DataClassification = SystemMetadata;
        }
        field(330;"Amount 24";Decimal)
        {
            CaptionClass = GetCaptionClass(24);
            DataClassification = SystemMetadata;
        }
        field(335;"Amount 24 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(24);
            DataClassification = SystemMetadata;
        }
        field(340;"Amount 25";Decimal)
        {
            CaptionClass = GetCaptionClass(25);
            DataClassification = SystemMetadata;
        }
        field(345;"Amount 25 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(25);
            DataClassification = SystemMetadata;
        }
        field(350;"Amount 26";Decimal)
        {
            CaptionClass = GetCaptionClass(26);
            DataClassification = SystemMetadata;
        }
        field(355;"Amount 26 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(26);
            DataClassification = SystemMetadata;
        }
        field(360;"Amount 27";Decimal)
        {
            CaptionClass = GetCaptionClass(27);
            DataClassification = SystemMetadata;
        }
        field(365;"Amount 27 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(27);
            DataClassification = SystemMetadata;
        }
        field(370;"Amount 28";Decimal)
        {
            CaptionClass = GetCaptionClass(28);
            DataClassification = SystemMetadata;
        }
        field(375;"Amount 28 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(28);
            DataClassification = SystemMetadata;
        }
        field(380;"Amount 29";Decimal)
        {
            CaptionClass = GetCaptionClass(29);
            DataClassification = SystemMetadata;
        }
        field(385;"Amount 29 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(29);
            DataClassification = SystemMetadata;
        }
        field(390;"Amount 30";Decimal)
        {
            CaptionClass = GetCaptionClass(30);
            DataClassification = SystemMetadata;
        }
        field(395;"Amount 30 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(30);
            DataClassification = SystemMetadata;
        }
        field(400;"Amount 31";Decimal)
        {
            CaptionClass = GetCaptionClass(31);
            DataClassification = SystemMetadata;
        }
        field(405;"Amount 31 (LCY)";Decimal)
        {
            CaptionClass = GetCaptionClass(31);
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
        key(Key2;"Currency Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        HeaderText: array [31] of Text;

    procedure GetCaptionClass(FieldNo: Integer): Text
    begin
        exit('3,' + HeaderText[FieldNo]);
    end;

    procedure SetCaptions(var Args: Record "ForNAV Aged Accounts Args.")
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(HeaderText) do
          HeaderText[i] := Args.GetCaption(i);
    end;

    procedure GetAccountName()
    var
        Customer: Record Customer;
        Vendor: Record Vendor;
    begin
        case "Account Type" of
          "account type"::Customer:
            begin
              Customer.Get("Account No.");
              "Account Name" := Customer.Name;
            end;
          "account type"::Vendor:
            begin
              Vendor.Get("Account No.");
              "Account Name" := Vendor.Name;
            end;
        end;
    end;
}

