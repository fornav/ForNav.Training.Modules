Page 70004 "ForNAV Reports"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

    Caption = 'ForNAV Reports';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "ForNAV Reports";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category;Category)
                {
                    ApplicationArea = Basic;
                }
                field(ID;ID)
                {
                    ApplicationArea = Basic;
                }
                field(Name;Name)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Run)
            {
                ApplicationArea = Basic;
                Caption = 'Run';
                Image = ExecuteBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Report.Run(ID);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        GetReports;
    end;

    local procedure GetReports()
    var
        AllObjWithCaption: Record AllObjWithCaption;
    begin
        Codeunit.Run(Codeunit::"ForNAV First Time Setup");

        AllObjWithCaption.SetRange("Object ID", 50000, 99999);
        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."object type"::Report);
        AllObjWithCaption.SetFilter("Object Name", 'ForNAV*');
        if AllObjWithCaption.FindSet then repeat
          ID := AllObjWithCaption."Object ID";
          Name := AllObjWithCaption."Object Caption";
          Category := GetCategory(AllObjWithCaption."Object Name");
          if IsValidForLocalization(AllObjWithCaption."Object Name") then
            Insert;
        until AllObjWithCaption.Next = 0;

        AllObjWithCaption.SetRange("Object ID", 6188471, 6189471);
        if AllObjWithCaption.FindSet then repeat
          ID := AllObjWithCaption."Object ID";
          Name := AllObjWithCaption."Object Caption";
          Category := GetCategory(AllObjWithCaption."Object Name");
          if IsValidForLocalization(AllObjWithCaption."Object Name") then
            Insert;
        until AllObjWithCaption.Next = 0;

        if FindFirst then;
    end;
}

