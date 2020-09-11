Table 70239 "ForNAV Inv. to G/L Arguments"
{
    // version FORNAV3.2.0.1579/RP2.0.0

    // Copyright (c) 2017 ForNAV ApS - All Rights Reserved
    // The intellectual work and technical concepts contained in this file are proprietary to ForNAV.
    // Unauthorized reverse engineering, distribution or copying of this file, parts hereof, or derived work, via any medium is strictly prohibited without written permission from ForNAV ApS.
    // This source code is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.


    fields
    {
        field(1;"To Date";Date)
        {
            Caption = 'To Date';
            DataClassification = SystemMetadata;
        }
        field(2;"Location Code";Boolean)
        {
            Caption = 'Location Code';
            DataClassification = SystemMetadata;
        }
        field(3;"Variant Code";Boolean)
        {
            Caption = 'Variant Code';
            DataClassification = SystemMetadata;
        }
        field(4;"Amounts in Add. Currency";Boolean)
        {
            Caption = 'Amounts in Add. Currency';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1;"To Date")
        {
        }
    }

    fieldgroups
    {
    }

    procedure CreateBuffer(var Item: Record Item;var InvToGLBuffer: Record "ForNAV Inventory to G/L Buffer")
    var
        InvToGLRecon: Query "ForNAV Inventory to G/L Recon.";
    begin
        InvToGLBuffer.Reset;
        InvToGLBuffer.DeleteAll;

        InvToGLRecon.SetRange(No, Item."No.");
        InvToGLRecon.SetRange(Date_Filter, 0D, "To Date");
        InvToGLRecon.SetFilter(Valued_Quantity, '<0');
        InvToGLRecon.Open;
        with InvToGLBuffer do
          while InvToGLRecon.Read do begin
            CreateRowSetDescription(InvToGLBuffer, InvToGLRecon);
            "Cost Amount (Expected)" := InvToGLRecon.Sum_Cost_Amount_Expected;
            "Cost Amount (Expected) (ACY)" := InvToGLRecon.Sum_Cost_Amount_Expected_ACY;
            "Expected Cost Posted to G/L" := InvToGLRecon.Sum_Expected_Cost_Posted_to_GL;
            "Exp. Cost Posted to G/L (ACY)" := InvToGLRecon.Sum_Exp_Cost_Posted_to_GL_ACY;
            "Valued Quantity" := InvToGLRecon.Sum_Valued_Quantity;
            "Invoiced Quantity" := InvToGLRecon.Sum_Invoiced_Quantity;
            "Cost Amount (Actual)" := InvToGLRecon.Sum_Cost_Amount_Actual;
            "Cost Amount (Actual) (ACY)" := InvToGLRecon.Sum_Cost_Amount_Actual_ACY;
            "Cost Posted to G/L" := InvToGLRecon.Sum_Cost_Posted_to_G_L;
            "Cost Posted to G/L (ACY)" := InvToGLRecon.Sum_Cost_Posted_to_G_L_ACY;
            CreateValues(Rec, true, false);
            Modify;
          end;

        InvToGLRecon.SetRange(No, Item."No.");
        InvToGLRecon.SetRange(Date_Filter, 0D, "To Date");
        InvToGLRecon.SetFilter(Valued_Quantity, '>0');
        InvToGLRecon.Open;
        with InvToGLBuffer do
          while InvToGLRecon.Read do begin
            CreateRowSetDescription(InvToGLBuffer, InvToGLRecon);
            "Cost Amount (Expected)" := InvToGLRecon.Sum_Cost_Amount_Expected;
            "Cost Amount (Expected) (ACY)" := InvToGLRecon.Sum_Cost_Amount_Expected_ACY;
            "Expected Cost Posted to G/L" := InvToGLRecon.Sum_Expected_Cost_Posted_to_GL;
            "Exp. Cost Posted to G/L (ACY)" := InvToGLRecon.Sum_Exp_Cost_Posted_to_GL_ACY;
            "Valued Quantity" := InvToGLRecon.Sum_Valued_Quantity;
            "Invoiced Quantity" := InvToGLRecon.Sum_Invoiced_Quantity;
            "Cost Amount (Actual)" += InvToGLRecon.Sum_Cost_Amount_Actual;
            "Cost Amount (Actual) (ACY)" += InvToGLRecon.Sum_Cost_Amount_Actual_ACY;
            "Cost Posted to G/L" += InvToGLRecon.Sum_Cost_Posted_to_G_L;
            "Cost Posted to G/L (ACY)" += InvToGLRecon.Sum_Cost_Posted_to_G_L_ACY;
            CreateValues(Rec, false, true);
            Modify;
          end;
    end;

    local procedure CreateRowSetDescription(var InvToGLBuffer: Record "ForNAV Inventory to G/L Buffer";var InvToGLRecon: Query "ForNAV Inventory to G/L Recon.")
    begin
        if not InvToGLBuffer.Get(InvToGLRecon.No, InvToGLRecon.Variant_Code, InvToGLRecon.Location_Code) then begin
          InvToGLBuffer.Init;
          InvToGLBuffer."Item No." := InvToGLRecon.No;
          InvToGLBuffer."Variant Code" := InvToGLRecon.Variant_Code;
          InvToGLBuffer."Location Code" := InvToGLRecon.Location_Code;
          InvToGLBuffer.Insert;
        end;
    end;
}

