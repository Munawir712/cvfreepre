import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/data_pengalaman_page.dart';
import 'package:pdf_generate_example/shared/theme.dart';
import 'package:pdf_generate_example/widget/text_filed_widget.dart';
import 'package:pdf_generate_example/widget/time_line_widget.dart';

class DataPribadiPage extends StatefulWidget {

	@override
	_DataPribadiPageState createState() => _DataPribadiPageState();
}

class _DataPribadiPageState extends State<DataPribadiPage> {
	ImagePicker imagePicker = ImagePicker();
	TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
	File pictureFile;

  _pickImageFile() async {
    PickedFile pickedFile =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
      	pictureFile = File(pickedFile.path);
				print(pictureFile.path);
			});
    }
  }

  _clearImageFile() {
    if (pictureFile != null) {
      setState(() {
	      pictureFile = null;
			});
    }
  }


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text("Cvmaker Gratis", style: textStyle),
				backgroundColor: Colors.blueAccent,
				elevation: 0,
				actions: [
					IconButton(
						color: Colors.white,
						icon: Icon(Icons.arrow_forward),
						onPressed: () => Navigator.push(context, MaterialPageRoute(
							builder: (context) {
								final data = CvPerson(
									name: nameController.text,
									email: emailController.text,
									about: aboutController.text,
									address: addressController.text,
									phoneNumber: phoneNumController.text,
									imageFile: pictureFile,
								);
								return DataPengalamanPage(data: data);
							})),
					),
				],
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
											hintText: 'name',
										),
										TextFieldWidget(
											controller: aboutController,
											label: "About",
											hintText: 'about',
										),
										TextFieldWidget(
											controller: emailController,
											label: "Email",
											hintText: 'email@',
											inputType: TextInputType.emailAddress,
										),
										TextFieldWidget(
											controller: addressController,
											label: "Address",
											hintText: 'address',
											inputType: TextInputType.streetAddress,
										),
										TextFieldWidget(
											controller: phoneNumController,
											label: "Phone Number",
											hintText: 'phone number',
											inputType: TextInputType.phone,
										),
									],
								),
			  			),
							SizedBox(
								height: 50,
								width: 200,
							  child: ElevatedButton(
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
							  		alignment: Alignment.center
							  	),
							  	child: Text("Next Step >")
							  ),
							),
							SizedBox(height: 40)
			    ],
			  ),
			)
		);
	}
	InkWell buildPickImage() {
    return InkWell(
      onTap: _pickImageFile,
      child: Stack(
				clipBehavior: Clip.none,
        children: [
          Container(
						width: 150,
						height: 150,
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Colors.grey,
							// shape: BoxShape.circle,
							borderRadius: BorderRadius.circular(8)
						),
						child: pictureFile != null 
										? Container(
												decoration: BoxDecoration(
													// shape: BoxShape.circle,
													borderRadius: BorderRadius.circular(8),
													image: DecorationImage(image: FileImage(pictureFile), fit: BoxFit.cover)
												)
											) 
										: Text(
											"Add Image",
											style: TextStyle(color: Colors.white60),
										)
					),
          
					Positioned(
						right: -10,
						bottom: -5,
						child: Container(
							padding: EdgeInsets.all(3),
							decoration: BoxDecoration(
								color: Colors.white,
								shape: BoxShape.circle
							),
							child: buildButtonAddImage()
						),
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
          color: pictureFile == null ? Colors.blue : Colors.red,
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


