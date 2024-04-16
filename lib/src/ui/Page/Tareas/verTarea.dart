import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/widgets/BotonProyecto.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/ContainerMistareas.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';



class Ver_Tareas extends StatelessWidget {
  const Ver_Tareas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('Mis Tareas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Draweer(),
      bottomNavigationBar: BotonNavi(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4, left: 2),
                  child: Boton_next(texto: 'Todos'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Boton_next(texto: 'Proceso'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Boton_next(texto: 'Completados'),
                ),
              ],
            ),
            
            Container_Mistareas(
              texto: 'Completado',
              color: Colors.green[400],
            ),
            SizedBox(
              height: 12,
            ),
            Container_Mistareas(
              texto: 'Pendiente',
              color: Colors.red,
            ),
            SizedBox(
              height: 12,
            ),
            Container_Mistareas(
              texto: 'Pendiente',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
