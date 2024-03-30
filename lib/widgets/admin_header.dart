import 'package:finalprojectbarber/theme/extention.dart';
import 'package:flutter/material.dart';

import '../theme/text_styles.dart';

class AdminHeader extends StatelessWidget {
  const AdminHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          "ผู้ดูแลระบบ",
          style:  TextStyles.title,
        ),
      ],
    ).p16;
  }
}
