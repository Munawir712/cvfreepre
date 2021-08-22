import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generate_example/cubit/education_data_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/shared/shared.dart';
import 'package:pdf_generate_example/widget/list_item_widget.dart';
import 'package:pdf_generate_example/widget/section_widget.dart';
import 'package:pdf_generate_example/widget/text_filed_widget.dart';

class EducationFormSection extends StatefulWidget {
	@override
	_EducationFormSectionState createState() => _EducationFormSectionState();
}

class _EducationFormSectionState extends State<EducationFormSection> {
	final listKey = GlobalKey<AnimatedListState>();
	TextEditingController eduSchoolController = TextEditingController();
	TextEditingController eduDescController = TextEditingController();
	List<Education> educations = [];
	bool isShow = true;
	String selectedMonth;
	String selectedYear;
	String selectedMonthEnd;
	String selectedYearEnd;
	
	void addEducation() {
		final education = Education(
			school: eduSchoolController.text,
			description: eduDescController.text,
			dateStart: [selectedMonth, selectedYear],
			dateEnd: [selectedMonthEnd, selectedYearEnd],
		);
		// educations.add(education);
		isShow = true;
		final index = educations.length;
		context.read<EducationDataCubit>().addEducation(education);
		listKey.currentState.insertItem(index);
		setState(() {});
	}

	void editEducation(Education e) {
		context.read<EducationDataCubit>().updateEducation(
			e,
			eduSchoolController.text,
			eduDescController.text,
			[selectedMonth, selectedYear],
			[selectedMonthEnd, selectedYearEnd]
		);
		educations.forEach((element) {element.isEdit = false;});
		setState(() {});
	}

	void deletedEducation(Education education) {
		final index = educations.indexOf(education);
		educations.remove(education);
		listKey.currentState.removeItem(index, (context, animation) => buildListItemPendidikan(education, animation));
	}

	@override
  void initState() {
    super.initState();
		selectedMonth = months[0];
		selectedMonthEnd = months[0];
		selectedYear = DateTime.now().year.toString();
		selectedYearEnd = DateTime.now().year.toString();
		educations = context.read<EducationDataCubit>().getEducations();
		educations.forEach((element) {element.isEdit = false;});
  }


	@override
	Widget build(BuildContext context) {
		return SectionWidget(
			title: "Pendidikan dan Kualifikasi",
			child: Column(
				children: [
					AnimatedList(
						key: listKey,
						shrinkWrap: true,
						physics: NeverScrollableScrollPhysics(),
						initialItemCount: educations.length,
						itemBuilder: (context, index, animation) {
							final education = educations[index];
							return AnimatedContainer(
								height: education.isEdit ? 390 : 60,
								duration: Duration(milliseconds: 500),
								child: Wrap(
									children: [
										education.isEdit == false 
										? buildListItemPendidikan(education, animation)
										: buildFormEducation(
												onSaved: () => editEducation(education),
												onDeleted: () => deletedEducation(education) 
											),
									],
								),
							);
						},
					),
					AnimatedContainer(
						duration: Duration(milliseconds: 500),
						height: isShow == false ? 390 : 50,
						child: Wrap(
							children: [
								isShow == false
								? buildFormEducation(
										onSaved: () => addEducation(),
										onDeleted: () => setState(() => isShow = !isShow)
									) 
								: Container(
										alignment: Alignment.center,
										child: OutlinedButton.icon(
											onPressed: (){
												clearForm();
												isShow = false;
												setState(() {});
											}, 
											icon: Icon(Icons.add), 
											label: Text('Tambah pendidikan') 
										),
									),
							],
						),
					)
				],
			),
		);
	}

	Widget buildListItemPendidikan(Education eduData, Animation animation) {
		String date = "${eduData.dateStart[0]} ${eduData.dateStart[1]} - ${eduData.dateEnd[0]} ${eduData.dateEnd[1]}";
		return SizeTransition(
			sizeFactor: animation,
		  child: Container(
		  	decoration: BoxDecoration(
		  		border: Border(
		  			bottom: BorderSide(color: educations.indexOf(eduData) == educations.length - 1 ? Colors.transparent : Colors.black12)
		  		),
		  	),
		  	child: ListItemWidget(
		  		title: eduData.school,
		  		subtitle: date,
		  		onEdit: () {
		  			educations.forEach((element) {element.isEdit = false;});
		  			eduData.isEdit = !eduData.isEdit;
						
						eduSchoolController.text = eduData.school;
						eduDescController.text = eduData.description;
		  			selectedMonth = eduData.dateStart[0];
		  			selectedMonthEnd = eduData.dateEnd[0];
		  			selectedYear = eduData.dateStart[1];
		  			selectedYearEnd = eduData.dateEnd[1];
		  			isShow = true;
		  			setState(() {});
		  		},
		  		onDeleted: () {
		  			deletedEducation(eduData);
		  		}, 
		  	),
		  ),
		);
	}
	
	void clearForm() {
		educations.forEach((element) {element.isEdit = false;});
		eduSchoolController.clear();
		eduDescController.clear();
		selectedMonth = months[0];
		selectedMonthEnd = months[0];
		selectedYear = DateTime.now().year.toString();
		selectedYearEnd = DateTime.now().year.toString(); 
		setState(() {});
	}

	

	Widget buildFormEducation({@required Function onSaved, Function onDeleted,}) => Column(
		children: [
			TextFieldWidget(
				controller: eduSchoolController,
				label: "Sekolah",
				hintText: "mis: Sarjana Komputer",
			),
			buildSelectDate(lable: "Tanggal Mulai", selectedMonth: this.selectedMonth, selectedYear: this.selectedYear),
			SizedBox(height: 10,),
			buildSelectDateEnd(lable: "Tanggal Selesai"),
			SizedBox(height: 10,),
			TextFieldWidget(
				controller: eduDescController,
				label: "Descripsi",
				hintText: "...",
			),
			Align(
				alignment: Alignment.centerRight,
				child: Row(
					mainAxisAlignment: MainAxisAlignment.end,
					children: [
						onDeleted != null ? ElevatedButton.icon(
							onPressed: onDeleted ?? (){},
							style: ElevatedButton.styleFrom(primary: Colors.red), 
							icon: Icon(Icons.delete), 
							label: Text('Hapus') 
						) : SizedBox(),
						SizedBox(width: 5,),
						ElevatedButton.icon(
							onPressed: onSaved ?? (){}, 
							icon: Icon(Icons.save), 
							label: Text('Simpan') 
						),
					],
				),
			),
		],
	);

	Widget buildSelectDate({@required String lable, @required String selectedMonth, @required String selectedYear}) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			crossAxisAlignment: CrossAxisAlignment.end,
			children: [
				Expanded(
					flex: 1,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(lable, style: TextStyle(color: Colors.black87),),
							SizedBox(height: 5),
							Container(
								padding: EdgeInsets.symmetric(horizontal: 10),
								decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(8),
								border: Border.all(color: Colors.black26)),
								child: DropdownButton(
									value: selectedMonth,
									isExpanded: true,
									underline: SizedBox(),
									items: months.map((e) => DropdownMenuItem(
											value: e,
											child: Text(e, style: TextStyle(fontSize: 12),)
										),
									).toList(),
									onChanged: (item) => setState((){this.selectedMonth = item;}),
								),
							),
						],
					)
				),
				SizedBox(width: 10,),
				Expanded(
					flex: 1,
					child: Container(
						padding: EdgeInsets.symmetric(horizontal: 10),
						decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(8),
						border: Border.all(color: Colors.black26)),
						child: DropdownButton(
							value: selectedYear,
							isExpanded: true,
									underline: SizedBox(),
							items: years.map((e) => DropdownMenuItem(
									value: e,
									child: Text(e, style: TextStyle(fontSize: 12),)
								),
							).toList(),
							onChanged: (item) => setState((){this.selectedYear = item;}),
						),
					)
				),
				
			],
		);
	}

	Widget buildSelectDateEnd({@required String lable, }) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			crossAxisAlignment: CrossAxisAlignment.end,
			children: [
				Expanded(
					flex: 1,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(lable, style: TextStyle(color: Colors.black87),),
							SizedBox(height: 5),
							buildDropdownButton(
								value: selectedMonthEnd,
								items: months.map((e) => DropdownMenuItem(
											value: e,
											child: Text(e, style: TextStyle(fontSize: 12))
										),
									).toList(),
								onChanged: (item) => setState((){this.selectedMonthEnd = item;}),
							),
						],
					)
				),
				SizedBox(width: 10,),
				Expanded(
					flex: 1,
					child: buildDropdownButton(
						value: selectedYearEnd,
						items: years.map((e) => DropdownMenuItem(
									value: e,
									child: Text(e, style: TextStyle(fontSize: 12),)
								),
							).toList(),
							onChanged: (item) => setState((){this.selectedYearEnd = item;}),
					),
				),
				
			],
		);
	}

	Widget buildDropdownButton({value, List<DropdownMenuItem> items, Function(dynamic) onChanged}) => Container(
		padding: EdgeInsets.symmetric(horizontal: 10),
		decoration: BoxDecoration(
		borderRadius: BorderRadius.circular(8),
		border: Border.all(color: Colors.black26)),
		child: DropdownButton(
			value: value,
			isExpanded: true,
			underline: SizedBox(),
			items: items,
			onChanged: onChanged ?? (item){},
		),
	);

}