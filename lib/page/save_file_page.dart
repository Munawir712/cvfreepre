import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_generate_example/api/pdf_api.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:printing/printing.dart';

class SaveFilePage extends StatefulWidget {
	final CvPerson data;

  const SaveFilePage({Key key, this.data}) : super(key: key);
	@override
	_SaveFilePageState createState() => _SaveFilePageState();
}

class _SaveFilePageState extends State<SaveFilePage> {
	
	Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File(appDocPath + '/' + 'MY_CV.pdf');
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
			body: PdfPreview(
				canChangePageFormat: false,
				canChangeOrientation: false,
				build: (format) => PdfApi.generate(data: widget.data, format: format),
				actions: [
					PdfPreviewAction(icon: Icon(Icons.save_alt), onPressed: _saveAsFile)
				],
			),
		);
	}
}