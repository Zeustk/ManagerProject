import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Entregas_Provider.dart';
import 'package:manager_proyect/src/domain/models/Entregas_model.dart';


class EntregasController extends GetxController {
  EntregasProvider gestionEntregas = EntregasProvider();

  Future<String> registrarEntregas(EntregasModel entrega) async {
    try {
      return await gestionEntregas.registrarEntrega(entrega);
    } catch (e) {
      return 'Error al registar la Entrega';
    }
  }

  Future<List<EntregasModel>> consultarEntregas(int id_Proyecto,int id_Usuario) async {
    try {
      return await gestionEntregas.consultaEntregas(id_Proyecto,id_Usuario);
    } catch (error) {
      return [];
    }
  }

  Future<String> actualizarEntregas(EntregasModel tareas) async {
    try {
      return await gestionEntregas.actualizarEntregas(tareas);
    } catch (error) {
      return 'Error al actualizar la tarea';
    }
  }

  Future<String> eliminarEntregas(int idTareas) async {
    try {
      return await gestionEntregas.eliminarEntregas(idTareas);
    } catch (error) {
      return 'Error al eliminar la tarea';
    }
  }
}
