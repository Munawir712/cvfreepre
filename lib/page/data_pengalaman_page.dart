import 'package:flutter/material.dart';
import 'package:pdf_generate_example/cubit/education_data_cubit.dart';
import 'package:pdf_generate_example/cubit/experiece_data_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/template_page.dart';
import 'package:pdf_generate_example/shared/theme.dart';
import 'package:pdf_generate_example/widget/education_form_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generate_example/widget/experience_form_section.dart';
import 'package:pdf_generate_example/widget/skill_form_section.dart';
import 'package:pdf_generate_example/widget/time_line_widget.dart';

class DataPengalamanPage extends StatefulWidget {
	final CvPerson data;

  const DataPengalamanPage({Key key, @required this.data}) : super(key: key);

	@override
	_DataPengalamanPageState createState() => _DataPengalamanPageState();
}
class _DataPengalamanPageState extends State<DataPengalamanPage> with SingleTickerProviderStateMixin {
	final skillFormKey = GlobalKey<SkillFormSectionState>();

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("CvPree", style: textStyle,),
				centerTitle: true,
				elevation: 0,
				backgroundColor: Colors.blueAccent,
				actions: [
					IconButton(
						icon: Icon(Icons.arrow_forward),
						color: Colors.white,
						onPressed: () => Navigator.push(context, MaterialPageRoute(
							builder: (context) {
								final experiences = (context.read<ExperieceDataCubit>().state as GetExperieceData).experieces;
								final educations = context.read<EducationDataCubit>().getEducations();
								final skills = context.read<ExperieceDataCubit>().getSkills();
								return TemplatePage(data: widget.data.copyWith(
									experiences: experiences,
									educations: educations,
									skills: skills
								));
							})),
					),
				],
			),
			body: SingleChildScrollView(
			  child: Column(
			    children: [
						// TimeLine
						Container(
							padding: EdgeInsets.only(top: 5),
							width: double.infinity,
							color: Colors.blueAccent,
							child: Column(
								children: [
									Text("Pengalaman ", style: TextStyle( color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
									SizedBox(height: 10,),
									TimeLineWidget(status: "PM",),
								],
							),
						),
						/// Sections
						ExperienceFormSection(),
						EducationFormSection(),
						SkillFormSection(),
						/// Button Next Step
						SizedBox(height: 10,),
						buildButton(),
						SizedBox(height: 40,)
			    ],
			  ),
			)
		);
	}

	Widget buildButton() => Container(
		height: 50,
		width: 200,
	  child: ElevatedButton(
	  	onPressed: (){
	  		final experiences = (context.read<ExperieceDataCubit>().state as GetExperieceData).experieces;
	  		final educations = context.read<EducationDataCubit>().getEducations();
				final skills = context.read<ExperieceDataCubit>().getSkills();
				// final skills = skillFormKey.currentState.skills;
				// print(educations);
	  		Navigator.push(context, MaterialPageRoute(
	  			builder: (context) => 
	  			TemplatePage(
	  				data: widget.data.copyWith(
							experiences: experiences,
	  					educations: educations,
							skills: skills
						)))
	  		);
	  	}, 
	  	style: ElevatedButton.styleFrom(
	  		padding: EdgeInsets.all(12),
	  		primary: Colors.blueAccent,
	  		textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,)
	  	),
	  	child: Text("Next Step >",)
	  ),
	);	
	
	

}

