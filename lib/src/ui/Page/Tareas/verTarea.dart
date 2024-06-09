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
  final TareasController gestionTareas = Get.put(TareasController());
  AuthController gestionAuth = AuthController();
  Map<String, dynamic> datos = Get.arguments;
  int id_Proyecto = -1;
  int estado = 04; // Todos
  int? botonPresionado; // Variable para rastrear el botón presionado
  List<TareasModel> tareas = [];

  @override
  void initState() {
    super.initState();
    cargarDatosIniciales();
    cargarTareas();
  }

  void cargarDatosIniciales() {
    setState(() {
      id_Proyecto = datos["Id_Proyecto"];
    });
  }

  Future<void> cargarTareas() async {
    try {
      UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();
      await gestionTareas.consultarTareas(id_Proyecto, usuarioActual.idUsuario);
      tareas = gestionTareas.tareas;

      if ((estado == 2 || estado == 3 || estado == 1)) {
        tareas =
            tareas.where((proyecto) => proyecto.idEstado == estado).toList();
      }
      // Estado 02 (Proyectos en curso), Estado 03 (Proyectos completados)

      setState(() {});
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

  void _handleButtonTap(int buttonIndex) {
    setState(() {
      // Si el botón presionado es igual al actual, lo deseleccionamos
      botonPresionado = botonPresionado == buttonIndex ? null : buttonIndex;

      // Actualizamos el estado según el botón presionado
      estado =
          botonPresionado == 1 || botonPresionado == 2 || botonPresionado == 3
              ? botonPresionado ?? 04
              : 04;

      print(estado);
    });
    cargarTareas();
  }

  void _showConfirmationDialog(BuildContext context, int idTareas) {
    bool siUsuarioEsLider = datos["Id_LiderProyecto"];

    if (siUsuarioEsLider) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kSecondaryColor,
            title: Text('Confirmar Eliminación'),
            content: Text('¿Estás seguro de que deseas eliminar  la atarea',
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
                  _eliminarTarea(context, idTareas);
                  cargarTareas();
                },
              ),
            ],
          );
        },
      );
    } else{

       Get.snackbar(
          'Pemiso Denegado',
          'Solo el Lider del Proyecto Puede Eliminar Tareas',
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );

    }
  }

  void _eliminarTarea(BuildContext context, int idTareas) {
    gestiontareas.eliminarTareas(idTareas);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
        title: Text(
          'Mis Tareas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      drawer: Draweer(),
      bottomNavigationBar: BotonNavi(),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondoproyecto.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 11, left: 12),
            padding: EdgeInsets.only(top: 30),
            width: double.infinity,
            height: 720,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 5),
                color: Color.fromARGB(128, 0, 0, 0)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6, left: 6),
                        child: Boton_next(
                          texto: 'Pendientes',
                          onTap: () {
                            _handleButtonTap(1);
                          },
                          isPressed: botonPresionado == 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3.5),
                        child: Boton_next(
                          texto: 'Proceso',
                          onTap: () {
                            _handleButtonTap(2);
                          },
                          isPressed: botonPresionado == 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Boton_next(
                          texto: 'Finalizado',
                          onTap: () {
                            _handleButtonTap(3);
                          },
                          isPressed: botonPresionado == 3,
                        ),
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

                          if (botonPresionado != null) {
                            _handleButtonTap(botonPresionado!);
                          }
                        },
                        child: Column(
                          children: [
                            Container_Mistareas(
                              nombreTarea: tarea.nombre,
                              descripcion: tarea.descripcion,
                              estado: tarea.idEstado,
                              color: Colors.blue,
                              idTareas: tarea.idTarea,
                              click: () => _showConfirmationDialog(
                                  context, tarea.idTarea),
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
        ),
      ]),
    );
  }
}
