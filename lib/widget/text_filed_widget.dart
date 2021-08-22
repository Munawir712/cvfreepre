import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key key,
      @required this.controller,
      this.label = "",
			this.hintText,
      this.inputType = TextInputType.text,
      this.onTap,
      this.readOnly = false})
      : super(key: key);

  final TextEditingController controller;
  final String label;
	final String hintText;
  final TextInputType inputType;
  final Function onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					Text(label, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),),
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
			),
    );
  }
}
