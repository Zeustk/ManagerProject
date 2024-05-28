import 'package:flutter/material.dart';

class FondoAppImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/fondoproyecto.jpg'), // Ruta de la imagen
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent, // Hace el AppBar transparente
          elevation: 0,
          title: Text(
            'Crear Proyecto',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}