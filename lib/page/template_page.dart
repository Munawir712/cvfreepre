import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_generate_example/api/pdf_api.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/save_file_page.dart';
import 'package:pdf_generate_example/widget/time_line_widget.dart';
import 'package:printing/printing.dart';

class TemplatePage extends StatefulWidget {
	final CvPerson data;

  const TemplatePage({Key key, @required this.data}) : super(key: key);

	@override
	_TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
	bool isSelected = false;

	Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + 'document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Cvmaker Gratis"),
			),
			body: SingleChildScrollView(
			  child: Column(
			    children: [
			  		Container(
			  			padding: EdgeInsets.only(top:5),
			  			color: Colors.blueAccent,
			  			width: double.infinity,
			  		  child: Column(
			  		    children: [
			  					Text("Pengalam", style: TextStyle( color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
			  					SizedBox(height: 10,),
			  		      TimeLineWidget(status: "TP"),
			  		    ],
			  		  ),
			  		),
						SizedBox(height: 20,),
			      Column(
			        children: [
			          InkWell(
									splashColor: Colors.black87,
									onTap: (){
										print("Select");
										isSelected = !isSelected;
										setState(() {});
										Navigator.push(context, MaterialPageRoute(builder: (context) => SaveFilePage(data: widget.data,)));
									},
									child: Container(
										height: 280,
										width: 200,
										decoration: BoxDecoration(
											border: Border.all(color: isSelected ? Colors.blueAccent : Colors.black87, width: isSelected ? 3.0 : 1.0)
										),
										child: PdfPreview(
											build: (format) => PdfApi.generate(data: widget.data, format: format),
											allowSharing: false,
											useActions: false,
											actions: [
												PdfPreviewAction(
													icon: Icon(Icons.save_alt), 
													onPressed: _saveAsFile,
												),
											],
										),
									),
			        	),
								// Column(
								// 	children: widget.data.experiences.map((e) => Text(e.title)).toList(),
								// ),
								// Column(
								// 	children: widget.data.educations.map((e) => Text(e.school)).toList(),
								// ),
			        ],
			      ),
			    ],
			  ),
			),
		);
	}
}