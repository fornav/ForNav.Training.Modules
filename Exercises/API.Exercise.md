### ForNAV API Exercise

Using the new Sales Invoice report extension you created earlier do:
* Add a text variable on the request page and use it in your report
  * Add a new global Text variable in your report, call it MyText
  * Add a column in the Header DataItem on the MyText variable
  * Add a request page option in the AL file based on the MyText variable
  * Open the report in the ForNAV Designer and add a new text box on the Report Header and add DynamicsNavDataSet.MyText as the source expression
* Add a watermark to the report
  * In the ForNAV setup import the Document Watermark. Either download one from ForNAV or import your own
  * Add the LoadWatermark function and the call to it in the OnPreReport function
* Use the list watermark in the ForNAV Setup and append that to your report
  * Create a pdf file and load it in the ForNAV Setup List Report Watermark (Portrait) field;
  * Add the AppendPdf function and the call to it in the OnInitReport function

Advanced exercise
* Call the CurrReport.Language in AL to set the report language based on the document language.

Use the ForNAV Guide for [SaaS]() or [On Premise]()

> * [Demo PDF to append](https://github.com/renebrummel/ForNAV.TrainingModules/blob/master/Modules/21%20API/Append.pdf)
> * [Demo watermarks](https://www.fornav.com/report-watermarks/)
> * [Demo extension with examples](https://github.com/renebrummel/ForNAV.TrainingModules/tree/master/Modules/21%20API/APIDemo)
<!-- ToDO -> edit links -->

### Load Watermark function
```AL
	trigger OnPreReport()
	begin
		;ReportsForNavPre;
		LoadWatermark();
	end;

	local procedure LoadWatermark()
	var
		ForNAVSetup: Record "ForNAV Setup";
		OutStream: OutStream;
	begin
		with ForNAVSetup do begin
			Get;
			CalcFields("Document Watermark");
			if not "Document Watermark".Hasvalue then
				exit;

			ForNavSetup."Document Watermark".CreateOutstream(OutStream);
			ReportForNav.Watermark.Image.Load(OutStream);
		end;
	end;
```

### AppendPdf function

```AL
    trigger OnInitReport()
    begin
        ;
        ReportsForNavInit;
        AppendPdf();
    end;
	
    local procedure AppendPdf()
    var
        ForNAVSetup: Record "ForNAV Setup";
        InStream: InStream;
    begin
        with ForNAVSetup do begin
            Get;
            CalcFields("List Report Watermark");
            if not "List Report Watermark".Hasvalue then
                exit;

            ForNavSetup."List Report Watermark".CreateInStream(InStream);
            ReportForNav.GetDataItem('Header').AppendPdf(InStream);
        end;
    end;
```
