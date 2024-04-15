import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login/Page/Principal.dart';

import 'package:login/constante/constantes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: Principal(),
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kSecondaryColor,
          textTheme: TextTheme(
              headlineSmall:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              labelSmall: TextStyle(color: Colors.white),
              headlineMedium: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal)),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white.withOpacity(0.5))))),
    );
  }
}
