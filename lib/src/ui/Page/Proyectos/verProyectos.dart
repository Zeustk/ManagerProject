import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';


import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/widgets/BotonProyecto.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';
import 'package:manager_proyect/src/widgets/PaddingProyecto.dart';



class Proyectos extends StatelessWidget {
  const Proyectos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      appBar: AppBar(
        actions: [
          const SizedBox(
            width: 50,
            child: Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            width: 50,
            child: const Icon(
              Icons.add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: kSecondaryColor,
        title: const Text(
          'Mis Proyectos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: const SafeArea(child: Draweer()),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
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
              Progresos_Proyectos(
                  porcentaje: 0.40, color: Colors.blue, texto: 'En Proceso'),
              Progresos_Proyectos(
                porcentaje: 1.0,
                color: Colors.green,
                texto: 'Completado',
              ),
              Progresos_Proyectos(
                porcentaje: 0.10,
                color: Colors.orange,
                texto: 'En Proceso',
              ),
              Progresos_Proyectos(
                porcentaje: 0.0,
                color: Colors.red,
                texto: 'No iniciado',
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white // Cambia esto al color que desees
                        ),
                    label: Text(
                      'Atras',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.to(Crear_proyectos());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
