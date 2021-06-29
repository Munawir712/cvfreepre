import 'dart:io';

import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf_generate_example/model/cv_person.dart';

class PdfApi{

	// function for generate pdf file
	static Future<Uint8List> generate({CvPerson data,PdfPageFormat format,}) async {
		final isNotNull = data != null; 
		final pdf = Document();
		final img = ( await rootBundle.load('assets/l.jpg')).buffer.asUint8List();
		// final imgFile = MemoryImage(data.imageFile.readAsBytesSync());

		final pageTheme = PageTheme(
			pageFormat: PdfPageFormat.a4.applyMargin(
				left: 2.0 * PdfPageFormat.cm, 
				top: 2.0 * PdfPageFormat.cm, 
				right: 2.0 * PdfPageFormat.cm, 
				bottom: 2.0 * PdfPageFormat.cm),
		);

		

		pdf.addPage(MultiPage(
			// pageTheme: pageTheme,
			pageFormat: format,
			build: (context) => [
				Partitions(
					children: [
						Partition(
							width: 150.0,
							child: Container(
								// color: PdfColors.grey900,
								// height: format != format.landscape ? pageTheme.pageFormat.availableHeight - 1 : null,
								// padding: EdgeInsets.only(bottom: 10),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Container(
											color: PdfColors.grey100,
											width: pageTheme.pageFormat.availableWidth,
											height: 150,
											child: Image( MemoryImage(isNotNull && data.imageFile != null ? data.imageFile.readAsBytesSync() : img) , fit: BoxFit.cover),
										),
										// imageFile != null ? imgFile :
										Container(
											width: pageTheme.pageFormat.availableWidth,
											padding: EdgeInsets.only(top: 20, left: 12, right: 12, bottom: 10),
											// color: PdfColors.grey900,
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														"ABOUT ME",
														style: Theme.of(context).header2.copyWith( fontWeight: FontWeight.bold)
													),
													SizedBox(height: 10),
													isNotNull && data.about != null ? Text(data.about) : Lorem(length: 20, style: TextStyle(color: PdfColors.grey900)),
													// SizedBox(height: 20),
												]
											),
										),
										// Spacer(),
										Padding(
											padding: EdgeInsets.only(left: 12, right: 12, top: 10, bottom: 10),
											child: Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: [
													Text(
														"SKILLS",
														style: Theme.of(context).header2.copyWith( fontWeight: FontWeight.bold)
													),
													SizedBox(height: 10),
													// SKILLS
													Row(
														mainAxisAlignment: MainAxisAlignment.spaceBetween,
														crossAxisAlignment: CrossAxisAlignment.center,
														children: [
															Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text("Flutter:",),
																	Text("Laravel:",),
																	Text("PHP:",),
																	Text("Rest API:",),

																]
															),
															Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Container(
																		margin: EdgeInsets.only(bottom: 11),
																		width: 50,
																		height: 3, 
																		decoration: BoxDecoration(color: PdfColors.grey700, borderRadius: BorderRadius.circular(2))
																	),
																	Container(
																		margin: EdgeInsets.only(bottom: 11),
																		width: 30,
																		height: 3, 
																		decoration: BoxDecoration(color: PdfColors.grey700, borderRadius: BorderRadius.circular(2))
																	),
																	Container(
																		margin: EdgeInsets.only(bottom: 11),
																		width: 60,
																		height: 3, 
																		decoration: BoxDecoration(color: PdfColors.grey700, borderRadius: BorderRadius.circular(2))
																	),
																	Container(
																		// margin: EdgeInsets.only(bottom: 10),
																		width: 40,
																		height: 3, 
																		decoration: BoxDecoration(color: PdfColors.grey700, borderRadius: BorderRadius.circular(2))
																	),
																],
															),
														],
													),
												],
											),
										),
										
										
									]
								),
							)
						),
						Partition(
							child: Container(
								color: PdfColors.grey100,
								height: format == format.landscape ?  null : pageTheme.pageFormat.availableHeight - 1,
								child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									// Data person
									Container(
										padding: EdgeInsets.only(top: 20, left: 16, right: 16),
										width: pageTheme.pageFormat.availableWidth,
										child: Column(
											children: [
												Stack(
													alignment: Alignment.center,
													children: [
														Container(
															margin: EdgeInsets.only(top: 30),
																width: pageTheme.pageFormat.availableWidth,
																height: 15,
																color: PdfColors.yellow500
															),
														Text(
															isNotNull && data.name != null ? data.name : "NAME".toUpperCase(),
															textAlign: TextAlign.center,
															style: Theme.of(context).defaultTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
														),
													],
												),
												SizedBox(height: 20),
												Text(data.address ?? "address person", style: TextStyle(color: PdfColors.grey400)),
												Text("phone: (+62) ${isNotNull && data.phoneNumber != null ? data.phoneNumber : 087766554433}", style: TextStyle(color: PdfColors.grey400)),
												Text(isNotNull && data.email != null ? data.email : "email: contact@yourdomain.com", style: TextStyle(color: PdfColors.grey400)),
											]
										),
									),
									SizedBox(height: 30),
									// Experience Person
									Container(
										padding: EdgeInsets.only(left: 16, right: 16),
										width: pageTheme.pageFormat.availableWidth,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													"EXPERIENCE",
													style: Theme.of(context).header2.copyWith(color: PdfColors.grey800, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 10),
												Text(
													"PROGRAMMER PT SIBUYA(2015 - NOW)",
													style: Theme.of(context).header5.copyWith(color: PdfColors.grey500, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 5),
												Lorem(length: 30, style: TextStyle(color: PdfColors.grey400)),
												SizedBox(height: 10),
												Text(
													"FREELANCER (2010 - 2014)",
													style: Theme.of(context).header5.copyWith(color: PdfColors.grey500, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 5),
												Lorem(length: 30, style: TextStyle(color: PdfColors.grey400)),
												SizedBox(height: 10),
												Text(
													"SALESPERSON (2005 - 2008)",
													style: Theme.of(context).header5.copyWith(color: PdfColors.grey500, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 5),
												Lorem(length: 30, style: TextStyle(color: PdfColors.grey400)),
												SizedBox(height: 10),
											]
										),
									),
									// Education Person
									Container(
										padding: EdgeInsets.only(left: 16, right: 16),
										width: pageTheme.pageFormat.availableWidth,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											children: [
												Text(
													"EDUCATION",
													style: Theme.of(context).header2.copyWith(color: PdfColors.grey800, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 10),
												Text(
													"HIGH SCHOOL SIBUYA(1996 - 1999)",
													style: Theme.of(context).header5.copyWith(color: PdfColors.grey500, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 5),
												Lorem(length: 20, style: TextStyle(color: PdfColors.grey400)),
												SizedBox(height: 10),
												Text(
													"SCHOOL 2 (2004 - 2006)",
													style: Theme.of(context).header5.copyWith(color: PdfColors.grey500, fontWeight: FontWeight.bold)
												),
												SizedBox(height: 5),
												Lorem(length: 10, style: TextStyle(color: PdfColors.grey400)),
												SizedBox(height: 10),
												
											]
										),
									),
								]
							),
							),
						),
					]
				),
			]
		));

		return pdf.save();
		// return saveDocument(name: "my_example.pdf", pdf: pdf);
	}

	


	static Container buildImage(Uint8List img,{double height, double width}) {
	  return Container(
					height: height,
					width: width,
					decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(10),
						color: PdfColors.yellow300,
						shape: BoxShape.circle,
						image: DecorationImage(
							image: MemoryImage(img),
							fit: BoxFit.cover
						)
					),
					
				);
	}

	static Widget buildText(String text) => Column(
		children: [
			Text(text, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
			// SizedBox(height: 0.8 * PdfPageFormat.cm)
		]
	);




	// function for open file
	static Future openFile(File file) async {
		final url = file.path;

		await OpenFile.open(url);
	}



	// function for save pdf
	static Future<File> saveDocument({
		String name,
		Document pdf,
	}) async {
		final bytes = await pdf.save();

		final dir = await getApplicationDocumentsDirectory();
		final file = File('${dir.path}/$name');

		await file.writeAsBytes(bytes);

		return file;
	}

}