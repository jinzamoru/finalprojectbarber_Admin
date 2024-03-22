import 'package:finalprojectbarber/homepage.dart';
import 'package:finalprojectbarber/login.dart';
import 'package:finalprojectbarber/screen/editprofile.dart';
import 'package:finalprojectbarber/screen/profile.dart';
import 'package:finalprojectbarber/user_provider.dart';
import '../data_manager/data_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DataManagerProvider()),
      ],
      child: MaterialApp(
        title: 'ProjectX',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/edit_profile': (context) => EditProfile(),
          '/profile': (context) => UserProfile(),
        },
      ),
    );
  }
}
