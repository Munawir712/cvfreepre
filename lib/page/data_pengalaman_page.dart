import 'package:flutter/material.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/template_page.dart';
import 'package:pdf_generate_example/widget/list_item_widget.dart';
import 'package:pdf_generate_example/widget/text_filed_widget.dart';
import 'package:pdf_generate_example/widget/time_line_widget.dart';

class DataPengalamanPage extends StatefulWidget {
	final CvPerson data;

  const DataPengalamanPage({Key key, @required this.data}) : super(key: key);

	@override
	_DataPengalamanPageState createState() => _DataPengalamanPageState();
}
class _DataPengalamanPageState extends State<DataPengalamanPage> {
	TextEditingController expWorkTitleController = TextEditingController();
	TextEditingController expWorkDescController = TextEditingController();

	TextEditingController eduSchoolController = TextEditingController();
	TextEditingController eduDescController = TextEditingController();
	List<Experience> pengalaman = [];
	List<Education> pendidikan = [];
	bool isShow = false;
	bool isShowEdu = false;
	List<String> months;
	List<String> years;
	String selectedMonth;
	String selectedYear;
	String selectedMonthEnd;
	String selectedYearEnd;
	


	@override
  void initState() {
    super.initState();
		months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
		years = List.generate(50, (index) => "${1978+index}");
		selectedMonth = months[0];
		selectedMonthEnd = months[0];
		selectedYear = DateTime.now().year.toString();
		selectedYearEnd = DateTime.now().year.toString();
  }

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Cvmaker Gratis"),
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
			  			Container(
								margin: EdgeInsets.all(11),
								decoration: BoxDecoration(
									color: Colors.white,
									boxShadow: [
										BoxShadow(
											color: Colors.black12,
											blurRadius: 5.6,
											spreadRadius: 2.2
										),
									],
									borderRadius: BorderRadius.circular(8),
								),
								padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text("Pengalaman Kerja", style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w500),),
										SizedBox(height: 12,),
										Divider(),
										if(pengalaman != null)
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: pengalaman.map((e) {
													if(e.isEdit == true) {
														expWorkTitleController.text = e.title;
														expWorkDescController.text = e.description;
														return Container(
															padding: EdgeInsets.only(bottom: 10),
															decoration: BoxDecoration(
																border: Border(bottom: BorderSide(color: Colors.black12))
															),
														  child: buildFormExperieceWork(
														  	onDeleted: (){
														  		pengalaman.remove(e);
														  		pengalaman.forEach((element) {element.isEdit = false;});
														  		setState(() {});
														  	},
														  	onSaved: (){
														  		e.title = expWorkTitleController.text;
														  		e.description = expWorkDescController.text;
																	e.dateStart = [selectedMonth, selectedYear];
																	e.dateEnd = [selectedMonthEnd, selectedYearEnd];
														  		pengalaman.forEach((element) {element.isEdit = false;});
														  		isShow = true;
														  		setState(() {});
														  	}
														  ),
														);
													}	else {
														return buildListItemPengalaman(e);
													}
													 
												}).toList(),
											),
									
									isShow == false 
									? buildFormExperieceWork(
											onSaved: (){
												final experience = Experience(
													title: expWorkTitleController.text,
													description: expWorkDescController.text,
													dateStart: [selectedMonth, selectedYear],
													dateEnd: [selectedMonthEnd, selectedYearEnd],
												);
												pengalaman.add(experience);
												isShow = true;
												setState(() {});
											}
										) 
									: Container(
											alignment: Alignment.center,
											child: OutlinedButton.icon(
												onPressed: (){
													clearForm();
													isShow = false;
												}, 
												icon: Icon(Icons.add), 
												label: Text('Tambah pengalam kerja') 
											),
										),
											
										
									],
								),
			  			),

			  			Container(
								margin: EdgeInsets.all(11),
								decoration: BoxDecoration(
									color: Colors.white,
									boxShadow: [
										BoxShadow(
											color: Colors.black12,
											blurRadius: 5.6,
											spreadRadius: 2.2
										),
									],
									borderRadius: BorderRadius.circular(8),
								),
								padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										Text("Pendidikan dan Kualifikasi", style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w500),),
										SizedBox(height: 12,),
										Divider(),
										if(pendidikan != null)
											Column(
												crossAxisAlignment: CrossAxisAlignment.start,
												children: pendidikan.map((e) {
													if(e.isEdit == true) {
														eduSchoolController.text = e.school;
														eduDescController.text = e.description;
														
														return Container(
															padding: EdgeInsets.only(bottom: 10),
															decoration: BoxDecoration(
																border: Border(bottom: BorderSide(color: Colors.black12))
															),
														  child: buildFormEducation(
														  	onDeleted: (){
														  		pendidikan.remove(e);
														  		pendidikan.forEach((element) {element.isEdit = false;});
														  		setState(() {});
														  	},
														  	onSaved: (){
														  		e.school = eduSchoolController.text;
														  		e.description = eduDescController.text;
																	e.dateStart = [selectedMonth, selectedYear];
																	e.dateEnd = [selectedMonthEnd, selectedYearEnd];
														  		pendidikan.forEach((element) {element.isEdit = false;});
														  		isShow = true;
														  		setState(() {});
														  	}
														  ),
														);
													}	else {
														return buildListItemPendidikan(e);
													}
													 
												}).toList(),
											),
									
									isShowEdu == false
									? buildFormEducation(
											onSaved: (){
												final education = Education(
													school: eduSchoolController.text,
													description: eduDescController.text,
													dateStart: [selectedMonth, selectedYear],
													dateEnd: [selectedMonthEnd, selectedYearEnd],
												);
												pendidikan.add(education);
												isShowEdu = true;
												setState(() {});
											}
										) 
									: Container(
											alignment: Alignment.center,
											child: OutlinedButton.icon(
												onPressed: (){
													clearForm();
													isShowEdu = false;
												}, 
												icon: Icon(Icons.add), 
												label: Text('Tambah pendidikan') 
											),
										),
											
										
									],
								),
			  			),
							/// Button Next Step
							ElevatedButton(
								onPressed: (){
									print(expWorkTitleController.text);
									Navigator.push(context, MaterialPageRoute(builder: (context) => TemplatePage(data: widget.data.copyWith(experiences: pengalaman, educations: pendidikan))));
								}, 
								style: ElevatedButton.styleFrom(
									primary: Colors.blueAccent,
								),
								child: Text("Next Step >")
							)
			    ],
			  ),
			)
		);
	}

	Widget buildListItemPengalaman(Experience expData) {
		String date = "${expData.dateStart[0]} ${expData.dateStart[1]} - ${expData.dateEnd[0]} ${expData.dateEnd[1]}";
		return Container(
			decoration: BoxDecoration(
				border: Border(
					bottom: BorderSide(color: expData == pengalaman.last ? Colors.transparent : Colors.black12)
				),
			),
			child: ListItemWidget(
				title: expData.title,
				subtitle: date,
				onEdit: () {
					pengalaman.forEach((element) {element.isEdit = false;});
					expData.isEdit = !expData.isEdit;

					selectedMonth = expData.dateStart[0];
					selectedMonthEnd = expData.dateEnd[0];
					selectedYear = expData.dateStart[1];
					selectedYearEnd = expData.dateEnd[1];
					isShow = true;
					setState(() {});
				},
				onDeleted: () {
					pengalaman.remove(expData);
					setState(() {});
				}, 
			),
		);
	}

	Widget buildListItemPendidikan(Education eduData) {
		String date = "${eduData.dateStart[0]} ${eduData.dateStart[1]} - ${eduData.dateEnd[0]} ${eduData.dateEnd[1]}";
		return Container(
			decoration: BoxDecoration(
				border: Border(
					bottom: BorderSide(color: eduData == pendidikan.last ? Colors.transparent : Colors.black12)
				),
			),
			child: ListItemWidget(
				title: eduData.school,
				subtitle: date,
				onEdit: () {
					pendidikan.forEach((element) {element.isEdit = false;});
					eduData.isEdit = !eduData.isEdit;

					selectedMonth = eduData.dateStart[0];
					selectedMonthEnd = eduData.dateEnd[0];
					selectedYear = eduData.dateStart[1];
					selectedYearEnd = eduData.dateEnd[1];
					isShow = true;
					setState(() {});
				},
				onDeleted: () {
					pendidikan.remove(eduData);
					setState(() {});
				}, 
			),
		);
	}

	void clearForm() {
		pengalaman.forEach((element) {element.isEdit = false;});
		pendidikan.forEach((element) {element.isEdit = false;});
		expWorkTitleController.clear();
		expWorkDescController.clear();
		eduSchoolController.clear();
		eduDescController.clear();
		selectedMonth = months[0];
		selectedMonthEnd = months[0];
		selectedYear = DateTime.now().year.toString();
		selectedYearEnd = DateTime.now().year.toString(); 
		setState(() {});
	}

	Widget buildFormExperieceWork({Function onSaved, Function onDeleted}) => Column(
		children: [
			TextFieldWidget(
				controller: expWorkTitleController,
				label: "Pengalaman Kerja",
			),
			Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
					Expanded(
						flex: 1,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
								Text("Tanggal Mulai", style: TextStyle(color: Colors.black87),),
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
						      			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						      		),
						      	).toList(),
						      	onChanged: (item) => setState((){selectedMonth = item;}),
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
						  			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						  		),
						  	).toList(),
						  	onChanged: (item) => setState((){selectedYear = item;}),
						  ),
						)
					),
					
				],
			),
			SizedBox(height: 10,),
			Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
					Expanded(
						flex: 1,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
								Text("Tanggal Selesai", style: TextStyle(color: Colors.black87),),
								SizedBox(height: 5),
						    Container(
									padding: EdgeInsets.symmetric(horizontal: 10),
									decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(8),
									border: Border.all(color: Colors.black26)),
						      child: DropdownButton(
						      	value: selectedMonthEnd,
						      	isExpanded: true,
										underline: SizedBox(),
						      	items: months.map((e) => DropdownMenuItem(
						      			value: e,
						      			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						      		),
						      	).toList(),
						      	onChanged: (item) => setState((){selectedMonthEnd = item;}),
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
						  	value: selectedYearEnd,
						  	isExpanded: true,
										underline: SizedBox(),
						  	items: years.map((e) => DropdownMenuItem(
						  			value: e,
						  			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						  		),
						  	).toList(),
						  	onChanged: (item) => setState((){selectedYearEnd = item;}),
						  ),
						)
					),
					
				],
			),
			SizedBox(height: 10,),
			TextFieldWidget(
				controller: expWorkDescController,
				label: "Descripsi",
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

	Widget buildFormEducation({Function onSaved, Function onDeleted}) => Column(
		children: [
			TextFieldWidget(
				controller: eduSchoolController,
				label: "Sekolah",
			),
			Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
					Expanded(
						flex: 1,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
								Text("Tanggal Mulai", style: TextStyle(color: Colors.black87),),
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
						      			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						      		),
						      	).toList(),
						      	onChanged: (item) => setState((){selectedMonth = item;}),
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
						  			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						  		),
						  	).toList(),
						  	onChanged: (item) => setState((){selectedYear = item;}),
						  ),
						)
					),
					
				],
			),
			SizedBox(height: 10,),
			Row(
				mainAxisAlignment: MainAxisAlignment.spaceBetween,
				crossAxisAlignment: CrossAxisAlignment.end,
				children: [
					Expanded(
						flex: 1,
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
						  children: [
								Text("Tanggal Selesai", style: TextStyle(color: Colors.black87),),
								SizedBox(height: 5),
						    Container(
									padding: EdgeInsets.symmetric(horizontal: 10),
									decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(8),
									border: Border.all(color: Colors.black26)),
						      child: DropdownButton(
						      	value: selectedMonthEnd,
						      	isExpanded: true,
										underline: SizedBox(),
						      	items: months.map((e) => DropdownMenuItem(
						      			value: e,
						      			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						      		),
						      	).toList(),
						      	onChanged: (item) => setState((){selectedMonthEnd = item;}),
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
						  	value: selectedYearEnd,
						  	isExpanded: true,
										underline: SizedBox(),
						  	items: years.map((e) => DropdownMenuItem(
						  			value: e,
						  			child: Text(e, style: Theme.of(context).textTheme.caption.copyWith(fontWeight: FontWeight.w500),)
						  		),
						  	).toList(),
						  	onChanged: (item) => setState((){selectedYearEnd = item;}),
						  ),
						)
					),
					
				],
			),
			SizedBox(height: 10,),
			TextFieldWidget(
				controller: eduDescController,
				label: "Descripsi",
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
	
	

}

