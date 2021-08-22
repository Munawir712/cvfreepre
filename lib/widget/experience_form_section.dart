import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generate_example/cubit/experiece_data_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/shared/shared.dart';
import 'package:pdf_generate_example/widget/list_item_widget.dart';
import 'package:pdf_generate_example/widget/section_widget.dart';

class ExperienceFormSection extends StatefulWidget {

	@override
	_ExperienceFormSectionState createState() => _ExperienceFormSectionState();
}

class _ExperienceFormSectionState extends State<ExperienceFormSection> with SingleTickerProviderStateMixin {
	final listKey = GlobalKey<AnimatedListState>();
	TextEditingController pekerjaanController = TextEditingController();
	TextEditingController descriptionController = TextEditingController();
	List<Experience> pengalaman = [];
	bool isShow = false;
	String selectedMonth;
	String selectedYear;
	String selectedMonthEnd;
	String selectedYearEnd;
	bool isvisible = true;

	@override
  void initState() {
    super.initState();
		context.read<ExperieceDataCubit>().getExperieces();
		pengalaman = (context.read<ExperieceDataCubit>().state as GetExperieceData).experieces;
		pengalaman.forEach((element) {element.isEdit = false;});
		selectedMonth = months[0];
		selectedMonthEnd = months[0];
		selectedYear = DateTime.now().year.toString();
		selectedYearEnd = DateTime.now().year.toString();
  }

	@override
	Widget build(BuildContext context) {
		return SectionWidget(
			title: "Pengalaman kerja",
			child: Column(
				children: [
					Container(
						child: AnimatedList(
							physics: NeverScrollableScrollPhysics(),
							shrinkWrap: true,
							key: listKey,
							initialItemCount: pengalaman.length,
							itemBuilder: (context, index, animation) {
								final expWork = pengalaman[index];
								
								return AnimatedContainer(
									height: expWork.isEdit ? 390 : 60 ,
									duration: Duration(milliseconds: 500),
									child:  Wrap(
										children: [
											expWork.isEdit == false 
											? buildListItemPengalaman(expWork, animation) 
											: buildFormExperience(
													onSaved: () => editExperience(expWork),
													onDeleted: () => removeExperience(expWork),
												),
										],
									),
								);
							},
						) 
					),
					AnimatedContainer(
						duration: Duration(milliseconds: 500),
						height: isShow == true ? 390 : 50,
						child: Wrap(
							children: [
								isShow == false 
								? buttonAdd() 
								:	buildFormExperience(
										onSaved: () => addExperience(),
										onDeleted: () => setState(() => isShow = !isShow)
								)
							],
						),
					),
				],
			),
		);
	}
	// fungsi tambah experience ke cubit
	void addExperience(){
		final experience = Experience(
			title: pekerjaanController.text,
			description: descriptionController.text,
			dateStart: [selectedMonth, selectedYear],
			dateEnd: [selectedMonthEnd, selectedYearEnd]
		);
		// pengalaman.add(experience);
		isShow = false;
		final index = pengalaman.length;
		context.read<ExperieceDataCubit>().addExperiece(experience);
		listKey.currentState.insertItem(index);
		setState(() {});
	}
	// fungsi edit experience ke cubit
	void editExperience(Experience experience) {
		pengalaman.forEach((element) {element.isEdit = false;});
		isShow = false;
		final dateStart = [selectedMonth, selectedYear];
		final dateEnd = [selectedMonthEnd, selectedYearEnd];

		context.read<ExperieceDataCubit>().updateExperience(
			experience, 
			pekerjaanController.text, 
			descriptionController.text, 
			dateStart, 
			dateEnd
		);
		setState(() {});
	}

	void removeExperience(Experience experience) {
		final index = pengalaman.indexOf(experience);
		context.read<ExperieceDataCubit>().removeExperience(experience);
		listKey.currentState.removeItem(index, (context, animation) => buildListItemPengalaman(experience, animation));
		// setState(() {});
	}

	Widget buttonAdd() => Container(
		alignment: Alignment.center,
		child: OutlinedButton.icon(
			onPressed: (){
				pengalaman.forEach((element) {element.isEdit= false;});
				pekerjaanController.clear();
				descriptionController.clear();
				selectedMonth = months[0];
				selectedMonthEnd = months[0];
				selectedYear = DateTime.now().year.toString();
				selectedYearEnd = DateTime.now().year.toString();
				isShow = true;
				setState(() {});
			}, 
			icon: Icon(Icons.add), 
			label: Text('Tambah pengalam kerja') 
		),
	);

	Widget buildListItemPengalaman(Experience expData, Animation animation) {
		String date = "${expData.dateStart[0]} ${expData.dateStart[1]} - ${expData.dateEnd[0]} ${expData.dateEnd[1]}";
		return SizeTransition(
			sizeFactor: animation,
		  child: Container(
		  	decoration: BoxDecoration(
		  		border: Border(
		  			bottom: BorderSide(color: pengalaman.indexOf(expData)  == pengalaman.length - 1 ? Colors.transparent : Colors.black12)
		  		),
		  	),
		  	child: ListItemWidget(
		  		title: expData.title,
		  		subtitle: date,
		  		onEdit: () {
		  			pengalaman.forEach((element) {element.isEdit = false;});
		  			expData.isEdit = !expData.isEdit;
		  			pekerjaanController.text = expData.title;
		  			descriptionController.text = expData.description;
		  			selectedMonth = expData.dateStart[0];
		  			selectedMonthEnd = expData.dateEnd[0];
		  			selectedYear = expData.dateStart[1];
		  			selectedYearEnd = expData.dateEnd[1];
		  			isShow = false;
		  			setState(() {});
		  		},
		  		onDeleted: () {
						removeExperience(expData);
		  		}, 
		  	),
		  ),
		);
	}

	Widget buildFormExperience({@required Function onSaved, Function onDeleted}) => Column(
		children: [
			buildTextField(controller: pekerjaanController, lable: "Pengalaman pekerjaan", hintText: "mis: Guru"),
			SizedBox(height: 10,),
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text("Tanggal Mulai", style: TextStyle(fontWeight: FontWeight.w500),),
					SizedBox(height: 6),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Expanded(
							  child: buildDropdownButton(
							  	value: selectedMonth,
							  	items: months.map((e) => DropdownMenuItem(
							  		value: e,
							  		child: Text(e, style: TextStyle(fontSize: 12),),
							  	)).toList(),
							  	onChange: (item) => setState(() => selectedMonth = item)
							  ),
							),
							SizedBox(width: 6,),
							Expanded(
							  child: buildDropdownButton(
							  	value: selectedYear,
							  	items: years.map((e) => DropdownMenuItem(
							  		value: e,
							  		child: Text(e, style: TextStyle(fontSize: 12,),),
							  	)).toList(),
							  	onChange: (item) => setState(() => selectedYear = item),
							  ),
							),
						],
					),
				],
			),
			SizedBox(height: 10,),
			Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text("Tanggal Selesai", style: TextStyle(fontWeight: FontWeight.w500),),
					SizedBox(height: 6),
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Expanded(
							  child: buildDropdownButton(
							  	value: selectedMonthEnd,
							  	items: months.map((e) => DropdownMenuItem(
							  		value: e,
							  		child: Text(e, style: TextStyle(fontSize: 12),),
							  	)).toList(),
							  	onChange: (item) => setState(() => selectedMonthEnd = item)
							  ),
							),
							SizedBox(width: 6),
							Expanded(
							  child: buildDropdownButton(
							  	value: selectedYearEnd,
							  	items: years.map((e) => DropdownMenuItem(
							  		value: e,
							  		child: Text(e, style: TextStyle(fontSize: 12,),),
							  	)).toList(),
							  	onChange: (item) => setState(() => selectedYearEnd = item),
							  ),
							),
						],
					),
				],
			),
			SizedBox(height: 10,),
			buildTextField(controller: descriptionController, lable: "Deskripsi", hintText: "...."),
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

	Widget buildTextField({@required TextEditingController controller, @required String lable, String hintText = ""}) => Column(
		crossAxisAlignment: CrossAxisAlignment.start,
		children: [
			Text(lable, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
			SizedBox(height: 5,),
			Container(
				padding: EdgeInsets.symmetric(horizontal: 10),
				decoration: BoxDecoration(
						borderRadius: BorderRadius.circular(8),
						border: Border.all(color: Colors.black26)),
				child: TextFormField(
					controller: controller,
					decoration:InputDecoration(hintText: hintText, hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w300), border: InputBorder.none),
				),
			)
		]
	);

	Widget buildDropdownButton({value, List<DropdownMenuItem> items, Function(dynamic) onChange}) => Container(
		padding: EdgeInsets.symmetric(horizontal: 10),
		decoration: BoxDecoration(
		borderRadius: BorderRadius.circular(8),
		border: Border.all(color: Colors.black26)),
		child: DropdownButton(
			value: value,
			isExpanded: true,
			underline: SizedBox(),
			items: items,
			onChanged: onChange ?? (item){},
		),
	);  

}