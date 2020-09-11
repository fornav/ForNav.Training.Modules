Page 70006 "ForNAV Fields Webservice"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    Caption = 'FieldsEx';
    Editable = false;
    PageType = List;
    SourceTable = "Field";

    layout
    {
        area(content)
        {
            repeater(RepeaterControl)
            {
                field(TableNo;TableNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'TableNo';
                }
                field("No.";"No.")
                {
                    ApplicationArea = Basic;
                    Caption = 'No.';
                }
                field(TableName;TableName)
                {
                    ApplicationArea = Basic;
                    Caption = 'TableName';
                }
                field(FieldName;FieldName)
                {
                    ApplicationArea = Basic;
                    Caption = 'FieldName';
                }
                field(Type;Type)
                {
                    ApplicationArea = Basic;
                    Caption = 'Type';
                }
                field(Class;Class)
                {
                    ApplicationArea = Basic;
                    Caption = 'Class';
                }
                field(RelationTableNo;RelationTableNo)
                {
                    ApplicationArea = Basic;
                }
                field(RelationFieldNo;RelationFieldNo)
                {
                    ApplicationArea = Basic;
                }
                field(OptionString;OptionString)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

