import 'package:flutter/material.dart';
import 'package:pdf_generate_example/shared/theme.dart';

class SectionWidget extends StatelessWidget {
	final String title;
	final bool isVisible;
	final Widget child;
	const SectionWidget({ 
		Key key,
		@required this.title,
		this.child,
		this.isVisible 
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Container(
			margin: EdgeInsets.all(11),
			padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
			decoration: BoxDecoration(
				color: Colors.white,
				borderRadius: BorderRadius.circular(8),
				boxShadow: [
					BoxShadow(
						color: Colors.black12,
						blurRadius: 5.6,
						spreadRadius: 2.2
					),
				],
			),
			child: Column(
				children: [
					Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
					  children: [
					    Text(title, style: textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w600)),
					  ],
					),
					child != null ? Divider() : SizedBox(),
					child ?? SizedBox()
				],
			),
		);
	}
}