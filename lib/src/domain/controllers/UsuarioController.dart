import 'package:get/get.dart';

import 'package:manager_proyect/src/data/providers/Usuario_Provider.dart';

import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class UsuariosController extends GetxController {
  UsuarioProvider gestionUsuarios = UsuarioProvider();

  Future<String> registrarUsuarios(UsuarioModel usuarioRecibido) async {
    try {
      return await gestionUsuarios.registrarUsuarios(usuarioRecibido);
    } catch (e) {
      return 'Error al registar el Usuario';
    }
  }

  Future<List<UsuarioModel>> consultarUsuario() async {
    try {
      return await gestionUsuarios.consultaUsuarios();
    } catch (error) {
      return [];
    }
  }

  Future<bool> verificarUsuario(UsuarioModel usuarioRecibido) async {
    try {
      return await gestionUsuarios.verificarCorreo(usuarioRecibido);
    } catch (error) {
      return false;
    }
  }


  Future<UsuarioModel> getUsuarioPorId(UsuarioModel usuarioRecibido) async {
    try {

      return gestionUsuarios.getUsuarioId(usuarioRecibido);
      
    } catch (e) {
      print(' el error es  $e');
      return UsuarioModel(idUsuario: 0, email: 'adasds', clave: 'asdasd', idRol: null);
    }
  }

  Future<String> actualizarUsuarios(UsuarioModel usuarioRecibido) async {
    try {
      return await gestionUsuarios.actualizarUsuarios(usuarioRecibido);
    } catch (error) {
      return 'Error al actualizar el Usuario';
    }
  }

  Future<String> eliminarUsuarios(int idUsuario) async {
    try {
      return await gestionUsuarios.eliminarUsuarios(idUsuario);
    } catch (error) {
      return 'Error al eliminar el Usuario';
    }
  }
}
