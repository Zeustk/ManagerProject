import 'package:flutter/material.dart';
import 'package:manager_proyect/src/widgets/Custom_progressbar.dart';

class Progresos_Proyectos extends StatelessWidget {
  final double porcentaje;
  final Color color;
  final int estado;
  final String nombre_proyecto;
  final String descripcion;

  const Progresos_Proyectos({
    super.key,
    required this.porcentaje,
    required this.color,
    required this.estado,
    required this.nombre_proyecto,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromARGB(255, 61, 163, 247), width: 2.5),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          height: 130,
          width: 300,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Progess_custom(
                    alto: 20, ancho: 280, progress: porcentaje, color: color),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                     estado == 01
                          ? 'Pendiente'
                          : estado == 02
                              ? 'En Proceso'
                              : estado== 03
                              ? 'Completado'  : 'Desconocido',
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    '${nombre_proyecto}',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    '$descripcion',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
