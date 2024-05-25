import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/subirTarea.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Para abrir URLs en el navegador
import 'package:file_picker/file_picker.dart';

import '../../../constante/constantes.dart';

class DetalleTarea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TareasModel tarea = Get.arguments as TareasModel;

    Future<void> _downloadPDF(String pdfBase64Content) async {
      try {
        // Obtener la ruta del directorio de Descargas
        Directory downloadsDirectory = Directory('/storage/emulated/0/Download');

        if (downloadsDirectory.existsSync()) {
          // Crear el archivo PDF con un nombre único
          String uniqueFilename = '${DateTime.now().millisecondsSinceEpoch}_tarea.pdf';
          String filePath = '${downloadsDirectory.path}/$uniqueFilename';

          // Decodificar el contenido base64
          List<int> pdfBytes = base64Decode(pdfBase64Content);

          // Guardar el archivo en la ubicación especificada
          File file = File(filePath);
          await file.writeAsBytes(pdfBytes);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDF descargado en Descargas')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No se pudo acceder al directorio de Descargas')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar el PDF: $e')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        title: Text('${tarea.nombre}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${tarea.descripcion}',
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
            InkWell(
              onTap: () {
                _downloadPDF(tarea.urlPdf);
              },
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(
                  Icons.file_download,
                  size: 60.0,
                  color: Colors.grey[600],
                ),
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
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Get.to(SubirTareas(), arguments: tarea);
              },
              child: Text('Subir Tarea'),
            ),
          ],
        ),
      ),
    );
  }
}