Table 70301 "ForNAV Check"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Check No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(2;Test;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(5;"Currency Code";Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(6;"Posting Date";Date)
        {
            DataClassification = SystemMetadata;
        }
        field(8;"Bank Account No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(9;"Balancing Type";Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account";
        }
        field(10;"Balancing No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(11;Amount;Decimal)
        {
            DataClassification = SystemMetadata;
        }
        field(12;"Document No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(25;"Amount as Text (LCY)";Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(26;"Amount as Text";Text[250])
        {
            DataClassification = SystemMetadata;
        }
        field(27;"Application Method";Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = Payment,OneLineOneEntry,OneLineID,MoreLinesOneEntry;
        }
        field(28;"Applies-to Doc. No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(29;"Applies-to ID";Code[50])
        {
            DataClassification = SystemMetadata;
        }
        field(31;"Amount Filled as Text";Text[30])
        {
            DataClassification = SystemMetadata;
        }
        field(36;"Pay-to Vendor No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(38;"Pay-to Name";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(42;"Bank Name";Text[50])
        {
            DataClassification = SystemMetadata;
        }
        field(50;"Pay-to Name 2";Text[50])
        {
            Caption = 'Pay-to Name 2';
            DataClassification = SystemMetadata;
        }
        field(52;"Pay-to Address";Text[50])
        {
            Caption = 'Pay-to Address';
            DataClassification = SystemMetadata;
        }
        field(53;"Pay-to Address 2";Text[50])
        {
            Caption = 'Pay-to Address 2';
            DataClassification = SystemMetadata;
        }
        field(54;"Pay-to City";Text[30])
        {
            Caption = 'Pay-to City';
            DataClassification = SystemMetadata;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(55;"Pay-to Post Code";Code[20])
        {
            Caption = 'Pay-to Post Code';
            DataClassification = SystemMetadata;
            //This property is currently not supported
            //TestTableRelation = false;
            //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
            //ValidateTableRelation = false;
        }
        field(56;"Pay-to County";Text[30])
        {
            Caption = 'Pay-to County';
            DataClassification = SystemMetadata;
        }
        field(57;"Pay-to Country/Region Code";Code[10])
        {
            Caption = 'Pay-to Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1;"Check No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateFromGenJnlLn(var Args: Record "ForNAV Check Arguments";GenJnlLn: Record "Gen. Journal Line")
    var
        BankAccount: Record "Bank Account";
    begin
        "Check No." := Args.GetNextCheckNo;
        Test := Args."Test Print";
        "Currency Code" := GenJnlLn."Currency Code";
        "Posting Date" := GenJnlLn."Posting Date";
        "Bank Account No." := Args."Bank Account No.";
        BankAccount.Get("Bank Account No.");
        "Bank Name" := BankAccount.Name;
        "Document No." := GenJnlLn."Document No.";
        "Applies-to Doc. No." := GenJnlLn."Applies-to Doc. No.";
        "Applies-to ID" := GenJnlLn."Applies-to ID";
        "Balancing Type" := GenJnlLn."Account Type";
        "Balancing No." := GenJnlLn."Account No.";
        GetAmount(Args, GenJnlLn);
        GetAmountsAsText;
        GetApplicationMethod(Args, GenJnlLn);
        GetPayToAddress(GenJnlLn);
        Insert;
    end;

    procedure GetStub(Args: Record "ForNAV Check Arguments";var Stub: Record "ForNAV Stub";GenJnlLine: Record "Gen. Journal Line")
    var
        CreateStub: Codeunit "ForNAV Create Stub";
    begin
        CreateStub.FromCheck(Args, Rec, Stub, GenJnlLine);
    end;

    procedure UpdateJournal(Args: Record "ForNAV Check Arguments";var GenJnlLine: Record "Gen. Journal Line")
    var
        CheckUpdateJournal: Codeunit "ForNAV Check Update Journal";
    begin
        CheckUpdateJournal.UpdateJournal(Args, Rec, GenJnlLine);
    end;

    procedure CreateCheckLedgerEntry(Args: Record "ForNAV Check Arguments";GenJnlLine: Record "Gen. Journal Line")
    var
        CreateCheckLedgEnt: Codeunit "ForNAV Create Check Ledg. Ent.";
    begin
        CreateCheckLedgEnt.CreateCheckLedgerEntry(Args, Rec, GenJnlLine);
    end;

    local procedure GetAmountsAsText()
    var
        GLSetup: Record "General Ledger Setup";
        AmountasText: Codeunit "ForNAV Amount as Text";
        NumberText: array [2] of Text[80];
    begin
        AmountasText.InitTextVariable;
        AmountasText.FormatNoText(NumberText,Amount,"Currency Code");
        "Amount as Text (LCY)" := NumberText[1];
        "Amount as Text" := NumberText[2];
        "Amount Filled as Text" := Format(Amount,0,'<Integer Thousand><Decimals,3>');
        while StrLen("Amount Filled as Text") < 17 do
          "Amount Filled as Text" := '*' + "Amount Filled as Text";

        GLSetup.Get;
        "Amount Filled as Text" := GLSetup."Local Currency Symbol" + "Amount Filled as Text";
    end;

    local procedure GetApplicationMethod(Args: Record "ForNAV Check Arguments";FromGenJournalLine: Record "Gen. Journal Line")
    begin
        with FromGenJournalLine do begin
          if Args."One Check Per Vendor" then
            "Application Method" := "application method"::MoreLinesOneEntry
          else
            if "Applies-to Doc. No." <> '' then
              "Application Method" := "application method"::OneLineOneEntry
            else
              if "Applies-to ID" <> '' then
                "Application Method" := "application method"::OneLineID
              else
                "Application Method" := "application method"::Payment;
        end;
    end;

    local procedure GetAmount(Args: Record "ForNAV Check Arguments";FromGenJournalLine: Record "Gen. Journal Line")
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        if Args."One Check Per Vendor" then begin
          with FromGenJournalLine do begin
            GenJournalLine.Reset;
            GenJournalLine.SetCurrentkey("Journal Template Name","Journal Batch Name","Posting Date","Document No.");
            GenJournalLine.SetRange("Journal Template Name", "Journal Template Name");
            GenJournalLine.SetRange("Journal Batch Name", "Journal Batch Name");
            GenJournalLine.SetRange("Posting Date","Posting Date");
            GenJournalLine.SetRange("Document No.","Document No.");
            GenJournalLine.SetRange("Account Type","Account Type");
            GenJournalLine.SetRange("Account No.","Account No.");
            GenJournalLine.SetRange("Bal. Account Type","Bal. Account Type");
            GenJournalLine.SetRange("Bal. Account No.","Bal. Account No.");
            GenJournalLine.SetRange("Bank Payment Type","Bank Payment Type");
            GenJournalLine.CalcSums(Amount);
          end;
          Amount := GenJournalLine.Amount;
        end else
          Amount := FromGenJournalLine.Amount;
    end;

    local procedure GetPayToAddress(var GenJnlLn: Record "Gen. Journal Line")
    var
        Cust: Record Customer;
        Vend: Record Vendor;
    begin
        case GenJnlLn."Account Type" of
          GenJnlLn."account type"::Customer:
            begin
              Cust.Get(GenJnlLn."Account No.");
              "Pay-to Vendor No." := GenJnlLn."Account No.";
              "Pay-to Name" := Cust.Name;
              "Pay-to Name 2" := Cust."Name 2";
              "Pay-to Address" := Cust.Address;
              "Pay-to Address 2" := Cust."Address 2";
              "Pay-to City" := Cust.City;
              "Pay-to Post Code" := Cust."Post Code";
              "Pay-to County" := Cust.County;
              "Pay-to Country/Region Code" := Cust."Country/Region Code";
            end;
          GenJnlLn."account type"::Vendor:
            begin
              Vend.Get(GenJnlLn."Account No.");
              "Pay-to Vendor No." := GenJnlLn."Account No.";
              "Pay-to Name" := Vend.Name;
              "Pay-to Name 2" := Vend."Name 2";
              "Pay-to Address" := Vend.Address;
              "Pay-to Address 2" := Vend."Address 2";
              "Pay-to City" := Vend.City;
              "Pay-to Post Code" := Vend."Post Code";
              "Pay-to County" := Vend.County;
              "Pay-to Country/Region Code" := Vend."Country/Region Code";
           end;
        end;
    end;
}

