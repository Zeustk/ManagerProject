import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
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
  AuthController gestionAuth = AuthController();
  int id_Proyecto = Get.arguments;

  List<TareasModel> tareas = [];

  @override
  void initState() {
    super.initState();
    cargarTareas();
  }

  Future<void> cargarTareas() async {
    try {
      UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();
      List<TareasModel> tareasList = await gestionTareas.consultarTareas(
          id_Proyecto, usuarioActual.idUsuario);
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
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
        title: Text(
          'Mis Tareas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Draweer(),
      bottomNavigationBar: BotonNavi(),
      body: Container(
        margin: EdgeInsets.only(top: 10, right: 11, left: 12),
        padding: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 720,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(128, 0, 0, 0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6, left: 6),
                    child: Boton_next(texto: 'Todos'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3.5),
                    child: Boton_next(texto: 'Proceso'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Boton_next(texto: 'Completado'),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: tareas.map((tarea) {
                  return GestureDetector(
                    onTap: () {
                      // Acción al tocar una tarea (puede navegar a la pantalla de detalles)
                      Get.to(DetalleTarea(), arguments: tarea);
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
      ),
    );
  }
}
