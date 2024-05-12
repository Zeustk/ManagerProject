import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Roles_model.dart';


class RolesProvider extends CrudProvider<RolesModel> {
  Future<String> registrarRol(RolesModel rolRecibido) async {
    try {
      return await agregar(rolRecibido, 'addRol');
    } catch (e) {
      return "Error al Registrar el Rol";
    }
  }

  Future<List<RolesModel>> consultaRol() async {
    try {
      List<Map<String, dynamic>> rolmapa = await consultar('getRoles');

      List<RolesModel> listaRoles =
          rolmapa.map((map) => RolesModel.fromJson(map)).toList();

      return listaRoles;
    } catch (e) {
      print('Error alconsultar los Roles');
      return [];
    }
  }

  Future<String> actualizarRol(RolesModel rol) async {
    try {
      return await actualizar(rol, 'UpdateRol');
    } catch (error) {
      
      return 'Error al actualizar el Rol';
    }
  }

  Future<String> eliminarRol(int id) async {
    try {
      return await eliminar(id, 'DeleteRol');
    } catch (error) {
     
      return 'Error al eliminar el Rol';
    }
  }
}
