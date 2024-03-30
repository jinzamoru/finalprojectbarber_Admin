import 'package:finalprojectbarber/model/barber_model.dart';
import 'package:finalprojectbarber/theme/extention.dart';
import 'package:finalprojectbarber/widgets/random_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../php_data/php_data.dart';
import '../screen/barber_details_screen.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';

Widget barberTile(BarberInfo model, BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      boxShadow: <BoxShadow>[
        const BoxShadow(
          offset: Offset(4, 4),
          blurRadius: 10,
          color: Colors.black26,
        ),
        BoxShadow(
          offset: const Offset(-3, 0),
          blurRadius: 15,
          color: LightColor.grey.withOpacity(.1),
        )
      ],
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(13)),
                child: Hero(
                  tag: 'image',
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: randomColor(context),
                    ),
                  ),
                ),
              ),
              title: Text(
                "${model.barberFirstName} ${model.barberLastName}",
                style: TextStyles.title.bold
                    .copyWith(color: Colors.black, fontSize: 16.0),
              ),
              subtitle: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.barberEmail,
                        style: TextStyles.bodySm.subTitleColor.bold
                            .copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        model.barberPhone,
                        style: TextStyles.bodySm.subTitleColor.bold
                            .copyWith(fontSize: 12.0),
                      ),
                      const SizedBox(height: 4.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BarberDetailScreen(model: model),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              size: 30,
              color: Colors.red,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('ลบข้อมูล'),
                    content: const Text('ต้องการลบข้อมูลนี้หรือไม่?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('ยกเลิก'),
                      ),
                      TextButton(
                        onPressed: () {
                          deleteBarber(model.barberId , model.barberCertificate , context);
                        },
                        child: const Text('ลบ'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
