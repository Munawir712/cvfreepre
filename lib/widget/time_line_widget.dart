import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimeLineWidget extends StatelessWidget {
  const TimeLineWidget({
    Key key,
		@required this.status,
  }) : super(key: key);
	final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
			height: 80,
			child: ListView(
				scrollDirection: Axis.horizontal,
				shrinkWrap: true,
				children: [
					SizedBox(
						width: 100,
						child: TimelineTile(
							axis: TimelineAxis.horizontal,
							isFirst: true,
							indicatorStyle: IndicatorStyle(
								color: status == "DP" || status == "PM" || status == "TP" ?  Colors.green : Colors.grey,
								height: 40,
								iconStyle: IconStyle(iconData: Icons.person, color: status == "DP" || status == "PM" || status == "TP" ? Colors.white : Colors.black)
							),
							beforeLineStyle: LineStyle(color: Colors.green, thickness: 4.0),
							endChild: Text("Data Pribadi", style: TextStyle(color: Colors.white),),
						),
					),
					SizedBox(
						width: 150,
						child: TimelineTile(
							axis: TimelineAxis.horizontal,
							indicatorStyle: IndicatorStyle(
								color: status == "PM" || status == "TP" ? Colors.green : Colors.grey,
								height: 40,
								iconStyle: IconStyle(iconData: Icons.text_snippet, color: status == "PM" || status == "TP"   ? Colors.white : Colors.black)
							),
							afterLineStyle: LineStyle(color: status == "TP" ? Colors.green : Colors.grey, thickness: 4.0),
							beforeLineStyle: LineStyle(color: status == "PM" || status == "TP" ? Colors.green : Colors.grey, thickness: 4.0),
							endChild: Text("Pengalaman", style: TextStyle(color: Colors.white),),
						),
					),
					SizedBox(
						width: 100,
						child: TimelineTile(
							axis: TimelineAxis.horizontal,
							isLast: true,
							indicatorStyle: IndicatorStyle(
								color: status == "TP" ? Colors.green : Colors.grey,
								height: 40,
								iconStyle: IconStyle(iconData: Icons.edit, color: status == "TP" ? Colors.white : Colors.black)
							),
							beforeLineStyle: LineStyle(color: status == "TP" ? Colors.green : Colors.grey, thickness: 4.0),
							endChild: Text("Template", style: TextStyle(color: Colors.white),),
						),
					),
							
				],
			),
		);
  }
}