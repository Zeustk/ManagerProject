import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';

import 'package:manager_proyect/src/widgets/PaddingMistareas.dart';

TareasController gestiontareas = TareasController();

class Container_Mistareas extends StatelessWidget {
  final int estado;
  final String nombreTarea;
  final String descripcion;
  final Color? color;
  final int idTareas;

  const Container_Mistareas({
    super.key,
    required this.estado,
    this.color,
    required this.nombreTarea,
    required this.descripcion,
    required this.idTareas,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: 340,
        height: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border:
                Border.all(color: Color.fromARGB(255, 61, 163, 247), width: 2)),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: Padding_Mistareas(
                      color: color,
                      texto: estado == 01
                          ? 'Pendiente'
                          : estado == 02
                              ? 'En Proceso'
                              : estado == 03
                                  ? 'Completado'
                                  : 'Desconocido',
                      valor_move: 5),
                ),
                Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 80),
                  child: InkWell(
                    child: Image.asset('assets/borrar.gif', width: 45),
                    onTap: () {
                      _showConfirmationDialog(context, idTareas);
                    },
                  ),
                )
              ],
            ),
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

  void _showConfirmationDialog(BuildContext context, int idTareas) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kSecondaryColor,
          title: Text('Confirmar Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar  la atarea',
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                _eliminarTarea(context, idTareas);
              },
            ),
          ],
        );
      },
    );
  }

  void _eliminarTarea(BuildContext context, int idTareas) {
    gestiontareas.eliminarTareas(idTareas);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contenido eliminado')),
    );
  }
}
