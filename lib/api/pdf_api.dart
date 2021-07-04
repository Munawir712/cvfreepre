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
			pageFormat: PdfPageFormat(
				PageTheme().pageFormat.width,
				PageTheme().pageFormat.height,
				marginAll: 0 * PdfPageFormat.mm,
			),
			buildBackground: (Context context) {
				return FullPage(
					ignoreMargins: true,
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Container(
									width: PageTheme().pageFormat.width / 3.9 -2,
									height: PageTheme().pageFormat.height,
							),
							Container(
									width: PageTheme().pageFormat.width / 1,
									height: PageTheme().pageFormat.height,
									color: PdfColors.grey100,
							),
						],
					)
				);
			}
		);

		

		pdf.addPage(MultiPage(
			pageTheme: pageTheme,
			// pageFormat: format,
			build: (context) => [
				Partitions(
					children: [
						// Side Information
						Partition(
							width: 150.0,
							child: Container(
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Container(
											color: PdfColors.grey100,
											width: pageTheme.pageFormat.availableWidth,
											height: 150,
											child: Image( MemoryImage(isNotNull && data.imageFile != null ? data.imageFile.readAsBytesSync() : img) , fit: BoxFit.cover),
										),
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
									if(data.experiences.isNotEmpty)
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
													buildListExperiece(data),
												]
											),
										),
									// Education Person
									if(data.educations.isNotEmpty)
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
													buildListEducation(data),
													
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

	static Widget buildListExperiece(CvPerson data) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: data.experiences.map((e) => Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						e.title.toUpperCase() + " (${e.dateStart[0]} ${e.dateStart[1]} - ${e.dateEnd[0]} ${e.dateEnd[1]})",
						style: TextStyle(color: PdfColors.grey500, fontWeight: FontWeight.bold)
					),
					SizedBox(height: 5),
					Text(e.description, style: TextStyle(color: PdfColors.grey400)),
					SizedBox(height: 10),
				],
			),).toList(),
		);
	}

	static Widget buildListEducation(CvPerson data) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: data.educations.map((e) => Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(
						e.school.toUpperCase() + " (${e.dateStart[0]} ${e.dateStart[1]} - ${e.dateEnd[0]} ${e.dateEnd[1]})",
						style: TextStyle(color: PdfColors.grey500, fontWeight: FontWeight.bold)
					),
					SizedBox(height: 5),
					Text(e.description, style: TextStyle(color: PdfColors.grey400)),
					SizedBox(height: 10),
				],
			),).toList(),
		);
	}

	


	


	// Future<PageTheme> myPageTheme(PdfPageFormat format) async {
	// 	format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);

	// 	return PageTheme(
	// 		pageFormat: format,
	// 	);
	// }





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