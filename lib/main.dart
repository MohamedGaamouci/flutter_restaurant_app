import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:offi_memoire/Admin/admin.dart';
import 'package:offi_memoire/spashscreen/spashscreen.dart';
import 'Login/Login.dart';
import 'package:offi_memoire/restaurants_element/restaurants_list.dart';
import 'start.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(233, 157, 5, 1),
      ),
      // home: start(),
      home: Myspashscreen(),
      routes: {
        "start_page": (context) => start(),
        "home_page": (context) => RestaurantList(),
        "home_admin":(context) => Admin(),
        "Login": (context) => Login(),
      },
    );
  }
}
