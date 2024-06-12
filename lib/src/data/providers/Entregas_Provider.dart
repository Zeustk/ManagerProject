import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Entregas_model.dart';

class EntregasProvider extends CrudProvider<EntregasModel> {
  Future<String> registrarEntrega(EntregasModel entregaRecibida) async {
    try {
      return await agregar(entregaRecibida, 'addEntrega');
    } catch (e) {
      return "Error al Registrar La Entrega";
    }
  }

  Future<String> actualizarEntregas(EntregasModel tarea) async {
    try {
      return await actualizar(tarea, 'UpdateTarea');
    } catch (error) {
      print('Error al actualizar la Tarea: $error');
      return 'Error al actualizar la Tarea';
    }
  }

  Future<String> eliminarEntregas(int id) async {
    try {
      return await eliminar(id, 'DeleteTareas');
    } catch (error) {
      print('Error al eliminar la Tarea');
      return 'Error al eliminar la Tarea';
    }
  }

  Future<EntregasModel> consultarEntrega(int idTarea) async {
    try {
      List<Map<String, dynamic>> entregas =
          await consultar('getEntrega/$idTarea');

      if (entregas.isNotEmpty) {

        return EntregasModel.fromJson(entregas[0]);
      } else {
        print('vacio');
        // Devuelve una instancia con valores por defecto si la lista está vacía
        return EntregasModel.empty();
      }
    } catch (e) {
      print('Error al consultar las tareas $e');
      return EntregasModel(
        informe: "Desconocido",
        urlPdfEntrega: "Desconocido",
        idTarea: -1,
      );
    }
  }
}
