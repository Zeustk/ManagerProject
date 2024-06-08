import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/domain/controllers/DetallesController.dart';
import 'package:manager_proyect/src/domain/controllers/Perfiles_Controller.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/DetalleProyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Perfiles_model.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/verProyectos.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/AdicionarUsuarios.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/FondoApp.dart';

import '../../../widgets/Drawer.dart';

class Crear_proyectos extends StatefulWidget {
  @override
  State<Crear_proyectos> createState() => _Crear_proyectosState();
}

class _Crear_proyectosState extends State<Crear_proyectos> {
  /* FocusNode _focusNode = FocusNode(); */
//

  ProyectoController gestionProyectos = ProyectoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: FondoAppImage(),
      ),
      drawer: SafeArea(
        child: Draweer(),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondoproyecto.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, right: 11, left: 12),
                padding: EdgeInsets.only(top: 30),
                width: double.infinity,
                height: 720,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 5),
                    color: Color.fromARGB(128, 0, 0, 0)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  width: 500,
                  height: 650,
                  decoration: BoxDecoration(),
                  child: Labels()),
            ],
          ),
        ),
      ]),
    );
  }
}

//Entradas de texto

class Labels extends StatefulWidget {
  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  TextEditingController _controllerFechaInicio = TextEditingController();
  TextEditingController __controllerFechaFinalizacion = TextEditingController();
  TextEditingController __controllerNombre = TextEditingController();
  TextEditingController __controllerDescripcion = TextEditingController();
  List<UsuarioModel> usuariosSeleccionados = [];

  ProyectoController gestionProyectos = ProyectoController();
  UsuariosController gestionUsuarios = UsuariosController();
  DetallesController gestionProyectoUsuarios = DetallesController();
  AuthController gestionAuth = AuthController();
  PerfilesController gestionPerfiles = PerfilesController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: 450,
                height: 60,
                child: TextField(
                  controller: __controllerNombre,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/contrato.gif',
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
                      'assets/calendario.gif',
                      width: 10,
                      height: 10,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40), // Bordes redondeados
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(40), // Bordes redondeados
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
                controller: __controllerFechaFinalizacion,
                decoration: InputDecoration(
                  labelText: 'Fecha Fin',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/calendario21.gif',
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
                controller: __controllerDescripcion,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  filled: true,
                  fillColor: Colors.white,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/buscare.gif',
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
            SizedBox(height: 15),
            SizedBox(
                child: Divider(color: Colors.white, height: 50), width: 350),
            Container(
              width: 230,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  usuariosSeleccionados = (await Get.to<List<UsuarioModel>?>(
                          AdicionarUsuariosPage())) ??
                      [];
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Adicionar Integrantes',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/buscar.gif',
                        width: 35,
                        height: 35,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            CupertinoButton(
              padding: EdgeInsets.only(left: 40, right: 10, bottom: 10),
              onPressed: () {
                registrarProyecto();
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
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      width: 40,
                      'assets/carpeta.gif',
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void registrarProyecto() async {
    UsuarioModel usuarioActual = await gestionAuth.obtenerDatosDeStorage();

    PerfilesModel perfilActual =
        await gestionPerfiles.getPerfilPorId(usuarioActual);

    ProyectoModel proyecto = ProyectoModel(
      fechaFinalizacion: DateTime.parse(__controllerFechaFinalizacion.text),
      fechaInicio: DateTime.parse(_controllerFechaInicio.text),
      liderProyecto: perfilActual.nombreCompleto,
      nombre: __controllerNombre.text.trim().toUpperCase(),
      descripcion: __controllerDescripcion.text.trim(),
      porcentajeProyecto: 0.0,
    );

    if (usuariosSeleccionados.isEmpty) {
      return;
    }

    gestionProyectos.registrarProyecto(proyecto).then((resultado) {
      print('El resultado de registrar el proyecto es: $resultado');
      Get.snackbar(
        '',
        '$resultado',
        backgroundColor: Colors.white,
        colorText: Colors.black,
        onTap: (snack) {
          Get.to(Ver_Proyectos(), arguments: 'Mis Proyectos');
        },
      );
    }).catchError((error) {
      print('Ocurrió un error al registrar el proyecto: $error');
      return;
    });

    registrarProyectoDetalleUsuarios(usuarioActual);
  }

  void registrarProyectoDetalleUsuarios(UsuarioModel usuarioActual) {
    usuariosSeleccionados.add(usuarioActual);

    for (var usuario in usuariosSeleccionados) {
      DetallesModel detallesProyectoUsuario = DetallesModel(
          idDetalle: 0,
          idUsuario: usuario.idUsuario,
          idLiderProyecto: usuarioActual.idUsuario);

      gestionProyectoUsuarios
          .registrarDetalles(detallesProyectoUsuario)
          .then((resultado) {
        print('El resultado de registrar los integrantes es: $resultado');
      }).catchError((error) {
        print('Ocurrió un error al registrar los integrantes: $error');
        return;
      });
    }
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

  Future<void> _seleccionFecha2(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
      firstDate: DateTime(1000),
      lastDate: DateTime(3000),
      context: context,
    );

    if (_fecha != null) {
      setState(() {
        __controllerFechaFinalizacion.text = _fecha.toString().split(" ")[0];
      });
    }
  }
}
