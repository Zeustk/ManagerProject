import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/detalleProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/detalleTarea.dart';
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
  final AuthController gestionAuth = AuthController();
  List<ProyectoModel> proyectos = [];
  final ProyectoController gestionProyectos = ProyectoController();

  @override
  void initState() {
    super.initState();
    cargarProyectos();
  }

  Future<void> cargarProyectos() async {
    try {
      UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();

      List<ProyectoModel> proyectosList =
          await gestionProyectos.consultarProyectos(usuarioActual.idUsuario);
      setState(() {
        proyectos = proyectosList;
      });
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

  void _showConfirmationDialog(BuildContext context, int idProyecto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kSecondaryColor,
          title: Text('Confirmar Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar este Proyecto?',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                _eliminarProyecto(context, idProyecto);
              },
            ),
          ],
        );
      },
    );
  }

  void _eliminarProyecto(BuildContext context, int idProyecto) {
    setState(() {
      gestionProyectos.eliminarProyecto(idProyecto);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
      String tipo = Get.arguments as String; 

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
        ],
        backgroundColor: kSecondaryColor,
        title: Text(
          'Mis Proyectos',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: SafeArea(child: Draweer()),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            width: 400,
            // Ancho fijo del contenedor
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Aquí mostramos los proyectos dinámicamente
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 4,
                        ),
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
                          if (tipo[0] == 'M') {
                            Get.to(DetalleProyectoPage());
                          } else {
                            Get.to(Ver_Tareas(),
                                arguments: proyecto.idProyecto);
                          }

                          print('Tapped on project: ${proyecto.nombre}');
                        }, 
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 150,
                          child: Row(children: [
                            Progresos_Proyectos(
                              porcentaje: 0.50,
                              color: Colors.blue,
                              texto: 'En proceso',
                              nombre_proyecto: proyecto.nombre,
                              descripcion: proyecto.descripcion,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(top: 50),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _showConfirmationDialog(
                                            context, proyecto.idProyecto);
                                      },
                                      icon: Icon(
                                        Icons.delete_rounded,
                                        color: Colors.red,
                                      ),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    );
                  },
                ),
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
