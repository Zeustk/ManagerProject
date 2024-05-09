import 'dart:convert';
import 'dart:ffi';

TareasModel mensajesresponseFromJson(String str) =>
    TareasModel.fromJson(json.decode(str));

String mensajesresponseToJson(TareasModel data) => json.encode(data.toJson());

class TareasModel {
  int idTarea;
  String nombre;
  String fechaInicio;
  String fechaFinalizacion;
  String descripcion;
  Double porcentajeTarea;
  int idProyecto;
  int idUsuario;

  TareasModel({
    required this.idTarea,
    required this.nombre,
    required this.fechaInicio,
    required this.fechaFinalizacion,
    required this.descripcion,
    required this.porcentajeTarea,
    required this.idProyecto,
    required this.idUsuario,
  });

  factory TareasModel.fromJson(Map<String, dynamic> json) => TareasModel(
        idTarea: json["Id_Tarea"],
        nombre: json["Nombre"],
        fechaInicio: json["Fecha_inicio"],
        fechaFinalizacion: json["Fecha_finalizacion"],
        descripcion: json["Descripcion"],
        porcentajeTarea: json["PorcentajeTarea"],
        idProyecto: json["Id_Proyecto"],
        idUsuario: json["Id_Usuario"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Tarea": idTarea,
        "Nombre": nombre,
        "Fecha_inicio": fechaInicio,
        "Fecha_finalizacion": fechaFinalizacion,
        "Descripcion": descripcion,
        "PorcentajeTarea": porcentajeTarea,
        "Id_Proyecto": idProyecto,
        "Id_Usuario": idUsuario,
      };
}
