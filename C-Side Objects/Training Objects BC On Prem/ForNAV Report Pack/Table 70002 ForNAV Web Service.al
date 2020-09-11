Table 70002 "ForNAV Web Service"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'Web Service';

    fields
    {
        field(3;"Object Type";Option)
        {
            Caption = 'Object Type';
            DataClassification = SystemMetadata;
            OptionCaption = ',,,,,Codeunit,,,Page,Query';
            OptionMembers = ,,,,,"Codeunit",,,"Page","Query";
        }
        field(6;"Object ID";Integer)
        {
            Caption = 'Object ID';
            DataClassification = SystemMetadata;
            TableRelation = AllObjWithCaption."Object ID" where ("Object Type"=field("Object Type"));
        }
        field(9;"Service Name";Text[240])
        {
            Caption = 'Service Name';
            DataClassification = SystemMetadata;
        }
        field(12;Published;Boolean)
        {
            Caption = 'Published';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Object Type","Service Name")
        {
        }
        key(Key2;"Object Type","Object ID")
        {
        }
    }

    fieldgroups
    {
    }
}

