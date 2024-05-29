// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'dart:ffi';

import 'package:meta/meta.dart';
import 'dart:convert';

DetallesModel mensajesresponseFromJson(String str) =>
    DetallesModel.fromJson(json.decode(str));

String mensajesresponseToJson(DetallesModel data) => json.encode(data.toJson());

class DetallesModel {
  int idDetalle;
  int idUsuario;
  int idProyecto;
  double porcentajeProyecto;
  int idLiderProyecto;

  DetallesModel({
    required this.idDetalle,
    required this.idUsuario,
    required this.idProyecto,
    required this.porcentajeProyecto,
    required this.idLiderProyecto,
  });

  factory DetallesModel.fromJson(Map<String, dynamic> json) => DetallesModel(
        idDetalle: json["Id_Detalle"],
        idUsuario: json["Id_Usuario"],
        idProyecto: json["Id_Proyecto"],
        porcentajeProyecto: json["PorcentajeProyecto"],
        idLiderProyecto: json["Id_LiderProyecto"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Detalle": idDetalle,
        "Id_Usuario": idUsuario,
        "Id_Proyecto": idProyecto,
        "PorcentajeProyecto": porcentajeProyecto,
        "Id_LiderProyecto":idLiderProyecto,
      };
}
