Table 70206 "ForNAV Trial Balance"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"G/L Account No.";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        field(4;Description;Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(11;"Net Change Actual";Decimal)
        {
            Caption = 'Net Change Actual';
            DataClassification = SystemMetadata;
        }
        field(13;"Net Change Actual Last Year";Decimal)
        {
            Caption = 'Net Change Actual Last Year';
            DataClassification = SystemMetadata;
        }
        field(14;"Variance in Changes";Decimal)
        {
            Caption = 'Difference';
            DataClassification = SystemMetadata;
        }
        field(15;"% Variance in Changes";Decimal)
        {
            Caption = 'Variance %';
            DataClassification = SystemMetadata;
        }
        field(17;"Balance at Date Actual";Decimal)
        {
            Caption = 'Balance at Date Actual';
            DataClassification = SystemMetadata;
        }
        field(19;"Balance at Date Act. Last Year";Decimal)
        {
            Caption = 'Balance at Date Act. Last Year';
            DataClassification = SystemMetadata;
        }
        field(21;"Print Amount 1";Text[30])
        {
            CaptionClass = GetCaptionClass(1);
            DataClassification = SystemMetadata;
        }
        field(22;"Print Amount 2";Text[30])
        {
            CaptionClass = GetCaptionClass(2);
            DataClassification = SystemMetadata;
        }
        field(23;"Print Amount 3";Text[30])
        {
            CaptionClass = GetCaptionClass(3);
            DataClassification = SystemMetadata;
        }
        field(24;"Print Amount 4";Text[30])
        {
            CaptionClass = GetCaptionClass(4);
            DataClassification = SystemMetadata;
        }
        field(25;"Print Amount 5";Text[30])
        {
            CaptionClass = GetCaptionClass(5);
            DataClassification = SystemMetadata;
        }
        field(26;"Print Amount 6";Text[30])
        {
            CaptionClass = GetCaptionClass(6);
            DataClassification = SystemMetadata;
        }
        field(27;"Print Amount 7";Text[30])
        {
            CaptionClass = GetCaptionClass(7);
            DataClassification = SystemMetadata;
        }
        field(28;"Print Amount 8";Text[30])
        {
            CaptionClass = GetCaptionClass(8);
            DataClassification = SystemMetadata;
        }
        field(31;RoundTo;Option)
        {
            DataClassification = SystemMetadata;
            OptionMembers = Pennies,Dollars,Thousands;
        }
        field(32;"No. of Columns";Integer)
        {
            DataClassification = SystemMetadata;
        }
        field(41;"Variance in Balances";Decimal)
        {
            Caption = 'Difference';
            DataClassification = SystemMetadata;
        }
        field(42;"% Variance in Balances";Decimal)
        {
            Caption = 'Variance %';
            DataClassification = SystemMetadata;
        }
        field(43;Bold;Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(102;"Caption 1";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(103;"Caption 2";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(104;"Caption 3";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(105;"Caption 4";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(106;"Caption 5";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(107;"Caption 6";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(108;"Caption 7";Text[80])
        {
            DataClassification = SystemMetadata;
        }
        field(109;"Caption 8";Text[80])
        {
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"G/L Account No.")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateForGLAccount(var GLAccount: Record "G/L Account";Args: Record "ForNAV Trial Balance Args.")
    var
        TrialBalance: Codeunit "ForNAV Trial Balance";
    begin
        Init;
        "G/L Account No." := GLAccount."No.";

        TrialBalance.GetDataFromGLAccount(Rec, GLAccount, Args);

        Description := PadStr('',GLAccount.Indentation) + GLAccount.Name;

        if HasNumbers then begin
          FormatAmounts(Args);
          "No. of Columns" := Args.GetNoOfColumns;
          Bold := GLAccount."Account Type" <> GLAccount."account type"::Posting;//GLA.AccountType != 0)
          Insert;
        end;
    end;

    local procedure FormatAmounts(var Args: Record "ForNAV Trial Balance Args.")
    var
        i: Integer;
    begin
        if Args."Net Change Actual" then
          AddToNext(FormatAsNumber(Args, "Net Change Actual"), FieldCaption("Net Change Actual"), i);
        if Args."Net Change Actual Last Year" then
          AddToNext(FormatAsNumber(Args, "Net Change Actual Last Year"), FieldCaption("Net Change Actual Last Year"), i);
        if Args."Variance in Changes" then
          AddToNext(FormatAsNumber(Args, "Variance in Changes"), FieldCaption("Variance in Changes"), i);
        if Args."% Variance in Changes" then
          AddToNext(FormatAsPct("% Variance in Changes"), FieldCaption("% Variance in Changes"), i);
        if Args."Balance at Date Actual" then
          AddToNext(FormatAsNumber(Args, "Balance at Date Actual"), FieldCaption("Balance at Date Actual"), i);
        if Args."Balance at Date Act. Last Year" then
          AddToNext(FormatAsNumber(Args, "Balance at Date Act. Last Year"), FieldCaption("Balance at Date Act. Last Year"), i);
        if Args."Variance in Balances" then
          AddToNext(FormatAsNumber(Args, "Variance in Changes"), FieldCaption("Variance in Balances"), i);
        if Args."% Variance in Balances" then
          AddToNext(FormatAsPct("% Variance in Changes"), FieldCaption("% Variance in Balances"), i);
    end;

    local procedure AddToNext(Value: Text;Caption: Text;var i: Integer)
    begin
        i += 1;
        case i of
          1:
            begin
              "Print Amount 1" := Value;
              "Caption 1" := Caption;
            end;
          2:
            begin
              "Print Amount 2" := Value;
              "Caption 2" := Caption;
            end;
          3:
            begin
              "Print Amount 3" := Value;
              "Caption 3" := Caption;
            end;
          4:
            begin
              "Print Amount 4" := Value;
              "Caption 4" := Caption;
            end;
          5:
            begin
              "Print Amount 5" := Value;
              "Caption 5" := Caption;
            end;
          6:
            begin
              "Print Amount 6" := Value;
              "Caption 6" := Caption;
            end;
          7:
            begin
              "Print Amount 7" := Value;
              "Caption 7" := Caption;
            end;
          8:
            begin
              "Print Amount 8" := Value;
              "Caption 8" := Caption;
            end;
        end;
    end;

    local procedure RoundAmounts(Value: Decimal;Args: Record "ForNAV Trial Balance Args."): Decimal
    begin
        case Args."Rounding Factor" of
          Args."rounding factor"::None:
            exit(ROUND(Value, 0.01));
          Args."rounding factor"::"1":
            exit(ROUND(Value, 1));
          Args."rounding factor"::"1000":
            exit(ROUND(Value / 1000, 1));
          Args."rounding factor"::"1000000":
            exit(ROUND(Value / 10000000, 0.01));
        end;
    end;

    local procedure HasNumbers(): Boolean
    begin
        exit(("Net Change Actual" <> 0) or
          ("Net Change Actual Last Year" <> 0) or
          ("Balance at Date Actual" <> 0) or
          ("Balance at Date Act. Last Year" <> 0) or
          ("Variance in Changes" <> 0) or
          ("% Variance in Changes" <> 0));
    end;

    local procedure FormatAsNumber(Args: Record "ForNAV Trial Balance Args.";Value: Decimal) TheText: Text
    var
        j: Integer;
    begin
        if Value = 0 then
          TheText := ''
        else
          TheText := Format(RoundAmounts(Value, Args));
    end;

    local procedure FormatAsPct(Value: Decimal): Text
    var
        Args: Record "ForNAV Trial Balance Args.";
    begin
        if Value = 0 then
          exit('');

        exit(FormatAsNumber(Args, Value) + '%');
    end;

    procedure GetCaptionClass(FieldNo: Integer): Text
    begin
        case FieldNo of
          1:
            exit('3,' + "Caption 1");
          2:
            exit('3,' + "Caption 2");
          3:
            exit('3,' + "Caption 3");
          4:
            exit('3,' + "Caption 4");
          5:
            exit('3,' + "Caption 5");
          6:
            exit('3,' + "Caption 6");
          7:
            exit('3,' + "Caption 7");
          8:
            exit('3,' + "Caption 8");
        end;
    end;
}

