Table 70248 "ForNAV Cust./Item Stat. Args."
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"Print Details";Boolean)
        {
            Caption = 'Print Details';
            DataClassification = SystemMetadata;
        }
        field(2;"New Page Per Customer";Boolean)
        {
            Caption = 'New Page per Customer';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"Print Details")
        {
        }
    }

    fieldgroups
    {
    }
}

