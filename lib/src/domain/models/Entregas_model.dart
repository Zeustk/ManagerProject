// To parse this JSON data, do
//
//     final entregasModel = entregasModelFromJson(jsonString);

import 'dart:convert';

EntregasModel entregasModelFromJson(String str) => EntregasModel.fromJson(json.decode(str));

String entregasModelToJson(EntregasModel data) => json.encode(data.toJson());

class EntregasModel {
    int idEntrega;
    String informe;
    String urlPdfEntrega;
    int idTarea;

    EntregasModel.empty()
      : idEntrega = -1,
        informe = '',
        urlPdfEntrega = '',
        idTarea = 0;


    EntregasModel({
        this.idEntrega=0,
        required this.informe,
        required this.urlPdfEntrega,
        required this.idTarea,
    });

    factory EntregasModel.fromJson(Map<String, dynamic> json) => EntregasModel(
        idEntrega: json["Id_Entrega"],
        informe: json["Informe"],
        urlPdfEntrega: json["UrlPdfEntrega"],
        idTarea: json["Id_Tarea"],
    );

    Map<String, dynamic> toJson() => {
        "Id_Entrega": idEntrega,
        "Informe": informe,
        "UrlPdfEntrega": urlPdfEntrega,
        "Id_Tarea": idTarea,
    };

     @override
  String toString() {
    return 'UsuarioModel{idEntrega: $idEntrega, informe $informe, urlpdf: $urlPdfEntrega, idTarea: $idTarea }';
  }
}
