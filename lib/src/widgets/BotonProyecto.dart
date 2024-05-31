import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Boton_next extends StatelessWidget {
  String texto;

  Boton_next({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: MaterialButton(
            shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Color.fromARGB(255, 61, 163, 247), width: 4),
                borderRadius: BorderRadius.circular(30)),
            height: 40,
            onPressed: () {},
            color: Colors.white,
            child: Row(
              children: [
                // Espacio entre el icono y el texto
                Text(
                  texto,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  'assets/cancelarpro.gif',
                  width: 25,
                  height: 25,
                ),
              ],
            )),
      ),
    );
  }
}
