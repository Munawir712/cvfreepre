import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
	final String title;
	final String subtitle;
	final Function onEdit; 
	final Function onDeleted;

  const ListItemWidget({Key key, this.title, this.subtitle, this.onEdit, this.onDeleted}) : super(key: key); 

	@override
	Widget build(BuildContext context) {
		return ListTile(
			horizontalTitleGap: 0.0,
			title: Text(title),
			subtitle: Text(subtitle),
			trailing: Row(
				mainAxisSize: MainAxisSize.min,
				mainAxisAlignment: MainAxisAlignment.end,
				children: [
					IconButton(
						icon: Icon(Icons.edit), 
						onPressed: onEdit ?? (){}
					),
					IconButton(
						icon: Icon(Icons.delete), 
						onPressed: onDeleted ?? (){}
					),
				],
			),
		);
	}
}