import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_generate_example/api/pdf_api.dart';
import 'package:pdf_generate_example/cubit/datacv_cubit.dart';
import 'package:pdf_generate_example/model/cv_person.dart';
import 'package:pdf_generate_example/page/main_page.dart';
import 'package:pdf_generate_example/page/pdf_preview_page.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
	CvPerson data = CvPerson();
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
      context
          .read<DatacvCubit>()
          .getDataCv(data.copyWith(imageFile: pictureFile));
      setState(() {});
    }
  }

  _clearImageFile() {
    if (pictureFile != null) {
      context
          .read<DatacvCubit>()
          .getDataCv(CvPerson().copyWith(imageFile: null));
      pictureFile = null;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
		final state = context.read<DatacvCubit>().state;
		if(state is DatacvGetData ){
			nameController.text = state.cvPerson.name;
			emailController.text = state.cvPerson.email;
			phoneNumController.text = state.cvPerson.phoneNumber;
			addressController.text = state.cvPerson.address;
			aboutController.text = state.cvPerson.about;
		}
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Icon(
            //   Icons.picture_as_pdf_rounded,
            //   size: 40,
            //   color: Colors.white70,
            // ),
            SizedBox(height: 10),
            buildPickImage(),
            // SizedBox(height: 10),
            Container(
							padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
							height: MediaQuery.of(context).size.height  / 2,
							child: ListView(
								shrinkWrap: true,
								children: [
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: TextField(
											controller: nameController,
											decoration: InputDecoration(
													labelText: "Name",
													filled: true,
													fillColor: Colors.grey.shade300,
													border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(10))),
										),
									),
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: TextField(
											controller: emailController,
											keyboardType: TextInputType.emailAddress,
											decoration: InputDecoration(
													labelText: "Email",
													filled: true,
													fillColor: Colors.grey.shade300,
													border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(10))),
										),
									),
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: TextField(
											controller: phoneNumController,
											keyboardType: TextInputType.phone,
											decoration: InputDecoration(
													labelText: "Phone Number",
													filled: true,
													fillColor: Colors.grey.shade300,
													border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(10))),
										),
									),
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: TextField(
											controller: addressController,
											keyboardType: TextInputType.streetAddress,
											decoration: InputDecoration(
													labelText: "Address",
													filled: true,
													fillColor: Colors.grey.shade300,
													border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(10))),
										),
									),
									Padding(
										padding: const EdgeInsets.all(8.0),
										child: TextField(
												maxLength: 300,
												maxLines: 5,
											controller: aboutController,
											decoration: InputDecoration(
													labelText: "About you",
													fillColor: Colors.grey.shade300,
													filled: true,
													border: OutlineInputBorder(
															borderRadius: BorderRadius.circular(10))),
										),
									),
								],
							),
						),
            // SizedBox(height: 10),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    primary: Colors.blue.shade900,
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                child: Text("Generate CV"),
                onPressed: () async {
                  final dataCv = CvPerson(
                    name: nameController.text.trim(),
                    email: emailController.text,
										phoneNumber: phoneNumController.text,
										address: addressController.text,
                    about: aboutController.text,
                    imageFile: pictureFile,
                  );
                  await context.read<DatacvCubit>().getDataCv(dataCv);
                  print("data berhasil di kirim");
									final text = "Data success input";
									final snackBar = SnackBar(content: Text(text),);

									ScaffoldMessenger.of(context).showSnackBar(snackBar);

									await Future.delayed(Duration(seconds: 1));

                  Navigator.push(context, MaterialPageRoute(builder: (context) => PdfPreviewPage()));
                },
              ),
            ),
						SizedBox(height:20,)
          ],
        ),
      ),
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
              child: BlocBuilder<DatacvCubit, DatacvState>(
                builder: (context, state) {
									if(state is DatacvGetData){
										pictureFile = state.cvPerson.imageFile;
										if(pictureFile !=  null) {
											return Container(
												decoration: BoxDecoration(
														shape: BoxShape.circle,
														image: DecorationImage(
																image: FileImage(pictureFile), fit: BoxFit.cover)));
										} else {
											return Text(
											"Add Image",
											style: TextStyle(color: Colors.white60),
										);
										}
									} else {
										return Text(
											"Add Image",
											style: TextStyle(color: Colors.white60),
										);

									}
                },
              )),
          // BlocBuilder<DatacvCubit, DatacvState>(
          //   builder: (context, state) {
          //     return ;
          //   },
          // ),
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
