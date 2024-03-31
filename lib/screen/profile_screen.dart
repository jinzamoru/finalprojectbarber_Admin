import 'package:finalprojectbarber/login.dart';
import 'package:finalprojectbarber/screen/edit_profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_manager/data_manager.dart';
import '../model/user_model.dart';

import '../theme/light_color.dart';
import '../widgets/logout.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<DataManagerProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 255, 167, 38),
                      Color.fromARGB(255, 255, 243, 224),
                    ],
                  )),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      // const CircleAvatar(
                      //   radius: 60.0,
                      //   backgroundColor: Colors.deepPurpleAccent,
                      //   // backgroundImage: AssetImage("assets/user.jpg"),
                      // ),
                      Text(
                        "${provider.adminProfile.AdminFirstName} ${provider.adminProfile.AdminLastName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "ผู้ดูแลระบบ",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0, 5),
                              color: Colors.deepOrange.withOpacity(.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('ชื่อ'),
                              subtitle:
                                  Text(provider.adminProfile.AdminFirstName),
                              leading: const Icon(Icons.person),
                              tileColor: Colors.white,
                            ),
                            const Divider(
                              thickness: .3,
                              color: LightColor.grey,
                            ),
                            ListTile(
                              title: const Text('นามสกุล'),
                              subtitle:
                                  Text(provider.adminProfile.AdminLastName),
                              leading: const Icon(Icons.person),
                              tileColor: Colors.white,
                            ),
                            const Divider(
                              thickness: .3,
                              color: LightColor.grey,
                            ),
                            ListTile(
                              title: const Text('อีเมล'),
                              subtitle: Text(provider.adminProfile.AdminEmail),
                              leading: const Icon(Icons.mail),
                              tileColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      MaterialButton(
                        onPressed: () {
                          final adminModel = AdminInfo(
                            AdminId: provider.adminProfile.AdminId,
                            AdminFirstName:
                                provider.adminProfile.AdminFirstName,
                            AdminLastName: provider.adminProfile.AdminLastName,
                            AdminEmail: provider.adminProfile.AdminEmail,
                            AdminPassword: "",
                          );
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  EditProfileScreen(model: adminModel),
                            ),
                          );
                        },
                        color: Colors.orange,
                        child: const Text(
                          'แก้ไข โปรไฟล์',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Logout().accountLogout().whenComplete(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (Route<dynamic> route) => false);
                          });
                        },
                        color: Colors.orange,
                        child: const Text(
                          'ออกจากระบบ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
