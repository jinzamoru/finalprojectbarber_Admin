import 'package:finalprojectbarber/model/user_model.dart';
import 'package:finalprojectbarber/theme/extention.dart';
import 'package:finalprojectbarber/widgets/admin_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget AdminList(List<AdminInfo> admin, BuildContext context) {
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Row(
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
        getadminWidgetList(admin, context)
      ],
    ),
  );
}

Widget getadminWidgetList(
    List<AdminInfo> adminDataList, BuildContext context) {
  return Column(
      children: adminDataList.map((x) {
    return adminTile(x, context);
  }).toList());
}
