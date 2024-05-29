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
        Directory downloadsDirectory =
            Directory('/storage/emulated/0/Download');

        if (downloadsDirectory.existsSync()) {
          // Crear el archivo PDF con un nombre único
          String uniqueFilename =
              '${DateTime.now().millisecondsSinceEpoch}_tarea.pdf';
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
            SnackBar(
                content: Text('No se pudo acceder al directorio de Descargas')),
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
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text('${tarea.nombre}', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondoproyecto.jpg',
            fit: BoxFit.fill,
          ),
        ),
        SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 11, left: 12),
            width: 550,
            height: 580,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 5)),
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${tarea.descripcion}',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Documento',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(height: 10.0),
                      InkWell(
                        onTap: () {
                          _downloadPDF(tarea.urlPdf);
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset('assets/descargardc.gif'),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        'Estado: No iniciado',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'En proceso',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
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
                      SizedBox(height: 10.0),
                      SizedBox(
                        width: 170,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor: MaterialStateProperty.all<Color>(
                                kSecondaryColor),
                          ),
                          onPressed: () {
                            Get.to(SubirTareas(), arguments: tarea);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Subir Tarea',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                  width:
                                      8), // Espacio entre el texto y la imagen
                              Image.asset(
                                'assets/subirtarea.gif',
                                width: 32,
                                height: 32,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
