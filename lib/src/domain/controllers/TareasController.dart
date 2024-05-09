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

  Future<List<TareasModel>> consultarTareas() async {
    try {
      return await gestionTareas.consultaTareas();
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
}
