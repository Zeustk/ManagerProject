import 'package:flutter/material.dart';

class Progess_custom extends StatelessWidget {
  final double alto;
  final double ancho;
  final double progress;
  final Color color;
  const Progess_custom(
      {super.key,
      required this.alto,
      required this.ancho,
      required this.progress,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: ancho,
        height: alto,
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              width: ancho * progress,
              height: alto,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "${(progress * 100).toInt()}%",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
