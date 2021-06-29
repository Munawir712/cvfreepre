import 'package:flutter/material.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/template_page.dart';
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
	TextEditingController dateController = TextEditingController();
	List<Experience> pengalaman = [];
	List<Education> pendidikan = [];
	bool isShow = false;
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
		selectedYear = DateTime.now().year.toString();
		selectedMonthEnd = months[0];
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
														return Container(
															decoration: BoxDecoration(
																border: Border(
																	bottom: BorderSide(color: e == pengalaman.last ? Colors.transparent : Colors.black12)
																)
															),
														  child: ListTile(
														  	// tileColor: Colors.red,
																horizontalTitleGap: 0.0,
														  	title: Text(e.title),
														  	subtitle: Text("${e.dateStart[0]} ${e.dateStart[1]} - ${e.dateEnd[0]} ${e.dateEnd[1]}"),
														  	trailing: Row(
														  		mainAxisSize: MainAxisSize.min,
														  		mainAxisAlignment: MainAxisAlignment.end,
														  		children: [
														  			IconButton(
														  				icon: Icon(Icons.edit), 
														  				onPressed: (){
																				pengalaman.forEach((element) {element.isEdit = false;});
														  					e.isEdit = !e.isEdit;
																				isShow = true;
														  					setState(() {});
														  				}
														  			),
														  			IconButton(
														  				icon: Icon(Icons.delete), 
														  				onPressed: (){
														  					pengalaman.remove(e);
														  					setState(() {});
														  					// print(e.description);
														  				}
														  			),
														  		],
														  	),
														  ),
														);
														
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
											child: ElevatedButton.icon(
												onPressed: (){
													pengalaman.forEach((element) {element.isEdit = false;});
													expWorkTitleController.clear();
													expWorkDescController.clear() ;
													isShow = false;
													setState(() {});
												}, 
												icon: Icon(Icons.add), 
												label: Text('Tambah pengalam kerja') 
											),
										),
											
										
									],
								),
			  			),
						
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
	
	

}

