import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/constante/constantes.dart';
import 'package:login/widgets/BottonNavigator.dart';
import 'package:login/widgets/Drawer.dart';
import 'package:login/widgets/labels.dart';

class Crear_proyectos extends StatefulWidget {
  @override
  State<Crear_proyectos> createState() => _Crear_proyectosState();
}

class _Crear_proyectosState extends State<Crear_proyectos> {
  /* FocusNode _focusNode = FocusNode(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('Crear Proyecto', style: TextStyle(color: Colors.white)),
      ),
      drawer: SafeArea(
        child: Draweer(),
      ),
      body: SingleChildScrollView(
        child: Labels(),
      ),
    );
  }
}
