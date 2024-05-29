import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Perfiles_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class PerfilesProvider extends CrudProvider<PerfilesModel> {
  Future<String> registrarPerfiles(PerfilesModel perfilRecibido) async {
    try {
      return await agregar(perfilRecibido, 'addPerfiles');
    } catch (e) {
      return "Error al Registrar el Perfil";
    }
  }

  Future<List<PerfilesModel>> consultaPerfiles() async {
    try {
      List<Map<String, dynamic>> perfilesMapa = await consultar('getPerfiles');

      List<PerfilesModel> listaUsuario =
          perfilesMapa.map((map) => PerfilesModel.fromJson(map)).toList();

      return listaUsuario;
    } catch (e) {
      print('Error al consultar los perfiles');
      return [];
    }
  }

  Future<String> actualizarPerfiles(PerfilesModel perfilRecibido) async {
    try {
      return await actualizar(perfilRecibido, 'UpdatePerfiles');
    } catch (error) {
      return 'Error al actualizar los Perfiles';
    }
  }

  Future<String> eliminarPerfiles(int id) async {
    try {
      return await eliminar(id, 'DeletePerfiles');
    } catch (error) {
      return 'Error al eliminar los Perfiles';
    }
  }

  Future<PerfilesModel> getPerfilPorIdUsuario(UsuarioModel usuarioRecibido) async {
    try {
      Map<String, dynamic> usuarioActual =
          await busquedaPersonalizada(usuarioRecibido, 'getPerfilPorIdUsuario/${usuarioRecibido.idUsuario}');

      PerfilesModel perfil = PerfilesModel.fromJson(usuarioActual);

      return perfil;
    } catch (e) {
      print(' el error es  $e');
      return PerfilesModel();
    }
  }

}
