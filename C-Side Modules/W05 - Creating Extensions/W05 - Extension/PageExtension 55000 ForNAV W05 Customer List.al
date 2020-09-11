pageextension 55000 "ForNAV W05 Customer List" extends "Customer List"
{
    // Copyright (c) 2019 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    actions
    {
        addlast(Reporting)
        {
            action("ForNAV Customer Top 10 Open Orders")
            {
                Caption = 'ForNAV Customer top 10 with open orders';
                ApplicationArea = all;
                RunObject = report "ForNAV Cust Top 10 Open Orders";
            }
        }
    }
}