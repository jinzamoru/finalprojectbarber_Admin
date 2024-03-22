import 'dart:convert';
import 'package:finalprojectbarber/components/k_components.dart';
import 'package:finalprojectbarber/homepage.dart';
import 'package:finalprojectbarber/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_provider.dart';
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
  bool isBarber = false;

  late SharedPreferences login;
  // ฟังก์ชันสำหรับส่งคำขอล็อกอินไปยัง PHP API
  Future<void> loginUser(BuildContext context) async {
    final url = 'http://127.0.0.1/user/login.php';

    try {
      print('Sent data: ${{
        'email': emailController.text,
        'password': passwordController.text,
      }}');

      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        if (data['result'] == 1) {
          final Map<String, dynamic> userData = data['data'];
          String id = userData['user_id'].toString();

          userProvider.setUserId(id);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        } else {
          showErrorDialog('อีเมลหรือรหัสผ่านไม่ถูกต้อง');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        showErrorDialog('เชื่อมต่อกับเซิร์ฟเวอร์ล้มเหลว');
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      showErrorDialog('เกิดข้อผิดพลาด: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  // ฟังก์ชันสำหรับแสดงไดอะล็อกข้อผิดพลาด
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ข้อผิดพลาด'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

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
                Container(
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
                Container(
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
                // InkWell(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         CupertinoPageRoute(
                //             builder: (context) =>
                //                 const ForgetPasswordScreen()));
                //   },
                //   child: const Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       'Forget Password?',
                //       style: TextStyle(color: Colors.black),
                //     ),
                //   ),
                // ),
                CheckboxListTile(
                  contentPadding: const EdgeInsets.all(0.0),
                  title: const Text("Login as barber"),
                  value: isBarber,
                  onChanged: (newValue) {
                    setState(() {
                      isBarber = newValue!;
                    });
                  },
                  controlAffinity:
                      ListTileControlAffinity.leading, //  <-- leading Checkbox
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
                    loginUser(context);

                    // if (isBarber) {
                    // try {
                    //   signIn(emailController.text, passwordController.text,
                    //           'Barbers', context)
                    //       .whenComplete(() => setState(() {
                    //             login.setString(
                    //                 'email', emailController.text);
                    //             login.setString(
                    //                 'password', passwordController.text);
                    //             login.setString('roll', 'Barber');
                    //             login.setBool('login', false);
                    //             isLoading = false;
                    //           }));
                    // } catch (e) {
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(SnackBar(content: Text('$e')));
                    //   setState(() {
                    //     isLoading = false;
                    //   });
                    // }
                    // } else {
                    // final userProfile = await FirebaseFirestore.instance
                    //     .collection('Customer')
                    //     .where('email', isEqualTo: emailController.text)
                    //     .get();

                    //   if (userProfile.docs.isEmpty) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(content: Text('User not found')));
                    //     setState(() {
                    //       isLoading = false;
                    //     });
                    //   } else {
                    //     signIn(emailController.text, passwordController.text,
                    //             'Customer', context)
                    //         .whenComplete(() => setState(() {
                    //               login.setString(
                    //                   'email', emailController.text);
                    //               login.setString(
                    //                   'password', passwordController.text);
                    //               login.setString('roll', 'Customer');
                    //               login.setBool('login', false);
                    //               isLoading = false;
                    //             }));
                    //   }
                    // }
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have account? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8499F0)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
