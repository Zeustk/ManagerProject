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

  Future<List<EntregasModel>> consultaEntregas(int id_Proyecto,int id_Usuario) async {
    try {
      List<Map<String, dynamic>> tareasMapa = await consultar('getTarea/$id_Proyecto/$id_Usuario');

      List<EntregasModel> listaTareas =
          tareasMapa.map((map) => EntregasModel.fromJson(map)).toList();

      return listaTareas;
    } catch (e) {
      print('Error al sconsultar las tareas $e');
      return [];
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

  Future<bool> siTareaFueEntregada(int idTarea) async {

    try{
      return await consultarDinamico('getFueEntregada/$idTarea');
      
    }catch(error){
      print('error al saber si la tarea fue entrega $error');
      return false;
    }


  }
}
