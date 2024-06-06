import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Tareas_Provider.dart';
import 'package:manager_proyect/src/domain/models/Tareas_model.dart';

class TareasController extends GetxController {
  TareasProvider gestionTareas = TareasProvider();
  var tareas = <TareasModel>[].obs; // Lista reactiva

  Future<String> registrarTareas(TareasModel tareas) async {
    try {
      return await gestionTareas.registrarTarea(tareas);
    } catch (e) {
      return 'Error al registar la Tarea';
    }
  }

  Future<void> consultarTareas(int id_Proyecto, int id_Usuario) async {
    try {
      List<TareasModel> tareasList = await gestionTareas.consultaTareas(id_Proyecto, id_Usuario);
      tareas.assignAll(tareasList); // Actualiza la lista reactiva
    } catch (error) {
      tareas.assignAll([]); // Asigna una lista vacía en caso de error
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

  Future<String> actualizarEstado(int idTarea, int nuevoEstado) async {
    try {
       String result = await gestionTareas.actualizarEstadoTarea(idTarea, nuevoEstado);
        // Actualizar el estado localmente
        TareasModel tarea = tareas.firstWhere((tarea) => tarea.idTarea == idTarea);
        tarea.idEstado = nuevoEstado;
        tareas.refresh(); // Notifica cambios

      return result;
    } catch (error) {
      return 'Error al actualizar la tarea';
    }
  }
}
