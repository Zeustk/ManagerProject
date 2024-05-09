import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Detalles_Provider.dart';
import 'package:manager_proyect/src/domain/models/DetalleProyecto_model.dart';

import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class DetallesController extends GetxController {
  DetallesProvider gestionDetalles = DetallesProvider();

  Future<String> registrarDetalles(DetallesModel detalleRecibido) async {
    try {
      return await gestionDetalles.registrarDetalle(detalleRecibido);
    } catch (e) {
      return 'Error al registar el detalle del proyecto';
    }
  }

  Future<List<DetallesModel>> consultarDetalles() async {
    try {
      return await gestionDetalles.consultaDetalle();
    } catch (error) {
      return [];
    }
  }

  Future<String> actualizarUsuarios(DetallesModel detalleRecibido) async {
    try {
      return await gestionDetalles.actualizarDetalle(detalleRecibido);
    } catch (error) {
      return 'Error al actualizar el detalle del proyecto';
    }
  }

  Future<String> eliminarUsuarios(int idDetalles) async {
    try {
      return await gestionDetalles.eliminarDetalle(idDetalles);
    } catch (error) {
      return 'Error al eliminar los detalles del proyecto';
    }
  }
}
