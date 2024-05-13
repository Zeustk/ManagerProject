import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/detalleTarea.dart';
import 'package:manager_proyect/src/widgets/BotonProyecto.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/ContainerMistareas.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';

class Ver_Tareas extends StatefulWidget {
  @override
  State<Ver_Tareas> createState() => _Ver_TareasState();
}

class _Ver_TareasState extends State<Ver_Tareas> {
  TareasController gestionTareas = TareasController();

  List<TareasModel> tareas = [];

  @override
  void initState() {
    super.initState();
    cargarTareas();
  }

  Future<void> cargarTareas() async {
    try {
      List<TareasModel> tareasList = await gestionTareas.consultarTareas();
      setState(() {
        tareas = tareasList;
      });
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text(
          'Mis Tareas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Draweer(),
      bottomNavigationBar: BotonNavi(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
            // Construye dinámicamente los contenedores de tareas basados en la lista
            Column(
              children: tareas.map((tarea) {
                return GestureDetector(
                  onTap: () {
                    // Acción al tocar una tarea (puede navegar a la pantalla de detalles)
                    Get.to(DetalleTarea());
                  },
                  child: Column(
                    children: [
                      Container_Mistareas(
                        nombreTarea: tarea.nombre,
                        descripcion: tarea.descripcion,
                        texto: 'EN PROCESO',
                        color: Colors
                            .blue, // Puedes ajustar el color según lo desees
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
