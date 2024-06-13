import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manager_proyect/src/domain/controllers/EntregasController.dart';
import 'package:manager_proyect/src/domain/controllers/ProyectoController.dart';
import 'package:manager_proyect/src/domain/models/Entregas_model.dart';
import 'package:path/path.dart' as path;
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:permission_handler/permission_handler.dart';

class SubirTareas extends StatefulWidget {
  @override
  _SubirTareasState createState() => _SubirTareasState();
}

class _SubirTareasState extends State<SubirTareas> {
  TextEditingController _controllerInforme = TextEditingController();
  TextEditingController _controllerPdfPath = TextEditingController();
  final datos = Get.arguments;
  EntregasController gestionEntregas = EntregasController();
  ProyectoController gestionProyectos = ProyectoController();

  String? pdfPath;
  bool tareaEntregada =
      false; // Variable que representa si la tarea ha sido entregada o no
  bool esLiderProyecto = false;
  bool esLiderTarea = false;

  EntregasModel entrega = EntregasModel.empty();

  TareasModel tarea = TareasModel(
      nombre: "asdasd",
      fechaInicio: DateTime.now(),
      fechaFinalizacion: DateTime.now(),
      descripcion: "dsdas",
      porcentajeTarea: 30.0,
      idProyecto: 1,
      idUsuario: 1,
      urlPdf: "dsad");

  @override
  void initState() {
    super.initState();
    cargarDatosIniciales();
    tareaFueEntregada();
    print(entrega.urlPdfEntrega);
    print(entrega.idEntrega);
    print(entrega.informe);
  }

  void cargarDatosIniciales() {
    setState(() {
      tarea = datos["Tarea"];
      esLiderProyecto = datos["esLiderProyecto"];

      if (datos["Id_UsuarioActual"] == tarea.idUsuario) {
        esLiderTarea = true;
      }
    });
  }

  Future<void> tareaFueEntregada() async {
    EntregasModel entregaInfo =
        await gestionEntregas.consultarEntrega(tarea.idTarea);

    print('Hola entrega');
    print(entregaInfo);

    if (mounted) {
      setState(() {
        if (entregaInfo.idEntrega != -1) {
          tareaEntregada = true;
        }
        entrega = entregaInfo;
      });
    }
  }

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
                content: Text('No se pudo acceder al directorio de Descargas')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
        title: Text('Subir Tareas'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/fondoproyecto.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, right: 11, left: 12),
            width: 550,
            height: 620,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 5),
              color: Color.fromARGB(128, 0, 0, 0),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5, left: 7),
                        width: 230,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5),
                        ),
                        child: SizedBox(
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/Dtarea.png',
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '${tarea.nombre}',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        width: 230,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white,
                              style: BorderStyle.solid,
                              width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Image.asset('assets/creartarea.png'),
                            Text(
                              '${tarea.descripcion}',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.0),
                      if (!tareaEntregada && esLiderTarea) ...[
                        Container(
                          padding: EdgeInsets.only(left: 7),
                          width: 80,
                          height: 32,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Informe',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextField(
                          controller: _controllerInforme,
                          maxLines: 5,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Informe de la tarea',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          'Documento',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
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
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.blue, width: 3)),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: SizedBox(
                            width: 175,
                            child: Row(
                              children: [
                                Text('Adjuntar Documento',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                SizedBox(width: 7),
                                Image.asset(
                                  'assets/adjunto.gif',
                                  width: 35,
                                  height: 35,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        if (_controllerPdfPath.text.isNotEmpty)
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: 260,
                            height: 50,
                            child: Row(
                              children: [
                                Text(
                                  _controllerPdfPath.text,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  'assets/archivo.png',
                                  width: 30,
                                )
                              ],
                            ),
                          ),
                        SizedBox(height: 30.0),
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
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: SizedBox(
                            width: 90,
                            child: Row(
                              children: [
                                Text(
                                  'Entregar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 5),
                                Image.asset(
                                  'assets/enviartarea.gif',
                                  width: 30,
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        _cambiarDisenoSegunCondicion(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cambiarDisenoSegunCondicion() {
    if (tareaEntregada && esLiderTarea && !esLiderProyecto) {
      return Column(
        children: [
          Image.asset(
            'assets/comprobado.png',
            width: 37,
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            'Tarea entregada',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
        ],
      );
    }

    if (tareaEntregada && esLiderProyecto && esLiderTarea) {
      return cargarPdf();
    }

    return Container();
  }

  Column cargarPdf() {
    return Column(
      children: [
        Text(
          '${entrega.informe}',
          style: TextStyle(
              fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            _downloadPDF(entrega.urlPdfEntrega);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          child: SizedBox(
            width: 150,
            child: Row(
              children: [
                Text(
                  'Descargar PDF',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 5),
                Icon(Icons.download, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void registrarEntrega() async {
    File file = File(pdfPath!);
    List<int> bytes = await file.readAsBytes();

    String base64Data = base64Encode(bytes);

    EntregasModel entrega = EntregasModel(
      informe: _controllerInforme.text,
      urlPdfEntrega: base64Data,
      idTarea: tarea.idTarea,
    );

    gestionEntregas.registrarEntregas(entrega).then((resultado) {
      print('El resultado de subir la tarea es: $resultado');
      setState(() {
        tareaEntregada = true;
      });
      Get.snackbar(
        icon: Icon(
          Icons.check,
          color: Colors.green,
        ),
        'Desarrollo Cargado',
        'Exitosamente',
        backgroundColor: Colors.white,
        colorText: Colors.blue,
      );
      gestionProyectos.cambiarEstadoProyectosMemoria();
      tareaFueEntregada();
    }).catchError((error) {
      print('Ocurrió un error al registrar la tarea: $error');
    });
  }
}
