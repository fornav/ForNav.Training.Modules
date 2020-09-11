Table 70219 "ForNAV Aged Accounts Args."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Print Amounts in LCY";Boolean)
        {
            Caption = 'Print Amounts in LCY';
            DataClassification = SystemMetadata;
        }
        field(2;"Ending Date";Date)
        {
            Caption = 'Ending Date';
            DataClassification = SystemMetadata;
        }
        field(3;"Aging By";Option)
        {
            Caption = 'Aging Band by';
            DataClassification = SystemMetadata;
            OptionCaption = 'Due Date,Posting Date,Document Date';
            OptionMembers = "Due Date","Posting Date","Document Date";
        }
        field(4;"Period Length";DateFormula)
        {
            Caption = 'Period Length';
            DataClassification = SystemMetadata;
        }
        field(5;"Print Details";Boolean)
        {
            Caption = 'Print Details';
            DataClassification = SystemMetadata;
        }
        field(6;"Heading Type";Option)
        {
            Caption = 'Heading Type';
            DataClassification = SystemMetadata;
            OptionMembers = "Date Interval","Number of Days";
        }
        field(7;"New Page Per Customer";Boolean)
        {
            Caption = 'New Page Per Customer';
            DataClassification = SystemMetadata;
        }
        field(9;"Period Start Date";Date)
        {
            Caption = 'Period Start Date';
            DataClassification = SystemMetadata;
        }
        field(12;"Currency Code";Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = SystemMetadata;
        }
        field(13;"Column Count";Integer)
        {
            Caption = 'Column Count';
            DataClassification = SystemMetadata;
            MaxValue = 31;
            MinValue = 1;
        }
    }

    keys
    {
        key(Key1;"Print Amounts in LCY")
        {
        }
    }

    fieldgroups
    {
    }

    var
        PeriodStartDate: array [31] of Date;
        PeriodEndDate: array [31] of Date;
        HeaderText: array [31] of Text;

    procedure CalcDates()
    var
        i: Integer;
        PeriodLength2: DateFormula;
        Text010: label 'The Date Formula %1 cannot be used';
        Text032: label '-%1', Comment='Negating the period length: %1 is the period length';
    begin
        Evaluate(PeriodLength2,StrSubstNo(Text032, "Period Length"));

        if "Aging By" = "aging by"::"Due Date" then begin
          PeriodEndDate[1] := Dmy2date(31,12,9999);
          PeriodStartDate[1] := "Ending Date" + 1;
        end else begin
          PeriodEndDate[1] := "Ending Date";
          PeriodStartDate[1] := CalcDate(PeriodLength2, "Ending Date" + 1);
        end;

        for i := 2 to "Column Count" do begin
          PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
          PeriodStartDate[i] := CalcDate(PeriodLength2,PeriodEndDate[i] + 1);
        end;

        PeriodStartDate[i] := 0D;
        for i := 1 to "Column Count" do
          if PeriodEndDate[i] < PeriodStartDate[i] then
            Error(Text010, "Period Length");

        CreateHeadings;
    end;

    procedure GetPeriodIndex(Date: Date): Integer
    var
        i: Integer;
    begin
        for i := 1 to "Column Count" do
          if Date in [PeriodStartDate[i]..PeriodEndDate[i]] then
            exit(i);
    end;

    procedure GetCaption(i: Integer): Text
    begin
        exit(HeaderText[i]);
    end;

    local procedure CreateHeadings()
    var
        i: Integer;
        NotDueTxt: label 'Not Due';
        BeforeTxt: label 'Before';
        DaysTxt: label 'days';
        MoreThanTxt: label 'More than';
    begin
        if "Aging By" = "aging by"::"Due Date" then begin
          HeaderText[1] := NotDueTxt;
          i := 2;
        end else
          i := 1;

        while i < "Column Count" do begin
          if "Heading Type" = "heading type"::"Date Interval" then
            HeaderText[i] := StrSubstNo('%1\..%2',PeriodStartDate[i],PeriodEndDate[i])
          else
            HeaderText[i] :=
              StrSubstNo('%1 - %2 %3', "Ending Date" - PeriodEndDate[i] + 1, "Ending Date" - PeriodStartDate[i] + 1, DaysTxt);
          i := i + 1;
        end;

        if "Heading Type" = "heading type"::"Date Interval" then
          HeaderText["Column Count"] := StrSubstNo('%1 \%2', BeforeTxt, PeriodStartDate[i - 1])
        else
          HeaderText["Column Count"] := StrSubstNo('%1 \%2 %3', MoreThanTxt, "Ending Date" - PeriodStartDate[i - 1] + 1, DaysTxt);
    end;
}

