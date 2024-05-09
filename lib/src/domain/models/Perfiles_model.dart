// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PerfilesModel mensajesresponseFromJson(String str) => PerfilesModel.fromJson(json.decode(str));

String mensajesresponseToJson(PerfilesModel data) => json.encode(data.toJson());

class PerfilesModel {
    int idPerfil;
    String nombreCompleto;
    String email;
    int numeroDeProyecto;
    bool estado;
    int idUsuario;

    PerfilesModel({
        required this.idPerfil,
        required this.nombreCompleto,
        required this.email,
        required this.numeroDeProyecto,
        required this.estado,
        required this.idUsuario,
    });

    factory PerfilesModel.fromJson(Map<String, dynamic> json) => PerfilesModel(
        idPerfil: json["Id_Perfil"],
        nombreCompleto: json["Nombre_Completo"],
        email: json["Email"],
        numeroDeProyecto: json["Numero_De_Proyecto"],
        estado: json["Estado"],
        idUsuario: json["Id_Usuario"],
    );

    Map<String, dynamic> toJson() => {
        "Id_Perfil": idPerfil,
        "Nombre_Completo": nombreCompleto,
        "Email": email,
        "Numero_De_Proyecto": numeroDeProyecto,
        "Estado": estado,
        "Id_Usuario": idUsuario,
    };
}
