// To parse this JSON data, do
//
//     final mensajesresponse = mensajesresponseFromJson(jsonString);

import 'dart:convert';

UsuarioModel mensajesresponseFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String mensajesresponseToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  int idUsuario;
  String email;
  String clave;
  int? idRol;

  UsuarioModel({
    this.idUsuario=0,
    this.email="No Disponible",
    this.clave="-1",
    this.idRol,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        idUsuario: json["Id_Usuario"],
        email: json["Email"],
        clave: json["Clave"],
        idRol: json["Id_rol"],
      );

  Map<String, dynamic> toJson() => {
        "Id_Usuario": idUsuario,
        "Email": email,
        "Clave": clave,
        "Id_rol": idRol,
      };

  @override
  String toString() {
    return 'UsuarioModel{idUsuario: $idUsuario, }';
  }
}
