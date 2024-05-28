import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manager_proyect/src/domain/controllers/EntregasController.dart';
import 'package:manager_proyect/src/domain/models/Entregas_model.dart';
import 'package:path/path.dart' as path;
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';

class SubirTareas extends StatefulWidget {
  @override
  _SubirTareasState createState() => _SubirTareasState();
}

class _SubirTareasState extends State<SubirTareas> {
  TextEditingController _controllerInforme = TextEditingController();
  TextEditingController _controllerPdfPath = TextEditingController();
  TareasModel tarea = Get.arguments as TareasModel;
  EntregasController gestionEntregas = EntregasController();

  String? pdfPath;

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kSecondaryColor,
        title: Text('Subir Tareas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${tarea.nombre}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40.0),
            Text(
              '${tarea.descripcion}',
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
              controller: _controllerInforme,
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
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  pdfPath = result.files.single.path;
                  print('Archivo PDF seleccionado: $pdfPath');

                  if (pdfPath != null) {
                    String fileName = path.basename(pdfPath!);
                    setState(() {
                      _controllerPdfPath.text = fileName;
                    });
                  }
                } else {
                  // El usuario no seleccionó ningún archivo
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Adjuntar Documento'),
            ),
            if (_controllerPdfPath.text.isNotEmpty)
              Text(
                _controllerPdfPath.text,
                style: TextStyle(fontSize: 16),
              ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () async {
                if (pdfPath != null) {
                 
                 registrarEntrega();
                  
                  // Aquí puedes implementar la lógica para enviar los datos a tu backend o hacer lo que necesites con el informe y el PDF
                } else {
                  // Mostrar un mensaje de error o manejar el caso cuando no se ha seleccionado un archivo PDF
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Entregar'),
            ),
          ],
        ),
      ),
    );
  }
  void registrarEntrega() async {

      File file = File(pdfPath!);
      List<int> bytes = await file.readAsBytes();

      String base64Data = base64Encode(bytes);

      EntregasModel entrega=EntregasModel(informe: _controllerInforme.text, urlPdfEntrega: base64Data, idTarea: tarea.idTarea);

      gestionEntregas.registrarEntregas(entrega).then((resultado) {
          print('El resultado de subir la tarea es: $resultado');
          Get.snackbar(
            'Desarrollo Cargado',
            'Exitosamente',
            backgroundColor: Colors.white,
            colorText: Colors.black,
          );
        }).catchError((error) {
          print('Ocurrió un error al registrar la tarea: $error');
        });


  }
}
