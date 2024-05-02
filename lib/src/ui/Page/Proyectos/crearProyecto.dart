import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/verProyectos.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';

import '../../../widgets/Drawer.dart';

class Crear_proyectos extends StatefulWidget {
  @override
  State<Crear_proyectos> createState() => _Crear_proyectosState();
}

class _Crear_proyectosState extends State<Crear_proyectos> {
  /* FocusNode _focusNode = FocusNode(); */
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      backgroundColor: kSecondaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('Crear Proyecto', style: TextStyle(color: Colors.white)),
      ),
      drawer: SafeArea(
        child: Draweer(),
      ),
      body: SingleChildScrollView(
        child: Labels(),
      ),
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

  ProyectoController gestionProyectos = ProyectoController();

  TextStyle selecionarColor = TextStyle(color: Colors.black);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                /*  onSubmitted: (value) {
                    _focusNode.requestFocus();
                  }, */
                /*  focusNode: _focusNode,
                  controller: _controller,
                  autofocus: true, */
                style: TextStyle(color: Colors.black),
                controller: __controllerNombre,
                decoration: InputDecoration(
                    labelText: 'Nombre',
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: kSecondaryColor,
                    ),
                    labelStyle: TextStyle(color: Colors.black),
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
                    labelStyle: selecionarColor,
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
                controller: __controllerFechaFinalizacion,
                decoration: InputDecoration(
                    labelText: 'Fecha Fin',
                    filled: true,
                    labelStyle: selecionarColor,
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
            SizedBox(height: 25),
            Divider(color: Colors.grey),
            Text(
              'Integrantes : ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: AutofillHints.addressCity),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Buscar...',
                      labelText: 'Buscar...',
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.search,
                        color: kSecondaryColor,
                      ),
                      labelStyle: TextStyle(color: Colors.black),
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ))),
            ),
            CupertinoButton(
              onPressed: () {
                ProyectoModel proyecto = ProyectoModel(
                    fechaFinalizacion:
                        DateTime.parse(__controllerFechaFinalizacion.text),
                    fechaInicio: DateTime.parse(_controllerFechaInicio.text),
                    liderProyecto: "JESUS",
                    nombre: __controllerNombre.text);
                gestionProyectos.registrarProyecto(proyecto).then((resultado) {
                  print('El resultado de registrar el proyecto es: $resultado');
                }).catchError((error) {
                  print('Ocurrió un error al registrar el proyecto: $error');
                });
                Get.snackbar(
                  'Proyecto Creado',
                  'Proyecto Creado Exitosamente',
                  backgroundColor: Colors.white,
                  colorText: Colors.black,
                  onTap: (snack) {
                    Get.to(Ver_Proyectos(), arguments: 'Mis Proyectos');
                  },
                );
              },
              alignment: Alignment.bottomCenter,
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              child: const Text('Crear'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _seleccionFecha(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
        firstDate: DateTime(1000), lastDate: DateTime(3000), context: context);

    if (_fecha != null) {
      setState(() {
        _controllerFechaInicio.text = _fecha.toString().split(" ")[0];
      });
    }
  }

  Future<void> _seleccionFecha2(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
        firstDate: DateTime(1000), lastDate: DateTime(3000), context: context);

    if (_fecha != null) {
      setState(() {
        __controllerFechaFinalizacion.text = _fecha.toString().split(" ")[0];
      });
    }
  }
}
