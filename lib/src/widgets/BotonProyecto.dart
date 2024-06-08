import 'package:flutter/material.dart';

class Boton_next extends StatelessWidget {
  final String texto;
  final VoidCallback onTap;
  final bool isPressed;

  Boton_next({
    super.key,
    required this.texto,
    required this.onTap,
    required this.isPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color.fromARGB(255, 61, 163, 247),
              width: 4,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          height: 40,
          onPressed: onTap,
          color: isPressed ? Colors.blue : Colors.white,
          child: Row(
            children: [
              Text(
                texto,
                style: TextStyle(
                  color: isPressed ? Colors.white : Colors.blue,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 2),
              Image.asset(
                'assets/cancelarpro.gif',
                width: 25,
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
