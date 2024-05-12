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

  Future<List<UsuarioModel>> verificarUsuario(UsuarioModel usuarioDb) async {
    try {
      return await gestionUsuarios.verificarCorreo();
    } catch (error) {
      return [];
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
