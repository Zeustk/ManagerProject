import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';



class Crear_Tareas extends StatefulWidget {
  @override
  State<Crear_Tareas> createState() => _Crear_tareasState();
}

class _Crear_tareasState extends State<Crear_Tareas> {
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
        child: LabelsTareas(),
      ),
    );
  }
}

class LabelsTareas extends StatefulWidget {
  @override
  State<LabelsTareas> createState() => _LabelsTareasState();
}

class _LabelsTareasState extends State<LabelsTareas> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextStyle selecionarColor = TextStyle(color: Colors.black);
  TextEditingController _controllerDescripcion = TextEditingController();
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
                controller: _controller,
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
                controller: _controller2,
                decoration: InputDecoration(
                    labelText: 'Fecha de Finalización',
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
                    labelStyle: selecionarColor,
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
              onPressed: () {},
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
        _controller.text = _fecha.toString().split(" ")[0];
      });
    }
  }

  Future<void> _seleccionFecha2(BuildContext context) async {
    DateTime? _fecha = await showDatePicker(
        firstDate: DateTime(1000), lastDate: DateTime(3000), context: context);

    if (_fecha != null) {
      setState(() {
        _controller2.text = _fecha.toString().split(" ")[0];
      });
    }
  }
}
