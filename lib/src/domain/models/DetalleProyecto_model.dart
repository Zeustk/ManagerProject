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
  int idLiderProyecto;

  DetallesModel({
    required this.idDetalle,
    required this.idUsuario,
    this.idProyecto = -1,
    required this.idLiderProyecto,
  });

  factory DetallesModel.fromJson(Map<String, dynamic> json) => DetallesModel(
        idDetalle: json["Id_Detalle"],
        idUsuario: json["Id_Usuario"],
        idProyecto: json["Id_Proyecto"],
        idLiderProyecto: json["Id_LiderProyecto"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Detalle": idDetalle,
        "Id_Usuario": idUsuario,
        "Id_Proyecto": idProyecto,
        "Id_LiderProyecto": idLiderProyecto,
      };
}
