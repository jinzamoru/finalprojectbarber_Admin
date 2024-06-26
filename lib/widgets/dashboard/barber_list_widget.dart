import 'package:finalprojectbarber/theme/extention.dart';
import 'package:finalprojectbarber/widgets/barber_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/barber_model.dart';


Widget BarberList(List<BarberInfo> barber, BuildContext context) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Text("", style: TextStyles.title.bold),
            // IconButton(
            //     icon: Icon(
            //       Icons.sort,
            //       color: Theme.of(context).primaryColor,
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           CupertinoPageRoute(
            //               builder: (context) => const AllBarbers()));
            //     })
            // .p(12).ripple(() {}, borderRadius: BorderRadius.all(Radius.circular(20))),
          ],
        ).hP16,
        getbarberWidgetList(barber, context)
      ],
    ),
  );
}

Widget getbarberWidgetList(
    List<BarberInfo> barberDataList, BuildContext context) {
  return Column(
      children: barberDataList.map((x) {
    return barberTile(x, context);
  }).toList());
}
