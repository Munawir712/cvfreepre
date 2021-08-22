import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
	final String title;
	final String subtitle;
	final Function onEdit; 
	final Function onDeleted;

  const ListItemWidget({Key key, this.title, this.subtitle, this.onEdit, this.onDeleted}) : super(key: key); 

	@override
	Widget build(BuildContext context) {
		// return ListTile(
		// 	title: Text(title),
		// 	subtitle: Text(subtitle, style: TextStyle(fontSize: 12),),
		// 	trailing: Row(
		// 		mainAxisSize: MainAxisSize.min,
		// 		mainAxisAlignment: MainAxisAlignment.end,
		// 		children: [
		// 			IconButton(
		// 				icon: Icon(Icons.edit), 
		// 				onPressed: onEdit ?? (){}
		// 			),
		// 			IconButton(
		// 				icon: Icon(Icons.delete), 
		// 				onPressed: onDeleted ?? (){}
		// 			),
		// 		],
		// 	),
		// );
		return buildTile();
	}

	Widget buildTile() {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: [
				Expanded(
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(title),
							SizedBox(height: 6,),
							Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey),)
						],
					),
				),
				Row(
					crossAxisAlignment: CrossAxisAlignment.center,
				  children: [
				    IconButton(
				    	icon: Icon(Icons.edit, size: 20, color: Colors.grey.shade500,),
				    	onPressed: onEdit,
				    ),
				    IconButton(
				    	icon: Icon(Icons.delete, size: 20, color: Colors.grey.shade500,),
				    	onPressed: onDeleted,
				    ),
				  ],
				),
				
			],
		);
	}
}