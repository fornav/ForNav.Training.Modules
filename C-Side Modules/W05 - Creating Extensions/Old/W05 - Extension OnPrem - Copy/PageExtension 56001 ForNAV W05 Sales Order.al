pageextension 55001 "ForNAV W05 Sales Order" extends "Sales Order"
{
    // Copyright (c) 2019 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    actions
    {
        addlast(Reporting)
        {
            action("ForNAV W05 Sales Order")
            {
                Caption = 'ForNAV W05 Sales Order';
                ApplicationArea = all;

                trigger OnAction()
                begin
                    Rec.SetRecFilter();
                    Report.Run(Report::"ForNAV Sales Order", true, false, Rec);
                end;
            }
        }
    }
}