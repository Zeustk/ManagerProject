import 'package:flutter/material.dart';

class SubirTareas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Tareas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Nombre de la tarea',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              'Descripción De la Tarea',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              'Informe',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
           TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Informe de la tarea',
                border: OutlineInputBorder(),
                
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
            // Aquí puedes agregar el widget para seleccionar un documento
            ElevatedButton(
              onPressed: () {
                // Aquí va la lógica para subir el documento
              },
              child: Text('Adjuntar Documento'),
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                // Aquí va la lógica para entregar la tarea
              },
              child: Text('Entregar'),
            ),
          ],
        ),
      ),
    );
  }
}
