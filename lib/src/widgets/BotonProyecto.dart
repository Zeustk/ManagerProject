import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Boton_next extends StatelessWidget {
  String texto;

  Boton_next({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            height: 10,
            onPressed: () {},
            color: Colors.white,
            child: Row(
              children: [
                // Espacio entre el icono y el texto
                Text(
                  texto,
                  style: const TextStyle(
                    color: Colors
                        .blue, // Cambia el color del texto según tus preferencias
                    fontSize:
                        16, // Ajusta el tamaño del texto según tus necesidades
                    // Puedes agregar más propiedades para personalizar el estilo del texto
                  ),
                ),
                SizedBox(width: 5),
                const Icon(
                  Icons.cancel,
                  color: Colors.blue,
                ),
              ],
            )),
      ),
    );
  }
}
