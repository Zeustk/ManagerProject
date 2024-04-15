import 'package:flutter/material.dart';
import 'package:manager_proyect/src/widgets/Custom_progressbar.dart';


class Progresos_Proyectos extends StatelessWidget {
  final double porcentaje;
  final Color color;
  final String texto;
  const Progresos_Proyectos(
      {super.key,
      required this.porcentaje,
      required this.color,
      required this.texto});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: 100,
          width: 300,
          child: Column(
            children: [
              Progess_custom(alto: 20, ancho: 300, progress: porcentaje,color:color ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  texto,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 140),
                child: Text(
                  'Nombre del Proyecto',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 200),
                child: Text(
                  'Descripción',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
