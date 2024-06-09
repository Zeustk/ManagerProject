import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TaskData {
  final int completedTasks;
  final int inProgressTasks;
  final int pendingTasks;
  final double projectCompletionPercentage;

  TaskData({
    required this.completedTasks,
    required this.inProgressTasks,
    required this.pendingTasks,
    required this.projectCompletionPercentage,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfDemoPage(),
    );
  }
}

class PdfDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar Informe PDF en Flutter'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final pdfData = await generatePdf(projectDataList);
            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdfData,
            );
          },
          child: Text('Generar PDF'),
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> projectDataList = [
  {
    'Nombre del proyecto': 'H',
    'Tareas completadas': 10,
    'Tareas en curso': 5,
    'Tareas pendientes': 3,
    'Porcentaje Completado': 75.0,
  },
  {
    'Nombre del proyecto': 'R',
    'Tareas completadas': 8,
    'Tareas en curso': 6,
    'Tareas pendientes': 2,
    'Porcentaje Completado': 60.0,
  },
  {
    'Nombre del proyecto': 'I',
    'Tareas completadas': 6,
    'Tareas en curso': 3,
    'Tareas pendientes': 1,
    'Porcentaje Completado': 40.0,
  },
];

Future<Uint8List> generatePdf(
    List<Map<String, dynamic>> projectDataList) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Text(
              'Informe de Proyectos',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.blue200, width: 2.5),
              columnWidths: {
                0: pw.FlexColumnWidth(1.5),
                1: pw.FlexColumnWidth(1),
                2: pw.FlexColumnWidth(1),
                3: pw.FlexColumnWidth(1),
                4: pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  children: [
                    pw.Container(
                      color: PdfColors.blue100,
                      width: 100,
                      height: 73,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Nombre del proyecto',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                    pw.Container(
                      color: PdfColors.blue100,
                      width: 200,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Tareas completadas',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                    pw.Container(
                      color: PdfColors.blue100,
                      width: 300,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Tareas en curso',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                    pw.Container(
                      color: PdfColors.blue100,
                      width: 300,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Tareas pendientes',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                    pw.Container(
                      color: PdfColors.blue100,
                      height: 73,
                      width: 300,
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text('Porcentaje Completado',
                          style: pw.TextStyle(
                              fontSize: 16,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.white)),
                    ),
                  ],
                ),
                // Agregar filas dinámicamente para cada proyecto
                for (var project in projectDataList)
                  pw.TableRow(
                    children: [
                      pw.Container(
                        color: PdfColors.grey100,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('${project['Nombre del proyecto']}',
                            style: pw.TextStyle(fontSize: 14)),
                      ),
                      pw.Container(
                        color: PdfColors.grey100,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('${project['Tareas completadas']}',
                            style: pw.TextStyle(fontSize: 14)),
                      ),
                      pw.Container(
                        color: PdfColors.grey100,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('${project['Tareas en curso']}',
                            style: pw.TextStyle(fontSize: 14)),
                      ),
                      pw.Container(
                        color: PdfColors.grey100,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('${project['Tareas pendientes']}',
                            style: pw.TextStyle(fontSize: 14)),
                      ),
                      pw.Container(
                        color: PdfColors.grey100,
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('${project['Porcentaje Completado']}%',
                            style: pw.TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.BarcodeWidget(
              data: 'https://www.facebook.com',
              barcode: pw.Barcode.qrCode(),
              width: 80,
              height: 80,
            ),
            pw.Spacer(),
            pw.Text(
              'Proyecto Manager',
              style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
