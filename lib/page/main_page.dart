import 'package:flutter/material.dart';
import 'package:pdf_generate_example/page/pdf_page.dart';
import 'package:pdf_generate_example/page/pdf_preview_page.dart';

class MainPage extends StatefulWidget {
	final int initialPage;

  MainPage({Key key, this.initialPage = 0});
	@override
	_MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
	int initialIndex = 0;

	@override
  void initState() {
    super.initState();
		initialIndex = widget.initialPage;
  }
	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 2,
			initialIndex: initialIndex,
		  child: Scaffold(
		  	appBar: AppBar(
		  		title: Text("Pdf Generate CV"),
		  		bottom: TabBar(
		  			tabs: [
							Tab(
								text: "Form Pdf",
							),
							Tab(
								text: "Pdf Preview",
							),
						],
		  		),
		  	),
				body: TabBarView(
					children: [
						PdfPage(),
						PdfPreviewPage(),
					],
				),
		  ),
		);
	}
}