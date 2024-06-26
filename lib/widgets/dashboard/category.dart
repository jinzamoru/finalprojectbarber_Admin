import 'package:finalprojectbarber/model/hair_model.dart';
import 'package:finalprojectbarber/theme/extention.dart';
import 'package:finalprojectbarber/widgets/dashboard/category_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/barber_model.dart';
import '../../screen/all_hairs.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';



Widget category(List<HairModel> topBarberList, BuildContext context) {
  return Column(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Top Barbers", style: TextStyles.title.bold),
            Text(
              "See All",
              style: TextStyles.titleNormal
                  .copyWith(color: Theme.of(context).primaryColor),
            ).p(8).ripple(() {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AllBarbers()));
            })
          ],
        ),
      ),
      SizedBox(
        height: AppTheme.fullHeight(context) * .28,
        width: AppTheme.fullWidth(context),
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: topBarberList.map((x) {
              return categoryCardWidget(
                context,
                x,
                color: LightColor.orange,
                lightColor: LightColor.lightOrange,
              );
            }).toList()),
      ),
    ],
  );
}