import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';

import 'package:flutter/services.dart';

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
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
        title: Text('Crear Tarea',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      drawer: SafeArea(
        child: Draweer(),
      ),
      body: SingleChildScrollView(
        child: Stack(children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoproyecto.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 10, right: 10),
            width: 410,
            height: 660,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: LabelsTareas(
              proyectos: proyectos,
              usuarios: usuarios,
            ),
          ),
        ]),
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
  TextEditingController _controllerPdfPath = TextEditingController();
  TareasController gestionTareas = TareasController();

  String? pdfPath; //Va a contener el pdf

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
              child: Container(
                width: 450,
                height: 60,
                child: TextField(
                  controller: _controllerNombre,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/tarea.gif',
                        width: 10,
                        height: 10,
                      ),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color: Colors
                            .blue, // Color del borde cuando está deshabilitado
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide(
                        color:
                            Colors.blue, // Color del borde cuando está enfocado
                      ),
                    ),
                  ),
                ),
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
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/calendario3.gif',
                      width: 10,
                      height: 10,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
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
                  labelText: 'Fecha Fin',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/proximo.gif',
                      width: 10,
                      height: 10,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _seleccionFecha2(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _controllerDescripcion,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/investigacion.gif',
                      width: 10,
                      height: 10,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 30, bottom: 40),
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return widget.proyectos.take(3).toList();
                  } else {
                    return widget.proyectos.where((String option) {
                      return option
                          .contains(textEditingValue.text.trim().toUpperCase());
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
                      labelText: 'Nombre del Proyecto',
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/documento.gif',
                          width: 10,
                          height: 10,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
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
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  pdfPath = result.files.single.path;
                  // Aquí puedes hacer lo que necesites con el archivo PDF seleccionado
                  // Por ejemplo, puedes mostrar el nombre del archivo o guardar la ruta en una variable para su posterior uso
                  print('Archivo PDF seleccionado: $pdfPath');

                  if (pdfPath != null) {
                    String fileName = path.basename(pdfPath!);
                    setState(() {
                      _controllerPdfPath.text = fileName;
                    });
                  }
                } else {
                  // El usuario no seleccionó ningún archivo
                }
              },
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Subir Documento',
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.asset(
                    'assets/subir.gif',
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            ),
            if (_controllerPdfPath.text.isNotEmpty)
              Text(
                _controllerPdfPath.text,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 20),
            Divider(color: Colors.white),
            Container(
              padding: EdgeInsets.only(left: 7, bottom: 7),
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Integrantes',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: AutofillHints.addressCity),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20, bottom: 40),
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
                    style: TextStyle(color: Colors.black),
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: 'Buscar',
                      labelText: 'Buscar',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/consultoria-de-gestion.gif',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      labelStyle: TextStyle(color: Colors.blue),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: Colors.blue),
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
                      color: Colors.white,
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
                                title: Text(option,
                                    style: TextStyle(color: Colors.black)),
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
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 130),
              child: CupertinoButton(
                padding: EdgeInsets.only(left: 40, right: 10, bottom: 10),
                onPressed: () {
                  registrarTarea();
                },
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  width: 100,
                  height: 20,
                  child: Row(
                    children: [
                      Text(
                        'Crear',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Image.asset(
                        width: 50,
                        'assets/planificacion.gif',
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registrarTarea() {
    verificarUsuario().then((idUsuario) async {
      if (idUsuario == -1) {
        print('Usuario no encontrado');
        return;
      }

      if (pdfPath == null) {
        print('No se ha seleccionado ningún archivo PDF');
        return;
      }

      File file = File(pdfPath!);
      List<int> bytes = await file.readAsBytes();

      String base64Data = base64Encode(bytes);

      verificarProyecto().then((idProyecto) {
        if (idProyecto == -1) {
          print('Proyecto no encontrado');
          return;
        }

        TareasModel tarea = TareasModel(
          nombre: _controllerNombre.text,
          fechaInicio: DateTime.parse(_controllerFechaInicio.text),
          fechaFinalizacion: DateTime.parse(_controllerFechaFinalizacion.text),
          descripcion: _controllerDescripcion.text,
          porcentajeTarea: 6.7,
          idProyecto: idProyecto,
          idUsuario: idUsuario,
          urlPdf: base64Data,
        );

        gestionTareas.registrarTareas(tarea).then((resultado) {
          print('El resultado de registrar la tarea es: $resultado');
          Get.snackbar(
            'Tarea Creada',
            'Tarea Creada Exitosamente',
            backgroundColor: Colors.white,
            colorText: Colors.blue,
          );
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
        if (proyecto.nombre.trim().toUpperCase() ==
            _controllerNombreProyecto.text.trim().toUpperCase()) {
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
          return usuario.idUsuario;
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
