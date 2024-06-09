import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/DetallesController.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/detalleProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/verTarea.dart';
import 'package:manager_proyect/src/widgets/BotonProyecto.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Iconobuscar.dart';
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
  final DetallesController gestionDetalles = DetallesController();
  String tipo = Get.arguments as String;
  int estado = 04; // Todos
  int? botonPresionado;
  String nombreTextBusqueda = '';
  UsuarioModel usuarioActual = UsuarioModel();
  List<Map<String, dynamic>> proyectosDeLiderActual = [];

  @override
  void initState() {
    super.initState();
    cargarProyectos();
    cargarProyectosByUsuarioLiderActual();
  }

  Future<void> cargarProyectosByUsuarioLiderActual() async {
    try {
      UsuarioModel usuarioActualinfo =
          await gestionAuth.obtenerDatosDeStorage();
      List<Map<String, dynamic>> proyectosByLiderActual =
          await gestionDetalles.obtenerProyectosLiderPorUsuario(
              usuarioActualinfo.idUsuario);

      print(proyectosByLiderActual);

      setState(() {
        proyectosDeLiderActual = proyectosByLiderActual;
        usuarioActual = usuarioActualinfo;
      });
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

  Future<void> cargarProyectos() async {
    try {
      UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();
      List<ProyectoModel> proyectosList =
          await gestionProyectos.consultarProyectos(usuarioActual.idUsuario);

      print('entro');

      proyectosList = listaFiltrada(proyectosList);

      setState(() {
        proyectos = proyectosList;
      });
    } catch (error) {
      // Manejar el error de la consulta de proyectos
      print('Error al cargar proyectos: $error');
    }
  }

  List<ProyectoModel> listaFiltrada(List<ProyectoModel> listaTodos) {
    if ((estado == 2 || estado == 3 || estado == 1) &&
        (nombreTextBusqueda.isEmpty)) {
      return listaTodos
          .where((proyecto) => proyecto.idEstado == estado)
          .toList();
    } // Estado 02 (Proyectos en curso), Estado 03 (Proyectos completados)

    if ((estado == 2 || estado == 3 || estado == 1) &&
        (nombreTextBusqueda.isNotEmpty)) {
      return listaTodos
          .where((proyecto) =>
              proyecto.idEstado == estado &&
              proyecto.nombre
                  .trim()
                  .toUpperCase()
                  .contains(nombreTextBusqueda.trim().toUpperCase()))
          .toList();
    } // Estado 02 (Proyectos en curso), Estado 03 (Proyectos completados)

    if ((estado == 4) && (nombreTextBusqueda.isNotEmpty)) {
      return listaTodos
          .where((proyecto) => proyecto.nombre
              .toUpperCase()
              .trim()
              .contains(nombreTextBusqueda.toUpperCase()))
          .toList();
    } // Estado 02 (Proyectos en c

    return listaTodos;
  }

  void _showConfirmationDialog(BuildContext context, int idProyecto) {
  

    bool siUsuarioEsLider = proyectosDeLiderActual.any((proyecto) {
        print(proyecto["Id_Proyecto"]);
      return proyecto["Id_Proyecto"] == idProyecto;
    });

  

    if (siUsuarioEsLider) {
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
                  cargarProyectos();
                },
              ),
            ],
          );
        },
      );
    } else {
       Get.snackbar(
          'Pemiso Denegado',
          'Solo el Lider del Proyecto Puede Eliminar Proyectos',
          backgroundColor: Colors.white,
          colorText: Colors.black,
        );
    }
  }

  void _eliminarProyecto(BuildContext context, int idProyecto) {
    setState(() {
      gestionProyectos.eliminarProyecto(idProyecto);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido eliminado')),
    );
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
    cargarProyectos();
  }

  void _handleSearch(String text) {
    print("Texto ingresado: $text");

    setState(() {
      nombreTextBusqueda = text;
      cargarProyectos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Quita el foco del campo de búsqueda cuando se toca fuera de él
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: BotonNavi(),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(164, 83, 80, 80),
          title: TextoGhost(onTextChanged: _handleSearch),
        ),
        drawer: SafeArea(child: Draweer()),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/fondoproyecto.jpg',
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 11, left: 12),
              width: 550,
              height: 720,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 6, left: 6),
                                    child: Boton_next(
                                      texto: 'Pendientes',
                                      onTap: () {
                                        _handleButtonTap(1);
                                      },
                                      isPressed: botonPresionado == 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: Boton_next(
                                      texto: 'Proceso',
                                      onTap: () {
                                        _handleButtonTap(2);
                                      },
                                      isPressed: botonPresionado == 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
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
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 10, right: 1, left: 0),
                              padding: EdgeInsets.only(top: 30),
                              width: double.infinity,
                              height: 530,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(128, 0, 0, 0),
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 5),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: proyectos.length,
                                  itemBuilder: (context, index) {
                                    final proyecto = proyectos[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (tipo[0] == 'M') {
                                            Get.to(DetalleProyectoPage(),
                                                arguments: proyecto);
                                          } else {
                                            Get.to(Ver_Tareas(),
                                                arguments: proyecto.idProyecto);
                                          }

                                          print(
                                              'Tapped on project: ${proyecto.nombre}');
                                        },
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          child: Row(children: [
                                            Progresos_Proyectos(
                                              porcentaje:
                                                  proyecto.porcentajeProyecto,
                                              color: Colors.blue,
                                              estado: proyecto.idEstado,
                                              nombre_proyecto: proyecto.nombre,
                                              descripcion: proyecto.descripcion,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(
                                                        left: 7, right: 2),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _showConfirmationDialog(
                                                            context,
                                                            proyecto
                                                                .idProyecto);
                                                      },
                                                      icon: Image.asset(
                                                        'assets/eliminar.gif',
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                label: Text(
                                  'Atras',
                                  style: TextStyle(color: kSecondaryColor),
                                ),
                                icon: Image.asset(
                                  'assets/flechaback.gif',
                                  width: 35,
                                  height: 35,
                                ),
                                onPressed: () {
                                  Get.to(Crear_proyectos());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextoGhost extends StatefulWidget {
  final Function(String) onTextChanged;
  final _TextoGhostState _state =
      _TextoGhostState(); // Guarda una referencia al estado

  TextoGhost({required this.onTextChanged});

  @override
  _TextoGhostState createState() => _state;

  // Esta función estática permite acceder al estado del widget desde cualquier parte
  static _TextoGhostState? of(BuildContext context) =>
      context.findAncestorStateOfType<_TextoGhostState>();
}

class _TextoGhostState extends State<TextoGhost> {
  bool _isSearchIconSelected = false;

  void _toggleVisibility() {
    setState(() {
      _isSearchIconSelected = !_isSearchIconSelected;
    });
  }

  // Esta función actualiza el texto y llama a onTextChanged
  void updateText(String text) {
    setState(() {
      widget.onTextChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          if (!_isSearchIconSelected)
            Container(
              child: GestureDetector(
                onTap: _toggleVisibility,
                child: SearchIcons(),
              ),
            ),
        ],
      ),
    );
  }
}

class SearchIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Botonbuscar(
      onTextChanged: (text) {
        // Comunica el texto ingresado al widget TextoGhost
        final _TextoGhostState? ghostState = TextoGhost.of(context);
        if (ghostState != null) {
          ghostState.updateText(text);
        } else {
          // Manejar el caso en que el estado de TextoGhost sea nulo
        }
      },
    );
  }
}
