dotnet // --> Reports ForNAV Autogenerated code - do not delete or modify
{	
	assembly("ForNav.Reports.3.2.0.1579")
	{
		type(ForNav.Report; ForNavReport70221){}   
	}
	assembly("mscorlib")
	{
		Version='4.0.0.0';
		type("System.IO.Stream"; SystemIOStream70221){}   
	}
} // Reports ForNAV Autogenerated code - do not delete or modify -->

Report 70221 "ForNAV Aged Accounts Payables"
{

	Caption = 'Aged Accounts Payables';
	WordLayout = './Layouts/ForNAV Aged Accounts Payables.docx'; DefaultLayout = Word;

	dataset
	{
		DataItem(Args;"ForNAV Aged Accounts Args.")
		{
			DataItemTableView = sorting("Print Amounts in LCY");
			UseTemporary = true;
			column(ReportForNavId_1000000001; 1000000001) {}
			DataItem(Account;Vendor)
			{
				RequestFilterFields = "No.";
				column(ReportForNavId_6836; 6836) {}
				DataItem(AgingBuffer;"ForNAV Aging Buffer")
				{
					DataItemTableView = sorting("Currency Code");
					UseTemporary = true;
					column(ReportForNavId_70220; 70220) {}
				}
				trigger OnAfterGetRecord();
				begin
					AgingCalculation.GetAgingWithCurrency(Account, AgingBuffer, CurrencyTotalsBuffer, Args, TempCurrency);
					if AgingBuffer.IsEmpty then
					  CurrReport.Skip;
				end;
				
			}
			DataItem(CurrencyTotalsBuffer;"ForNAV Aging Buffer")
			{
				DataItemTableView = sorting("Currency Code");
				UseTemporary = true;
				column(ReportForNavId_1000000000; 1000000000) {}
			}
			trigger OnPreDataItem();
			begin
				Args.Insert;
				Args.CalcDates;
			end;
			
		}
	}

	requestpage
	{
		SaveValues = true;

		layout
		{
			area(content)
			{
				group(Options)
				{
					Caption = 'Options';
					field(AgedAsOf;Args."Ending Date")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'Ending Date';
					}
					field(Agingby;Args."Aging By")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'Aging by';
					}
					field(PeriodLength;Args."Period Length")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'Period Length';
					}
					field(AmountsinLCY;Args."Print Amounts in LCY")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'All Amounts in LCY';
					}
					field(PrintDetails;Args."Print Details")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'Print Details';
					}
					field(HeadingType;Args."Heading Type")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'Heading Type';
						Visible = false;
					}
					field(perCustomer;Args."New Page Per Customer")
					{
						ApplicationArea = Basic,Suite;
						Caption = 'New Page per Customer';
					}
					field(ForNavOpenDesigner;ReportForNavOpenDesigner)
					{
						ApplicationArea = Basic;
						Caption = 'Design';
						Visible = ReportForNavAllowDesign;
					}
				}
			}
		}

		actions
		{
		}

		trigger OnOpenPage()
		begin
			InitRequestPage;
		end;
	}
	labels
	{
		AgedOverdueAmounts = 'Aged Overdue Amounts';
		AmnsInLCY = 'All Amounts in LCY.';
	}

	trigger OnInitReport()
	begin
		Codeunit.Run(Codeunit::"ForNAV First Time Setup");
		Commit;
		LoadWatermark;
		;ReportForNav:= ReportForNav.Report(CurrReport.ObjectId, CurrReport.Language, SerialNumber, UserId, COMPANYNAME); ReportForNav.Init;
	end;


	trigger OnPostReport()
	begin
		ReportForNav.Post;
	end;


	trigger OnPreReport()
	var
		CaptionManagement: Codeunit CaptionManagement;
	begin
		;ReportForNav.OpenDesigner:=ReportForNavOpenDesigner;if not ReportForNav.Pre then CurrReport.Quit;
	end;

	var
		TempCurrency: Record Currency temporary;
		AgingCalculation: Codeunit "ForNAV Aging Calculation";

	local procedure LoadWatermark()
	var
		ForNAVSetup: Record "ForNAV Setup";
		OutStream: OutStream;
	begin
		with ForNAVSetup do begin
		  Get;
		  CalcFields("List Report Watermark");
		  if not "List Report Watermark".Hasvalue then
			exit;
		  "List Report Watermark".CreateOutstream(OutStream);
		  ReportForNav.Watermark.Image.Load(OutStream);
		end;
	end;

	local procedure InitRequestPage()
	var
		Blank: DateFormula;
	begin
		with Args do begin
		  if "Ending Date" = 0D then
			"Ending Date" := WorkDate;
		  "Column Count" := 5;
		  if "Period Length" = Blank then
			Evaluate("Period Length", '<1M>');
		end;
	end;
	// --> Reports ForNAV Autogenerated code - do not delete or modify
	var 
		[WithEvents]
		ReportForNav : DotNet ForNavReport70221;
		[RunOnClient]
		ReportForNavClient : DotNet ForNavReport70221;
		ReportForNavDialog : Dialog;
		ReportForNavOpenDesigner : Boolean;
		[InDataSet]
		ReportForNavAllowDesign : Boolean;

	trigger ReportForNav::OnInit();
	begin
		if ReportForNav.IsWindowsClient then begin
			ReportForNav.CheckClientAddIn();
			ReportForNavClient := ReportForNavClient.Report(ReportForNav.Definition);
			ReportForNavAllowDesign := ReportForNavClient.HasDesigner AND NOT ReportForNav.ParameterMode;
		end;
	end;

	trigger ReportForNav::OnSave(Base64Layout : Text);
	var
		CustomReportLayout : Record "Custom Report Layout";
		ReportLayoutSelection : Record "Report Layout Selection";
		LayoutId : Variant;
		TempBlob : Record TempBlob;
		OutStream : OutStream;
		Bstr : BigText;
		EmptyLayout : Text;
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		EmptyLayout := FORMAT(ReportLayoutSelection."Custom Report Layout Code");
		LayoutId := ReportLayoutSelection."Custom Report Layout Code";
		if ReportLayoutSelection.HasCustomLayout(ReportForNav.ReportID) = 1 then begin
			if FORMAT(ReportLayoutSelection.GetTempLayoutSelected) <> EmptyLayout then begin
				LayoutId := ReportLayoutSelection.GetTempLayoutSelected;
			end else begin
			if ReportLayoutSelection.GET(ReportForNav.ReportID, COMPANYNAME) then begin
				LayoutId := ReportLayoutSelection."Custom Report Layout Code";
			end;
		end;
		end else begin
			if CONFIRM('Default custom layout not found. Create one?') then;
		end;
		if FORMAT(LayoutId) <> EmptyLayout then begin
			TempBlob.Blob.CREATEOUTSTREAM(OutStream);
			Bstr.ADDTEXT(Base64Layout);
			Bstr.WRITE(OutStream);
			CustomReportLayout.GET(LayoutId);
			CustomReportLayout.ImportLayoutBlob(TempBlob, 'RDL');
		end;
	end;

	trigger ReportForNav::OnParameters(Parameters : Text);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNav.Parameters := REPORT.RUNREQUESTPAGE(ReportForNav.ReportID, Parameters);
	end;

	trigger ReportForNav::OnPreview(Parameters : Text;FileName : Text);
	var
		PdfFile : File;
		InStream : InStream;
		OutStream : OutStream;
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		COMMIT;
		PdfFile.CREATETEMPFILE;
		PdfFile.CREATEOUTSTREAM(OutStream);
		REPORT.SAVEAS(ReportForNav.ReportID, Parameters, REPORTFORMAT::Pdf, OutStream);
		PdfFile.CREATEINSTREAM(InStream);
		ReportForNavClient.ShowDesigner;
		if ReportForNav.IsValidPdf(PdfFile.NAME) then DOWNLOADFROMSTREAM(InStream, '', '', '', FileName);
		PdfFile.CLOSE;
	end;

	trigger ReportForNav::OnSelectPrinter();
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNav.PrinterSettings.PageSettings := ReportForNavClient.SelectPrinter(ReportForNav.PrinterSettings.PrinterName,ReportForNav.PrinterSettings.ShowPrinterDialog,ReportForNav.PrinterSettings.PageSettings);
	end;

	trigger ReportForNav::OnPrint(InStream : DotNet SystemIOStream70221);
	var
		ClientFileName : Text[255];
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		DOWNLOADFROMSTREAM(InStream, '', '<TEMP>', '', ClientFileName);
		ReportForNavClient.Print(ClientFileName); 
	end;

	trigger ReportForNav::OnDesign(Data : Text);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ReportForNavClient.Data := Data;
		while ReportForNavClient.DesignReport do begin
			ReportForNav.HandleRequest(ReportForNavClient.GetRequest());
			SLEEP(100);
		end;
	end;

	trigger ReportForNav::OnView(ClientFileName : Text;Parameters : Text;ServerFileName : Text);
	var
		ServerFile : File;
		ServerInStream : InStream;
		"Filter" : Text;
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		ServerFile.OPEN(ServerFileName);
		ServerFile.CREATEINSTREAM(ServerInStream);
		if STRLEN(ClientFileName) >= 4 then if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName)-3, 4)) = '.pdf' then Filter := 'PDF (*.pdf)|*.pdf';
		if STRLEN(ClientFileName) >= 4 then if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName)-3, 4)) = '.doc' then Filter := 'Microsoft Word (*.doc)|*.doc';
		if STRLEN(ClientFileName) >= 5 then if LOWERCASE(COPYSTR(ClientFileName, STRLEN(ClientFileName)-4, 5)) = '.xlsx' then Filter := 'Microsoft Excel (*.xlsx)|*.xlsx';
		DOWNLOADFROMSTREAM(ServerInStream,'Export','',Filter,ClientFileName);
	end;

	trigger ReportForNav::OnMessage(Operation : Text;Parameter : Text;ParameterNo : Integer);
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		case Operation of
			'Open'	: ReportForNavDialog.Open(Parameter);
			'Update'  : ReportForNavDialog.Update(ParameterNo,Parameter);
			'Close'   : ReportForNavDialog.Close();
			'Message' : Message(Parameter);
			'Error'   : Error(Parameter);
		end;
	end;

	trigger ReportForNav::OnPrintPreview(InStream : DotNet SystemIOStream70221;Preview : Boolean);
	var
		ClientFileName : Text[255];
	begin
		// This code is created automatically every time Reports ForNAV saves the report.
		// Do not modify this code.
		CurrReport.Language := System.GlobalLanguage;
		DownloadFromStream(InStream, '', '<TEMP>', '', ClientFileName);
		ReportForNavClient.PrintPreviewDialog(ClientFileName,ReportForNav.PrinterSettings.PrinterName,Preview);
	end;

	trigger ReportForNav::OnGetWordLayout(reportNo: Integer)
	var
		layoutStream : InStream;
		zip: Codeunit "Zip Stream Wrapper";
		oStream: OutStream;
		iStream: InStream;
		layout: Text;
		dataContract: Text;
		tempBlob: Record "TempBlob";
		ReportLayoutSelection: Record "Report Layout Selection";
		CustomReportLayout: Record "Custom Report Layout";
		CustomLayoutID: Variant;
		EmptyLayout: Text;
		props: XmlDocument;
		prop: XmlNode;
		layoutNode: XmlNode;
	begin
		EmptyLayout := FORMAT(ReportLayoutSelection."Custom Report Layout Code");
		CustomLayoutID := ReportLayoutSelection."Custom Report Layout Code";
		if Format(ReportLayoutSelection.GetTempLayoutSelected) <> EmptyLayout then
			CustomLayoutID := ReportLayoutSelection.GetTempLayoutSelected
		else
			if ReportLayoutSelection.HasCustomLayout(reportNo) = 2 then
				CustomLayoutID := ReportLayoutSelection."Custom Report Layout Code";

		if (Format(CustomLayoutID) <> EmptyLayout) AND CustomReportLayout.GET(CustomLayoutID) then begin
			CustomReportLayout.TestField(Type, CustomReportLayout.Type::Word);
			CustomReportLayout.CalcFields(Layout);
			CustomReportLayout.Layout.CreateInstream(layoutStream, TEXTENCODING::UTF8);
		end else
			Report.WordLayout(reportNo, layoutStream);
		zip.OpenZipFromStream(layoutStream, false);
		tempBlob.Blob.CreateOutStream(oStream);
		zip.WriteEntryFromZipToOutStream('docProps/custom.xml', oStream);
		tempBlob.Blob.CreateInStream(iStream);
		XmlDocument.ReadFrom(iStream, props);
		props.GetChildNodes().Get(1, prop);
		prop.AsXmlElement().GetChildNodes().Get(1, layoutNode);
		layout := layoutNode.AsXmlElement().InnerText();
		ReportForNav.WordLayout := layout;
	end;
	procedure ReportForNav_GetPageNo() : Integer
	begin
		exit(ReportForNav.PageNo);
	end;

	trigger ReportForNav::OnTotals(DataItemId: Text; Operation: Text; GroupTotalFieldNo: Integer)
	begin
		// Do not change (Autogenerated by Reports ForNAV) - Instead change the Create Totals, Total Fields or Group Total Fields properties on the Data item in the ForNAV designer
		case DataItemId of
			'AgingBuffer':
				with AgingBuffer do case Operation of
					'Add': begin
						ReportForNav.AddTotal(DataItemId,0,Amount);
						ReportForNav.AddTotal(DataItemId,1,"Amount (LCY)");
						ReportForNav.AddTotal(DataItemId,2,Balance);
						ReportForNav.AddTotal(DataItemId,3,"Balance (LCY)");
						ReportForNav.AddTotal(DataItemId,4,"Amount 1");
						ReportForNav.AddTotal(DataItemId,5,"Amount 1 (LCY)");
						ReportForNav.AddTotal(DataItemId,6,"Amount 2");
						ReportForNav.AddTotal(DataItemId,7,"Amount 2 (LCY)");
						ReportForNav.AddTotal(DataItemId,8,"Amount 3");
						ReportForNav.AddTotal(DataItemId,9,"Amount 3 (LCY)");
						ReportForNav.AddTotal(DataItemId,10,"Amount 4");
						ReportForNav.AddTotal(DataItemId,11,"Amount 4 (LCY)");
						ReportForNav.AddTotal(DataItemId,12,"Amount 5");
						ReportForNav.AddTotal(DataItemId,13,"Amount 5 (LCY)");
					end;
					'Restore': begin
						Amount := ReportForNav.RestoreTotal(DataItemId,0,GroupTotalFieldNo);
						"Amount (LCY)" := ReportForNav.RestoreTotal(DataItemId,1,GroupTotalFieldNo);
						Balance := ReportForNav.RestoreTotal(DataItemId,2,GroupTotalFieldNo);
						"Balance (LCY)" := ReportForNav.RestoreTotal(DataItemId,3,GroupTotalFieldNo);
						"Amount 1" := ReportForNav.RestoreTotal(DataItemId,4,GroupTotalFieldNo);
						"Amount 1 (LCY)" := ReportForNav.RestoreTotal(DataItemId,5,GroupTotalFieldNo);
						"Amount 2" := ReportForNav.RestoreTotal(DataItemId,6,GroupTotalFieldNo);
						"Amount 2 (LCY)" := ReportForNav.RestoreTotal(DataItemId,7,GroupTotalFieldNo);
						"Amount 3" := ReportForNav.RestoreTotal(DataItemId,8,GroupTotalFieldNo);
						"Amount 3 (LCY)" := ReportForNav.RestoreTotal(DataItemId,9,GroupTotalFieldNo);
						"Amount 4" := ReportForNav.RestoreTotal(DataItemId,10,GroupTotalFieldNo);
						"Amount 4 (LCY)" := ReportForNav.RestoreTotal(DataItemId,11,GroupTotalFieldNo);
						"Amount 5" := ReportForNav.RestoreTotal(DataItemId,12,GroupTotalFieldNo);
						"Amount 5 (LCY)" := ReportForNav.RestoreTotal(DataItemId,13,GroupTotalFieldNo);
					end;
				end;
			end;
	end;
	// Reports ForNAV Autogenerated code - do not delete or modify -->
}