// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RolesModel mensajesresponseFromJson(String str) => RolesModel.fromJson(json.decode(str));

String mensajesresponseToJson(RolesModel data) => json.encode(data.toJson());

class RolesModel {
    int idRol;
    String nombre;
    int prioridad;

    RolesModel({
        required this.idRol,
        required this.nombre,
        required this.prioridad,
    });

    factory RolesModel.fromJson(Map<String, dynamic> json) => RolesModel(
        idRol: json["Id_Rol"],
        nombre: json["Nombre"],
        prioridad: json["Prioridad"],
    );

    Map<String, dynamic> toJson() => {
        "Id_Rol": idRol,
        "Nombre": nombre,
        "Prioridad": prioridad,
    };
}
