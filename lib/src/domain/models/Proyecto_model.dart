// To parse this JSON data, do
//
//     final proyectosProvider = proyectosProviderFromJson(jsonString);

import 'dart:convert';

ProyectoModel proyectosProviderFromJson(String str) => ProyectoModel.fromJson(json.decode(str));

String proyectosProviderToJson(ProyectoModel data) => json.encode(data.toJson());

class ProyectoModel {
    int idProyecto;
    String liderProyecto;
    String nombre;
    DateTime fechaInicio;
    DateTime fechaFinalizacion;
    String descripcion;
    int idEstado;

    

    ProyectoModel({
        this.idProyecto=-1,
        required this.liderProyecto,
        required this.nombre,
        required this.fechaInicio,
        required this.fechaFinalizacion,
        required this.descripcion,
        this.idEstado=01,
    });

    factory ProyectoModel.fromJson(Map<String, dynamic> json) => ProyectoModel(
        idProyecto: json["Id_Proyecto"],
        liderProyecto: json["Lider_Proyecto"],
        nombre: json["Nombre"],
        fechaInicio: DateTime.parse(json["Fecha_Inicio"]),
        fechaFinalizacion: DateTime.parse(json["Fecha_Finalizacion"]),
        descripcion: json["Descripcion"],
        idEstado: json["Id_Estado"],
    );

    Map<String, dynamic> toJson() => {
        "Id_Proyecto": idProyecto,
        "Lider_Proyecto": liderProyecto,
        "Nombre": nombre,
        "Fecha_Inicio": "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "Fecha_Finalizacion": "${fechaFinalizacion.year.toString().padLeft(4, '0')}-${fechaFinalizacion.month.toString().padLeft(2, '0')}-${fechaFinalizacion.day.toString().padLeft(2, '0')}",
        "Descripcion": descripcion,
        "Id_Estado":idEstado,
    };

     @override
  String toString() {
    return 'ProyectoModel{idProyecto: $idProyecto, liderProyecto: $liderProyecto, nombre: $nombre, fechaInicio: $fechaInicio, fechaFinalizacion: $fechaFinalizacion, descripcion: $descripcion, Estado: $idEstado}';
  }


}
