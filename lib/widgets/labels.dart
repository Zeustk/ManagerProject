import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/Page/LoginScreen.dart';
import 'package:login/constante/constantes.dart';
import 'package:login/models/Proyectos.dart';

class Labels extends StatefulWidget {
  @override
  State<Labels> createState() => _LabelsState();
}

class _LabelsState extends State<Labels> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
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
                Get.snackbar(
                  'Proyecto Creado',
                  'Proyecto Creado Satisfactoriamente',
                  backgroundColor: Colors.white,
                  colorText: Colors.black,
                  onTap: (snack) {
                    Get.to(
                      () => Proyectos(),
                    );
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
