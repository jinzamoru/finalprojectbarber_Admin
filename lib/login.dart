// ignore_for_file: use_build_context_synchronously

import 'package:finalprojectbarber/components/k_components.dart';
import 'package:finalprojectbarber/php_data/php_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool showPassword = true;
  bool isLoading = false;

  late SharedPreferences login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/barber.png',
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
                // Lottie.asset(
                //   'assets/login.json',
                //   height: MediaQuery.of(context).size.height * 0.3,
                //   width: MediaQuery.of(context).size.width * 0.7,
                // ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'บริการช่างตัดผมนอกสถานที่',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff8471FF),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    decoration: kTextFormFieldDecoration.copyWith(
                      labelText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: passwordController,
                    cursorColor: const Color(0xff8471FF),
                    style: const TextStyle(fontSize: 18.0),
                    obscureText: showPassword,
                    decoration: kTextFormFieldDecoration.copyWith(
                        labelText: 'Password',
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
                const SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  elevation: 10.0,
                  onPressed: () async {
                    login = await SharedPreferences.getInstance();
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final result = await loginUser(emailController.text,
                          passwordController.text, 'Admin', context);
                      if (result == true) {
                        setState(() {
                          login.setString('email', emailController.text);
                          login.setString('password', passwordController.text);
                          login.setString('roll', 'Admin');
                          login.setBool('login', false);
                          isLoading = false;
                        });
                      }
                       setState(() {
                        isLoading = false;
                      });
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('ข้อผิดพลาด'),
                            content: Text('$e'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('ตกลง'),
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: const Color(0xff8471FF),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20.0,
                                color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
