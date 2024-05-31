import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class UsuarioProvider extends CrudProvider<UsuarioModel> {
  Future<String> registrarUsuarios(UsuarioModel usuarioRecibido) async {
    try {
      return await agregar(usuarioRecibido, 'addUsuario');
    } catch (e) {
      return "Error al Registrar el Usuario";
    }
  }

  Future<List<UsuarioModel>> consultaUsuarios() async {
    try {
      List<Map<String, dynamic>> usuariosMapa = await consultar('getUsuarios');

      List<UsuarioModel> listaUsuario =
          usuariosMapa.map((map) => UsuarioModel.fromJson(map)).toList();

      return listaUsuario;
    } catch (e) {
      print('Error al consultar los usuarios $e');
      return [];
    }
  }

  Future<bool> verificarCorreo(UsuarioModel usuarioRecibido) async {
    try {
      bool usuarioVeri =
          await busquedaPersonalizada(usuarioRecibido, 'getUsuarioBase');

      return usuarioVeri;
    } catch (e) {
      print(' el error es  $e');
      return false;
    }
  }

   Future<UsuarioModel> getUsuarioId(UsuarioModel usuarioRecibido) async {
    try {
      Map<String, dynamic> usuarioVeri =
          await busquedaPersonalizada(usuarioRecibido, 'getUsuarioConId');

      UsuarioModel usuario = UsuarioModel.fromJson(usuarioVeri);

      return usuario;
    } catch (e) {
      print(' el error es  $e');
      return UsuarioModel(idUsuario: 0, email: 'adasds', clave: 'asdasd', idRol: null);
    }
  }

  Future<String> actualizarUsuarios(UsuarioModel usuarioRecibido) async {
    try {
      return await actualizar(usuarioRecibido, 'UpdateUsuarios');
    } catch (error) {
      return 'Error al actualizar los Usuarios';
    }
  }

  Future<String> eliminarUsuarios(int id) async {
    try {
      return await eliminar(id, 'DeleteUsuarios');
    } catch (error) {
      return 'Error al eliminar los Usuarios';
    }
  }


  Future<List<UsuarioModel>> consultaUsuariosPorIdProyecto(int idProyecto) async {
    try {
      List<Map<String, dynamic>> usuariosMapa = await consultar('getUsuariosPorIdProyecto/$idProyecto');

      List<UsuarioModel> listaUsuario =
          usuariosMapa.map((map) => UsuarioModel.fromJson(map)).toList();

      return listaUsuario;
    } catch (e) {
      print('Error al consultar los usuarios por idProyecto $e');
      return [];
    }
  }
}
