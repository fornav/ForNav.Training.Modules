Table 88050 "100 Top Customer Overview"
{
    // version TRN1.0.0


    fields
    {
        field(1;"Entry No";Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2;"No.";Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(3;Name;Text[50])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(4;"Sales (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(5;"Profit (LCY)";Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)';
            Editable = false;
            FieldClass = Normal;
        }
        field(6;"Country/Region Code";Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(7;City;Text[30])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
            TableRelation = if ("Country/Region Code"=const('')) "Post Code".City
                            else if ("Country/Region Code"=filter(<>'')) "Post Code".City where ("Country/Region Code"=field("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(1));
        }
        field(9;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code where ("Global Dimension No."=const(2));
        }
        field(10;"Salesperson Code";Code[20])
        {
            Caption = 'Salesperson Code';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(11;"Salesperson Name";Text[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = ToBeClassified;
        }
        field(12;"Country Region Name";Text[50])
        {
            Caption = 'Country Region Name';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

