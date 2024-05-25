import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/detalleProyecto.dart';
/* import 'package:manager_proyect/src/ui/Page/Proyectos/verProyectos.dart'; */

import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';

import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/ui/Page/home/Principal.dart';
/* import 'package:manager_proyect/src/ui/Page/home/Principal.dart'; */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: Crear_proyectos(),
      getPages: [
        GetPage(name: '/profile', page: () => Perfil_Usuario()),
      ],
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: kSecondaryColor,
          textTheme: const TextTheme(
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
