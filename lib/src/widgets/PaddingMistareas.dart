import 'package:flutter/material.dart';

class Padding_Mistareas extends StatelessWidget {
  final String texto;
  final Color? color;
  final double valor_move;

  const Padding_Mistareas(
      {super.key,
      required this.texto,
      required this.color,
      required this.valor_move});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: valor_move),
      child: Text(
        texto,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic),
      ),
    );
  }
}
