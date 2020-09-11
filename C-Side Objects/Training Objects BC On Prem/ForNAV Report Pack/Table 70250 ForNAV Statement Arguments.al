Table 70250 "ForNAV Statement Arguments"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Start Date";Date)
        {
            Caption = 'Starting Date';
            DataClassification = SystemMetadata;
        }
        field(2;"Ending Date";Date)
        {
            Caption = 'Ending Date';
            DataClassification = SystemMetadata;
        }
        field(3;"Document Date";Date)
        {
            Caption = 'Document Date';
            DataClassification = SystemMetadata;
        }
        field(4;"Print All Having Balance";Boolean)
        {
            Caption = 'Include All Customers with a Balance';
            DataClassification = SystemMetadata;
        }
        field(5;"Print All Having Entries";Boolean)
        {
            Caption = 'Include All Customers with Ledger Entries';
            DataClassification = SystemMetadata;
        }
        field(6;"Show Overdue Entries";Boolean)
        {
            Caption = 'Show Overdue Entries';
            DataClassification = SystemMetadata;
        }
        field(9;"Include Aging Band";Boolean)
        {
            Caption = 'Include Aging Band';
            DataClassification = SystemMetadata;
        }
        field(10;Date;Option)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
            OptionCaption = 'Due Date,Posting Date';
            OptionMembers = "Due Date","Posting Date";
        }
        field(11;"Period Length";DateFormula)
        {
            Caption = 'Period Length';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Start Date")
        {
        }
    }

    fieldgroups
    {
    }
}

