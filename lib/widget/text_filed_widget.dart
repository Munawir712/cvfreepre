import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key key,
      @required this.controller,
      this.label = "",
      this.inputType = TextInputType.text,
      this.onTap,
      this.readOnly = false})
      : super(key: key);

  final TextEditingController controller;
  final String label;
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
					Text(label, style: TextStyle(color: Colors.black87),),
					SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black26)),
            child: TextField(
              controller: controller,
              keyboardType: inputType,
              onTap: onTap ?? () {},
              readOnly: readOnly,
              decoration:
                  InputDecoration(hintText: label, border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}
