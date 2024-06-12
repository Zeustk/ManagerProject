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

  Future<EntregasModel> consultarEntrega(int idTarea) async {
    try {
      print('hola controller');
      return await gestionEntregas.consultarEntrega(idTarea);
    } catch (error) {
      print(error);
      return EntregasModel.empty();
    }
  }
}
