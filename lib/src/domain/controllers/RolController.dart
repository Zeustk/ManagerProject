import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:manager_proyect/src/data/providers/RolesProvider.dart';
import 'package:manager_proyect/src/domain/models/Roles_model.dart';

class RolController extends GetxController {
  RolesProvider gestionRoles = RolesProvider();

  Future<String> registrarRol(RolesModel rol) async {
    try {
      return await gestionRoles.registrarRol(rol);
    } catch (e) {
      return 'Error al registar el Rol';
    }
  }

  Future<List<RolesModel>> consultarRol() async {
    try {
      return await gestionRoles.consultaRol();
    } catch (error) {
      return [];
    }
  }

  Future<String> actualizarRol(RolesModel rol) async {
    try {
      return await gestionRoles.actualizarRol(rol);
    } catch (error) {
      return 'Error al actualizar el Rol';
    }
  }

  Future<String> eliminarRol(int idRol) async {
    try {
      return await gestionRoles.eliminarRol(idRol);
    } catch (error) {
      return 'Error al eliminar la tarea';
    }
  }
}