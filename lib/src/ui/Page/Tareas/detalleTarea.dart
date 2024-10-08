import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/controllers/TareasController.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/subirTarea.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../constante/constantes.dart';

class DetalleTarea extends StatefulWidget {
  @override
  State<DetalleTarea> createState() => _DetalleTareaState();
}

class _DetalleTareaState extends State<DetalleTarea> {
  TareasController gestionTareas = Get.find();
  ProyectoController gestionProyectos = ProyectoController();


  final datos = Get.arguments;
  TareasModel tarea = TareasModel(
      nombre: "asdasd",
      fechaInicio: DateTime.now(),
      fechaFinalizacion: DateTime.now(),
      descripcion: "dsdas",
      porcentajeTarea: 30.0,
      idProyecto: 1,
      idUsuario: 1,
      urlPdf: "dsad");
  bool valorCheckbox = false;
  bool esLiderProyecto = false;
  int idUsuarioActual=-1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarDatosIniciales();
    estadoInicial();
  }

  void cargarDatosIniciales() async {
   


    setState(() {
      tarea = datos["Tarea"];
      esLiderProyecto = datos["EsLiderProyecto"];
      idUsuarioActual=datos["Id_UsuarioActual"];  
      
   
    });
  }

  void estadoInicial() {
    print(tarea.idEstado);

    switch (tarea.idEstado) {
      case 1:
        valorCheckbox = false;
        return;
      case 2:
        valorCheckbox = true;
        return;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _downloadPDF(String pdfBase64Content) async {
      try {
        if (await Permission.storage.request().isGranted) {
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
                  content:
                      Text('No se pudo acceder al directorio de Descargas')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al descargar el PDF: $e')),
        );
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
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
                border: Border.all(color: Colors.white, width: 5),
                color: Color.fromARGB(128, 0, 0, 0)),
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
                              value: valorCheckbox,
                              onChanged: (newValue) {
                                valorCheckbox = newValue!;

                                cambiarEstado(valorCheckbox);

                                setState(() {});
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
                            Get.to(SubirTareas(), arguments: {
                              "Tarea": tarea,
                              "esLiderProyecto": esLiderProyecto,
                              "Id_LiderProyecto":datos["Id_LiderProyecto"],
                              "Id_UsuarioActual":datos["Id_UsuarioActual"],

                            });
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

  void cambiarEstado(bool estaEnCurso) {
    if (estaEnCurso) {
      gestionTareas.actualizarEstado(
          tarea.idTarea, 02); // 02 Es el estado en curso;
    } else {
      gestionTareas.actualizarEstado(
          tarea.idTarea, 01); // 02 Es el estado en curso;
    }
    gestionProyectos.cambiarEstadoProyectosMemoria();
  }
}
