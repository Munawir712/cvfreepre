import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_generate_example/cubit/education_data_cubit.dart';
import 'package:pdf_generate_example/cubit/experiece_data_cubit.dart';
import 'package:pdf_generate_example/page/data_pribadi_page.dart';
// import 'package:pdf_generate_example/page/pdf_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
			providers: [
				BlocProvider(create:(_) => ExperieceDataCubit()),
				BlocProvider(create:(_) => EducationDataCubit()),
				// BlocProvider(create:(_) => ItemPersoneCubit())
			],
      child: MaterialApp(
          title: 'CvPree',
					debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
						textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
          ),
          home: DataPribadiPage(),
        ),
    );
  }
}

