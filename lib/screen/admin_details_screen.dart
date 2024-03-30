import 'package:finalprojectbarber/model/user_model.dart';
import 'package:finalprojectbarber/theme/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/k_components.dart';
import '../php_data/php_data.dart';
import '../theme/light_color.dart';
import '../theme/text_styles.dart';
import '../theme/theme.dart';

class AdminDetailScreen extends StatefulWidget {
  final AdminInfo model;

  AdminDetailScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  _AdminDetailScreenState createState() => _AdminDetailScreenState();
}

class _AdminDetailScreenState extends State<AdminDetailScreen> {
  late AdminInfo model;

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  bool showPassword = true;
  @override
  void initState() {
    model = widget.model;
    super.initState();
    nameController.text = model.AdminFirstName;
    lastnameController.text = model.AdminLastName;
    emailController.text = model.AdminEmail;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: Stack(
        children: <Widget>[
          DraggableScrollableSheet(
            maxChildSize: 1.0,
            minChildSize: 1.0,
            initialChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                height: AppTheme.fullHeight(context) * .5,
                padding: const EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 16,
                ), //symmetric(horizontal: 19, vertical: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const BackButton(
                          color: Colors.black,
                        ),
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "แก้ไขข้อมูล",
                                  style:
                                      titleStyle.copyWith(color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: nameController,
                            cursorColor: const Color(0xff8471FF),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: kTextFormFieldDecoration.copyWith(
                              labelText: 'ชื่อ',
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: lastnameController,
                            cursorColor: const Color(0xff8471FF),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: kTextFormFieldDecoration.copyWith(
                              labelText: 'นามสกุล',
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          child: TextFormField(
                            controller: emailController,
                            cursorColor: const Color(0xff8471FF),
                            style: const TextStyle(fontSize: 18.0),
                            decoration: kTextFormFieldDecoration.copyWith(
                              labelText: 'อีเมล',
                            ),
                          ),
                        ),
                      Container(
                          height: 60,
                          child: TextFormField(
                            controller: passwordController,
                            cursorColor: const Color(0xff8471FF),
                            style: const TextStyle(fontSize: 18.0),
                            obscureText: showPassword,
                            decoration: kTextFormFieldDecoration.copyWith(
                                labelText: 'รหัสผ่าน',
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    child: Icon(showPassword
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash))),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: LightColor.grey.withAlpha(150),
                          ),
                          child: const Icon(
                            Icons.update,
                            color: Color.fromARGB(255, 2, 158, 255),
                          ),
                        ).ripple(
                          () {
                            if (nameController.text.isEmpty ||
                                lastnameController.text.isEmpty ||
                                emailController.text.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('ข้อผิดพลาด'),
                                    content:
                                        Text("กรุณากรอกข้อมูลให้ครบทุกช่อง"),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('ตกลง'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              final adminModel = AdminInfo(
                                AdminId: model.AdminId,
                                AdminFirstName: nameController.text,
                                AdminLastName: lastnameController.text,
                                AdminEmail: emailController.text,
                                AdminPassword: passwordController.text,
                              );
                              updateAdmin(adminModel, context);
                            }
                          },
                          borderRadius: BorderRadius.circular(10),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ).vP16),
              );
            },
          ),
          // _appbar(),
        ],
      ),
    );
  }
}
