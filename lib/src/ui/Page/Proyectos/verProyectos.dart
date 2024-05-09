import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';

import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/detalleProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/verTarea.dart';
import 'package:manager_proyect/src/widgets/BotonProyecto.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/PaddingProyecto.dart';

import '../../../widgets/Drawer.dart';

class Ver_Proyectos extends StatefulWidget {
  Ver_Proyectos({Key? key}) : super(key: key);

  @override
  _Ver_ProyectosState createState() => _Ver_ProyectosState();
}

class _Ver_ProyectosState extends State<Ver_Proyectos> {
  final ProyectoController gestionProyectos = ProyectoController();
  List<ProyectoModel> proyectos = [];

  @override
  void initState() {
    super.initState();
    cargarProyectos();
  }

  Future<void> cargarProyectos() async {
    try {
      List<ProyectoModel> proyectosList =await gestionProyectos.consultarProyectos();
      setState(() {
        proyectos = proyectosList;
      });
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

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
        title: Text(
          'Mis Proyectos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: SafeArea(child: Draweer()),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 300, // Ancho fijo del contenedor
            padding: const EdgeInsets.symmetric(
                vertical: 20), // Espacio vertical adicional
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Aquí mostramos los proyectos dinámicamente
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
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
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: proyectos.length,
                  itemBuilder: (context, index) {
                    final proyecto = proyectos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          print('Tapped on project: ${proyecto.nombre}');
                        },
                        child: Container(
                          height: 150,
                          child: Progresos_Proyectos(
                            porcentaje: 0.50,
                            color: Colors.blue,
                            texto: 'En proceso',
                            nombre_proyecto: proyecto.nombre,
                            descripcion: proyecto.descripcion,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(right: 200),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    label: Text(
                      'Atras',
                      style: TextStyle(color: Colors.black),
                    ),
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.to(Crear_proyectos());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
