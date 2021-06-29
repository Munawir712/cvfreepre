import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/data_pengalaman_page.dart';
import 'package:pdf_generate_example/widget/text_filed_widget.dart';
import 'package:pdf_generate_example/widget/time_line_widget.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DataPribadiPage extends StatefulWidget {

	@override
	_DataPribadiPageState createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {

	TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
	File pictureFile;

  _pickImageFile() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pictureFile = File(pickedFile.path);
     
      setState(() {});
    }
  }

  _clearImageFile() {
    if (pictureFile != null) {
      
      pictureFile = null;
      setState(() {});
    }
  }


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Cvmaker Gratis"),
				backgroundColor: Colors.blueAccent,
				elevation: 1,
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
										Text("Detail pribadi", style: TextStyle( color:Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
										SizedBox(height: 10,),
										TimeLineWidget(status: "DP",),
									],
								),
							),
			  			Container(
								padding: EdgeInsets.only(top: 10, left: 16, right: 16),
			  				child: Column(
									children: [
										buildPickImage(),
										TextFieldWidget(
											controller: nameController,
											label: "Name",
										),
										TextFieldWidget(
											controller: aboutController,
											label: "About",
										),
										TextFieldWidget(
											controller: emailController,
											label: "Email",
											inputType: TextInputType.emailAddress,
										),
										TextFieldWidget(
											controller: addressController,
											label: "Address",
											inputType: TextInputType.streetAddress,
										),
										TextFieldWidget(
											controller: phoneNumController,
											label: "Phone Number",
											inputType: TextInputType.phone,
										),
									],
								),
			  			),
							ElevatedButton(
								onPressed: (){
									final dataPerson = CvPerson(
										imageFile: pictureFile,
										name: nameController.text,
										email: emailController.text,
										about: aboutController.text,
										address: addressController.text,
										phoneNumber: phoneNumController.text,
									);

									Navigator.push(context, MaterialPageRoute(
										builder: (context) => DataPengalamanPage(data: dataPerson,)
										),
									);
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
	InkWell buildPickImage() {
    return InkWell(
      onTap: _pickImageFile,
      child: Stack(
        children: [
          Container(
						width: 120,
						height: 120,
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Colors.grey,
							shape: BoxShape.circle,
						),
						child: pictureFile != null 
										? Container(
												decoration: BoxDecoration(
													shape: BoxShape.circle,
													image: DecorationImage(image: FileImage(pictureFile), fit: BoxFit.cover)
												)
											) 
										: Text(
											"Add Image",
											style: TextStyle(color: Colors.white60),
										)
					),
          
					Positioned(
						right: 10,
						bottom: 0,
						child: buildButtonAddImage(),
					)
        ],
      ),
    );
  }


  InkWell buildButtonAddImage() {
    return InkWell(
      splashColor: Colors.blue.shade700,
      onTap: () {
        if (pictureFile == null) {
          _pickImageFile();
        } else {
          _clearImageFile();
        }
      },
      child: ClipOval(
        child: Container(
          color: Colors.blue,
          padding: EdgeInsets.all(8),
          child: Icon(
            pictureFile == null ? Icons.add_a_photo : Icons.cancel,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

}


