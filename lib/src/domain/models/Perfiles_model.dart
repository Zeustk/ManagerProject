// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PerfilesModel mensajesresponseFromJson(String str) =>
    PerfilesModel.fromJson(json.decode(str));

String mensajesresponseToJson(PerfilesModel data) => json.encode(data.toJson());

class PerfilesModel {
  int idPerfil;
  String nombreCompleto;
  int numeroDeProyecto;
  bool estado;
  int? idUsuario;

  PerfilesModel({
    this.idPerfil = 0,
    this.nombreCompleto = "XXX",
    this.numeroDeProyecto = 0,
    this.estado = false,
    this.idUsuario = null,
  });

  factory PerfilesModel.fromJson(Map<String, dynamic> json) => PerfilesModel(
        idPerfil: json["Id_Perfil"],
        nombreCompleto: json["Nombre_Completo"],
        numeroDeProyecto: json["Numero_De_Proyecto"],
        estado: json["Estado"],
        idUsuario: json["Id_Usuario"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Perfil": idPerfil,
        "Nombre_Completo": nombreCompleto,
        "Numero_De_Proyecto": numeroDeProyecto,
        "Estado": estado,
        "Id_Usuario": idUsuario,
      };
}
