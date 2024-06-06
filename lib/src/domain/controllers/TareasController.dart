import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Tareas_Provider.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';

class TareasController extends GetxController {
  TareasProvider gestionTareas = TareasProvider();

  Future<String> registrarTareas(TareasModel tareas) async {
    try {
      return await gestionTareas.registrarTarea(tareas);
    } catch (e) {
      return 'Error al registar la Tarea';
    }
  }

  Future<List<TareasModel>> consultarTareas(int id_Proyecto,int id_Usuario) async {
    try {
      return await gestionTareas.consultaTareas(id_Proyecto,id_Usuario);
    } catch (error) {
      return [];
    }
  }

  Future<String> actualizarTareas(TareasModel tareas) async {
    try {
      return await gestionTareas.actualizarTarea(tareas);
    } catch (error) {
      return 'Error al actualizar la tarea';
    }
  }

  Future<String> eliminarTareas(int idTareas) async {
    try {
      return await gestionTareas.eliminarTareas(idTareas);
    } catch (error) {
      return 'Error al eliminar la tarea';
    }
  }

  Future<String> actualizarEstado(int idTarea,int nuevoEstado ) async {
     try {
      return await gestionTareas.actualizarEstadoTarea(idTarea,nuevoEstado);
    } catch (error) {
      return 'Error al actualizar la tarea';
    }
  }
}
