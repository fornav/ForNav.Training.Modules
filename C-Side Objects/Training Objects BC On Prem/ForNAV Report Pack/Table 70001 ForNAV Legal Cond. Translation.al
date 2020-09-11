Table 70001 "ForNAV Legal Cond. Translation"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Legal Cond. Translation';

    fields
    {
        field(2;"Language Code";Code[10])
        {
            Caption = 'Language Code';
            DataClassification = CustomerContent;
            TableRelation = Language;
        }
        field(80;"Legal Conditions";Text[250])
        {
            Caption = 'Legal Conditions';
            DataClassification = OrganizationIdentifiableInformation;
        }
    }

    keys
    {
        key(Key1;"Language Code")
        {
        }
    }

    fieldgroups
    {
    }
}

