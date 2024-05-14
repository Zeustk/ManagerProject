import 'dart:convert';
import 'dart:ffi';

TareasModel mensajesresponseFromJson(String str) =>
    TareasModel.fromJson(json.decode(str));

String mensajesresponseToJson(TareasModel data) => json.encode(data.toJson());

class TareasModel {
  int idTarea;
  String nombre;
  DateTime fechaInicio;
  DateTime fechaFinalizacion;
  String descripcion;
  double porcentajeTarea;
  int? idProyecto;
  int? idUsuario;
  String urlpdf;

  TareasModel(
      {this.idTarea = 1,
      required this.nombre,
      required this.fechaInicio,
      required this.fechaFinalizacion,
      required this.descripcion,
      required this.porcentajeTarea,
      required this.idProyecto,
      required this.idUsuario,
      required this.urlpdf});

  factory TareasModel.fromJson(Map<String, dynamic> json) => TareasModel(
        idTarea: json["Id_Tarea"],
        nombre: json["Nombre"],
        fechaInicio: DateTime.parse(json["Fecha_Inicio"]),
        fechaFinalizacion: DateTime.parse(json["Fecha_Finalizacion"]),
        descripcion: json["Descripcion"],
        porcentajeTarea: json["PorcentajeTarea"] != null
            ? double.tryParse(json["PorcentajeTarea"].toString()) ?? 0.0
            : 0.0,
        idProyecto: json["Id_Proyecto"],
        idUsuario: json["Id_Usuario"],
        urlpdf: json["urlpdf"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Tarea": idTarea,
        "Nombre": nombre,
        "Fecha_Inicio":
            "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "Fecha_Finalizacion":
            "${fechaFinalizacion.year.toString().padLeft(4, '0')}-${fechaFinalizacion.month.toString().padLeft(2, '0')}-${fechaFinalizacion.day.toString().padLeft(2, '0')}",
        "Descripcion": descripcion,
        "PorcentajeTarea": porcentajeTarea,
        "Id_Proyecto": idProyecto,
        "Id_Usuario": idUsuario,
        "urlpdf": urlpdf,
      };
}
