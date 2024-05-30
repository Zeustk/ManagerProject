import 'package:flutter/material.dart';

class FondoAppImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(),
        ),
        AppBar(
            backgroundColor: Color.fromARGB(164, 83, 80, 80),
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 52),
              child: Text(
                'Crear Proyecto',
                style: TextStyle(color: Colors.white),
              ),
            )),
      ],
    );
  }
}
