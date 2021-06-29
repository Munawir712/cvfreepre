import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf_generate_example/api/pdf_api.dart';
import 'package:pdf_generate_example/cubit/datacv_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatefulWidget {
	@override
	_PdfPreviewPageState createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {

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
			appBar: AppBar(title: Text("Pdf Preview")),
			body: BlocBuilder<DatacvCubit, DatacvState>(
				builder: (context, state) {
					if(state is DatacvGetData){
						return PdfPreview(
							build: (format) => PdfApi.generate(format: format, data: state.cvPerson),
							allowSharing: false,
							actions: [
								PdfPreviewAction(
									icon: Icon(Icons.save), 
									onPressed: _saveAsFile
								)
							],
						);
					} else {
						print("NO DATA GAN");
						return PdfPreview(
							build: (format) => PdfApi.generate(format: format,),
							allowSharing: false,
							actions: [
								PdfPreviewAction(
									icon: Icon(Icons.save), 
									onPressed: _saveAsFile
								)
							],
						);
					}
				},
			)
		);
	}
}