import 'package:flutter/material.dart';
import 'package:manager_proyect/constante/constantes.dart';
import 'package:manager_proyect/widgets/BotonProyecto.dart';
import 'package:manager_proyect/widgets/BottonNavigator.dart';
import 'package:manager_proyect/widgets/Drawer.dart';

class Mis_Tareas extends StatelessWidget {
  const Mis_Tareas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Column(
          children: [
            SizedBox(
              height: 17,
            ),
            Text(
              'Nombre del Proyecto',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Mis Tareas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Draweer(),
      bottomNavigationBar: BotonNavi(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Row(
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        'aaa',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        'Nombre del Proyecto',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        'Descripción',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
