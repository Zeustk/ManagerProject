import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';
import 'package:http/http.dart' as http;

class TareasProvider extends CrudProvider<TareasModel> {
  Future<String> registrarTarea(TareasModel tareaRecibida) async {
    try {
      return await agregar(tareaRecibida, 'addTarea');
    } catch (e) {
      return "Error al Registrar La Tarea";
    }
  }

  Future<List<TareasModel>> consultaTareas() async {
    try {
      List<Map<String, dynamic>> tareasMapa = await consultar('getTareas');

      List<TareasModel> listaTareas =
          tareasMapa.map((map) => TareasModel.fromJson(map)).toList();

      return listaTareas;
    } catch (e) {
      print('Error alconsultar las tareas');
      return [];
    }
  }

  Future<String> actualizarTarea(TareasModel tarea) async {
  try {
    return await actualizar(tarea, 'UpdateTarea');
  } catch (error) {
    
    print('Error al actualizar la Tarea: $error');
    return 'Error al actualizar la Tarea';
  }
}

Future<String> eliminarTareas(int id) async {
  try {
    return await eliminar(id, 'DeleteTareas');
  } catch (error) {
    
    print('Error al eliminar la Tarea');
    return 'Error al eliminar la Tarea';
  }
}
}
