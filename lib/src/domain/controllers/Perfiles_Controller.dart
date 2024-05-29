import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Perfiles_Provider.dart';
import 'package:manager_proyect/src/domain/models/Perfiles_model.dart';

import '../models/Usuario_model.dart';


class PerfilesController extends GetxController {
  PerfilesProvider gestionPerfil = PerfilesProvider();

  Future<String> registrarPerfil(PerfilesModel perfilRecibido) async {
    try {
      return await gestionPerfil.registrarPerfiles(perfilRecibido);
    } catch (e) {
      return 'Error al registar el Perfil';
    }
  }

  Future<List<PerfilesModel>> consultarPerfil() async {
    try {
      return await gestionPerfil.consultaPerfiles();
    } catch (error) {
      return [];
    }
  }

  Future<String> actualizarPerfiles(PerfilesModel perfilRecibido) async {
    try {
      return await gestionPerfil.actualizarPerfiles(perfilRecibido);
    } catch (error) {
      return 'Error al actualizar el Perfil';
    }
  }

  Future<String> eliminarPerfiles(int idPerfil) async {
    try {
      return await gestionPerfil.eliminarPerfiles(idPerfil);
    } catch (error) {
      return 'Error al eliminar el Perfil';
    }
  }

   Future<PerfilesModel> getUsuarioPorId(UsuarioModel usuarioRecibido) async {
    try {

      return gestionPerfil.getPerfilPorIdUsuario(usuarioRecibido);
      
    } catch (e) {
      print(' el error es  $e');
      return PerfilesModel();
    }
  }
}
