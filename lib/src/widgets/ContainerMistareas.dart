import 'package:flutter/material.dart';
import 'package:manager_proyect/src/widgets/PaddingMistareas.dart';

class Container_Mistareas extends StatelessWidget {
  final String texto;
  final String nombreTarea;
  final String descripcion;
  final Color? color;

  const Container_Mistareas(
      {super.key,
      required this.texto,
      this.color,
      required this.nombreTarea,
      required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 340,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding_Mistareas(color: color, texto: texto, valor_move: 5),
            Divider(
              color: Color.fromRGBO(0, 0, 0, 0.2),
            ),
            Padding_Mistareas(
                color: Colors.black, texto: nombreTarea, valor_move: 0.0),
            Divider(
              color: Color.fromRGBO(0, 0, 0, 0.2),
            ),
            Padding_Mistareas(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                texto: descripcion,
                valor_move: 0.0),
          ],
        ),
      )
    ]);
  }
}
