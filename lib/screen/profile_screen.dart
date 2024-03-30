import 'package:finalprojectbarber/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_manager/data_manager.dart';
import '../widgets/logout.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<DataManagerProvider>(
        builder: (context, provider, child) {
          return Container(
            child: Stack(
              children: [
                SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back)),
                )),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 60.0,
                        backgroundColor: Colors.deepPurpleAccent,
                        backgroundImage: AssetImage("assets/user.jpg"),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        provider.adminProfile.AdminFirstName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        provider.adminProfile.AdminEmail,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Logout().accountLogout().whenComplete(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                                (Route<dynamic> route) => false);
                          });
                        },
                        color: Colors.grey[700],
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
