import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/subirTarea.dart';

class DetalleTarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de Tarea'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Descripción De la Tarea',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Documento',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                Icons.file_present,
                size: 60.0,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Estado: No iniciado',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'En proceso',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  Checkbox(
                    value: false,
                    onChanged: (newValue) {
                      // Aquí puedes agregar la lógica para cambiar el estado del checkbox
                    },
                  ),
                  SizedBox(width: 10.0),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Get.to(SubirTareas());
              },
              child: Text('Subir Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}
