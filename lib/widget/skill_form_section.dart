import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generate_example/cubit/experiece_data_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/shared/theme.dart';
import 'package:pdf_generate_example/widget/list_item_widget.dart';
import 'package:pdf_generate_example/widget/section_widget.dart';

class SkillFormSection extends StatefulWidget {
	SkillFormSection({Key key}) : super(key: key);

	@override
	SkillFormSectionState createState() => SkillFormSectionState();
}

class SkillFormSectionState extends State<SkillFormSection> {
	final listKey = GlobalKey<AnimatedListState>();
	String selectedLevel;
	TextEditingController skillnameController = TextEditingController();
	List<String> levels = ['Pemula', 'Menengah', 'Terampil', 'Berpengalaman', 'Ahli']; 
	List<Skill> skills = [];
	bool visible = false;

	@override
  void initState() {
    super.initState();
		selectedLevel = levels[0];
		skills = context.read<ExperieceDataCubit>().getSkills();
  }

	@override
	Widget build(BuildContext context) {
		return SectionWidget(
			title: "Skill",
			child: Column(
				children: [
					AnimatedList(
						shrinkWrap: true,
						physics: NeverScrollableScrollPhysics(),
						key: listKey,
						initialItemCount: skills.length,
						itemBuilder: (context, index, animation) {
							final skill = skills[index];
							
							return AnimatedContainer(
								height: skill.isEdit ? 150 : 50,
								duration: Duration(milliseconds: 500),
								child: Wrap(
									children: [
										skill.isEdit 
										? buildForm(
												onSaved: () => editSkill(skill),
												onDeleted: () => removedSkill(skill)
											)
										: buildListItem(
												skill: skill,
												animation: animation,
												onEdited: () => onEdited(skill),
												onRemoved: () => removedSkill(skill)
											)
									],
								),
							);
						},
					),
					visible == true ?
					Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Row(
								crossAxisAlignment: CrossAxisAlignment.end,
								children: [
									Expanded(
										child: buildTextField(
											controller: skillnameController, 
											lable: 'Keahlian', 
											hintText: 'mis. Ngoding',
										)
									),
									SizedBox(width:6),
									Expanded(
										child: buildDropdownButton(
											value: selectedLevel,
											label: "Level",
											items: levels.map((e) => DropdownMenuItem(
												value: e,
												child: Text(e, style: TextStyle(fontSize: 12,),),
											)).toList(),
											onChange: (item){
												setState(() {
													selectedLevel = item;
												});
											}
										),
									),
								],
							),
							SizedBox(height: 10,),
							Row(
								mainAxisAlignment: MainAxisAlignment.end,
								children: [
									ElevatedButton.icon(
										onPressed: () => setState(() => visible = !visible), 
										style: ElevatedButton.styleFrom(
											primary: Colors.red,
										),
										icon: Icon(Icons.delete),
										label: Text("Hapus",)
									),
									SizedBox(width: 6,),
									ElevatedButton.icon(
										onPressed: () => addSkill(), 
										style: ElevatedButton.styleFrom(
											primary: Colors.blueAccent,
										),
										icon: Icon(Icons.save),
										label: Text("Simpan",)
									),
								],
							),
						],
					) 
					: OutlinedButton.icon(
							onPressed: (){
								skills.forEach((element) {element.isEdit = false;});
								visible = true;
								skillnameController.clear();
								selectedLevel = levels[0];
								setState((){});
							}, 
							style: OutlinedButton.styleFrom(
								primary: Colors.blueAccent,
								// textStyle: TextStyle(fontWeight: FontWeight.w500,)
							),
							icon: Icon(Icons.add),
							label: Text("Tambah skill lainnya",)
						),
				],
			),
		);
	}

	void addSkill() {
		final skill = Skill(
			skillName: skillnameController.text,
			level: selectedLevel, 
		);
		visible = false;
		final index = skills.length;
		// skills.add(skill);
		context.read<ExperieceDataCubit>().addSkill(skill);
		listKey.currentState.insertItem(index);
		setState(() {});
	}

	void editSkill(Skill skill) {
		skill.skillName = skillnameController.text;
		skill.level = selectedLevel;
		skill.isEdit = false;
		setState(() {});
	}

	void removedSkill(Skill skill) {
		final index = skills.indexOf(skill);
		skills.removeAt(index);

		listKey.currentState.removeItem(index, (context, animation) => buildListItem(skill: skill, animation: animation));
	}

	void onEdited(Skill skill) {
		skills.forEach((element) {element.isEdit = false;});
		skill.isEdit = !skill.isEdit;
		visible = false;
		skillnameController.text = skill.skillName;
		selectedLevel = skill.level;
		setState(() {});
	}

	Widget buildListItem({@required Skill skill, @required Animation animation, Function onEdited, Function onRemoved}) {
		return SizeTransition(
			sizeFactor: animation,
		  child: Container(
				decoration: BoxDecoration(
					border: Border(
						bottom: BorderSide(color: skills.indexOf(skill) == skills.length - 1 ? Colors.transparent : Colors.black12)
					)
				),
		    child: ListItemWidget(
		    	title: skill.skillName,
		    	subtitle: skill.level,
		    	onEdit: onEdited ?? (){},
		    	onDeleted: onRemoved ?? (){},
		    ),
		  ),
		);
	}

	Widget buildForm({@required Function onSaved, Function onDeleted}) {
	  return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Row(
					// mainAxisAlignment: MainAxisAlignment.spaceAround,
					crossAxisAlignment: CrossAxisAlignment.end,
					children: [
						Expanded(
							child: buildTextField(
								controller: skillnameController, 
								lable: 'Keahlian', 
								hintText: 'mis: Ngoding',
							)
						),
						SizedBox(width:6),
						Expanded(
							child: buildDropdownButton(
								value: selectedLevel,
								label: "Level",
								items: levels.map((e) => DropdownMenuItem(
									value: e,
									child: Text(e, style: TextStyle(fontSize: 12,),),
								)).toList(),
								onChange: (item){
									setState(() {
										selectedLevel = item;
									});
								}
							),
						),
					],
				),
				SizedBox(height: 10,),
				Row(
					mainAxisAlignment: MainAxisAlignment.end,
					children: [
						onDeleted != null ? ElevatedButton.icon(
							onPressed: onDeleted ?? (){}, 
							style: ElevatedButton.styleFrom(
								primary: Colors.red,
								textStyle: textStyle
							),
							icon: Icon(Icons.delete),
							label: Text("Hapus",)
						) : SizedBox(),
						SizedBox(width: 6,),
						ElevatedButton.icon(
							onPressed: onSaved ?? (){}, 
							style: ElevatedButton.styleFrom(
								primary: Colors.blueAccent,
								textStyle: textStyle
							),
							icon: Icon(Icons.save),
							label: Text("Simpan",)
						),
					],
				),
			],
		);
	}

	Widget buildDropdownButton({value, List<DropdownMenuItem> items, String label, Function(dynamic) onChange}) => Column(
		crossAxisAlignment: CrossAxisAlignment.start,
	  children: [
			if(label != null)
				Text(label, style: TextStyle(fontWeight:FontWeight.w500, color: Colors.black87 )),
				SizedBox(height: 5,),
	    Container(
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

}