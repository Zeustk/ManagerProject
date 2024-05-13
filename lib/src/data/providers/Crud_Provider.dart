import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:manager_proyect/src/environment/environment.dart';
import 'dart:async';

class CrudProvider<T> {
  final String baseUrl = Environment.baseUrl;

  Future<String> agregar(T body, String endpoint) async {
    try {
      final url = '$baseUrl/$endpoint';

      print(url);
      print(jsonEncode(body));
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      return response.body;
    } catch (e) {
      // Manejar el error
      return 'Error al agregar el elemento: $e';
    }
  }

  Future<List<Map<String, dynamic>>> consultar(String endpoint) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic decodedData = jsonDecode(response.body);
      List<Map<String, dynamic>> dataList =
          List<Map<String, dynamic>>.from(decodedData);

      return dataList;
    } else {
      throw Exception('Error al consultar datos');
    }
  }

  Future<String> actualizar(T body, String endpoint) async {
    final url = '$baseUrl/$endpoint';
    final response = await http.put(Uri.parse(url), body: jsonEncode(body));
    return response.body;
  }

  Future<String> eliminar(int id, String endpoint) async {
    final url = '$baseUrl/$endpoint/$id';
    final response = await http.delete(Uri.parse(url));
    return response.body;
  }

  Future<dynamic> busquedaPersonalizada(T body, String endpoint) async {
    final url = '$baseUrl/$endpoint';
    try {
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body));

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
