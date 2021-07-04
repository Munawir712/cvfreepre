import 'package:flutter/material.dart';
import 'package:pdf_generate_example/page/data_pribadi_page.dart';
import 'package:pdf_generate_example/page/main_page.dart';
// import 'package:pdf_generate_example/page/pdf_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pdf generate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DataPribadiPage(),
    );
  }
}

