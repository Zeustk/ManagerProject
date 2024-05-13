import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';

ProyectoController gestionProyectos = ProyectoController();
UsuariosController gestionUsuarios = UsuariosController();
AuthController gestionAuth = AuthController();

class Crear_Tareas extends StatefulWidget {
  @override
  State<Crear_Tareas> createState() => _Crear_tareasState();
}

class _Crear_tareasState extends State<Crear_Tareas> {
  List<String> proyectos = [];
  List<String> usuarios = [];

  @override
  void initState() {
    super.initState();

    gestionAuth.obtenerDatosDeStorage().then((value) {
      gestionProyectos
          .consultarProyectos(value.idUsuario)
          .then((listaProyectos) {
        setState(() {
          proyectos =
              listaProyectos.map((proyecto) => proyecto.nombre).toList();
        });
      });
    });



    gestionUsuarios.consultarUsuario().then((listaUsuarios) {
      setState(() {
        usuarios = listaUsuarios.map((Usuario) => Usuario.email).toList();
      });
    });
  }

  /* FocusNode _focusNode = FocusNode(); */
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('Crear Tarea', style: TextStyle(color: Colors.white)),
      ),
      drawer: SafeArea(
        child: Draweer(),
      ),
      body: SingleChildScrollView(
        child: LabelsTareas(
          proyectos: proyectos,
          usuarios: usuarios,
        ),
      ),
    );
  }
}

class LabelsTareas extends StatefulWidget {
  final List<String> proyectos;
  final List<String> usuarios;

  LabelsTareas({required this.proyectos, required this.usuarios});

  @override
  State<LabelsTareas> createState() => _LabelsTareasState();
}

class _LabelsTareasState extends State<LabelsTareas> {
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerFechaInicio = TextEditingController();
  TextEditingController _controllerFechaFinalizacion = TextEditingController();
  TextStyle selecionarColor = TextStyle(color: Colors.black);
  TextEditingController _controllerDescripcion = TextEditingController();
  TextEditingController _controllerIntegrante = TextEditingController();
  TextEditingController _controllerNombreProyecto = TextEditingController();
  TareasController gestionTareas = TareasController();

  String? _selectedProject;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _controllerNombre,
                decoration: InputDecoration(
                    labelText: 'Nombre',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: kSecondaryColor,
                    ),
                    labelStyle: TextStyle(color: Colors.blue),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _controllerFechaInicio,
                decoration: InputDecoration(
                    labelText: 'Fecha De Inicio',
                    filled: true,
                    fillColor: Colors.white,
                    labelStyle: TextStyle(color: Colors.blue),
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: kSecondaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                readOnly: true,
                onTap: () {
                  _seleccionFecha(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _controllerFechaFinalizacion,
                decoration: InputDecoration(
                    labelText: 'Fecha de Finalización',
                    filled: true,
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: kSecondaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                readOnly: true,
                onTap: () {
                  _seleccionFecha2(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  controller: _controllerDescripcion,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    filled: true,
                    labelStyle: TextStyle(color: Colors.blue),
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.comment,
                      color: kSecondaryColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return widget.proyectos.take(3).toList();
                  } else {
                    return widget.proyectos.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  }
                },
                onSelected: (String selectedProject) {
                  setState(() {
                    _selectedProject = selectedProject;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  _controllerNombreProyecto = textEditingController;
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Nombre Del Proyecto',
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  final double listViewHeight =
                      options.length <= 3 ? options.length * 56.0 : 200.0;
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      color: Colors.white70,
                      elevation: 4.0,
                      child: SizedBox(
                        width: 200,
                        height: listViewHeight,
                        child: ListView.builder(
                          padding: EdgeInsets.all(10.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option,
                                    style: TextStyle(color: Colors.blue)),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            CupertinoButton(
              onPressed: () {},
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subir Documento',
                    style: TextStyle(color: Colors.blue),
                  ),
                  Icon(
                    Icons.file_upload,
                    color: Colors.blue,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.white),
            Text(
              'Integrantes : ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: AutofillHints.addressCity),
            ),
            Stack(
              children: [],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return []; // Devuelve una lista vacía cuando el campo de búsqueda está vacío
                  } else {
                    // Filtra las opciones basadas en lo que el usuario está escribiendo en el campo de búsqueda
                    return widget.usuarios
                        .where((String option) => option
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase()))
                        .take(1)
                        .toList(); // Toma solo el primer registro después de filtrar
                  }
                },
                onSelected: (String selectedOption) {
                  // Maneja la selección de una opción y actualiza el campo de texto con la opción seleccionada
                  setState(() {
                    _controllerIntegrante.text = selectedOption;
                  });
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      labelText: 'Buscar...',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: kSecondaryColor,
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  // Construye la vista de las opciones de autocompletado
                  final double listViewHeight =
                      options.length <= 3 ? options.length * 56.0 : 200.0;
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: SizedBox(
                        height: listViewHeight,
                        child: ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: CupertinoButton(
                onPressed: () {
                  registrarTarea();
                },
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                child: const Text(
                  'Crear',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registrarTarea() {
    verificarUsuario().then((idUsuario) {
      if (idUsuario == -1) {
        print('Usuario no encontrado');
        return;
      }

      verificarProyecto().then((idProyecto) {
        if (idProyecto == -1) {
          print('Proyecto no encontrado');
          return;
        }

        // Aquí va el código para registrar la tarea utilizando los IDs obtenidos
        TareasModel tarea = TareasModel(
          nombre: _controllerNombre.text,
          fechaInicio: DateTime.parse(_controllerFechaInicio.text),
          fechaFinalizacion: DateTime.parse(_controllerFechaFinalizacion.text),
          descripcion: _controllerDescripcion.text,
          porcentajeTarea: 6.7,
          idProyecto: idProyecto,
          idUsuario: idUsuario,
        );

        gestionTareas.registrarTareas(tarea).then((resultado) {
          print('El resultado de registrar la tarea es: $resultado');
        }).catchError((error) {
          print('Ocurrió un error al registrar la tarea: $error');
        });
      });
    });
  }

  Future<void> _seleccionFecha(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
      context: context,
    );

    if (_fecha != null) {
      setState(() {
        _controllerFechaInicio.text = _fecha.toString().split(" ")[0];
      });
    }
  }

  Future<int> verificarProyecto() async {
    print(_controllerNombreProyecto.text);

    UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();

    return gestionProyectos
        .consultarProyectos(usuarioActual.idUsuario)
        .then((listaProyectos) {
      for (var proyecto in listaProyectos) {
        if (proyecto.nombre == _controllerNombreProyecto.text) {
          return proyecto
              .idProyecto; // Devolver el ID del proyecto si se encuentra
        }
      }
      return -1; // Devolver -1 si el proyecto no se encuentra
    });
  }

  Future<int> verificarUsuario() {
    print(_controllerNombreProyecto.text);

    return gestionUsuarios.consultarUsuario().then((listaUsuarios) {
      for (var usuario in listaUsuarios) {
        if (usuario.email == _controllerIntegrante.text) {
          print('hola');
          return usuario
              .idUsuario; // Devolver el ID del proyecto si se encuentra
        }
      }
      return -1; // Devolver -1 si el proyecto no se encuentra
    });
  }

  Future<void> _seleccionFecha2(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
      context: context,
    );

    if (_fecha != null) {
      setState(() {
        _controllerFechaFinalizacion.text = _fecha.toString().split(" ")[0];
      });
    }
  }
}
