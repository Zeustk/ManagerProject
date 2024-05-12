

import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/DetalleProyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';

class DetallesProvider extends CrudProvider<DetallesModel>{
 Future<String> registrarDetalle(DetallesModel detalleRecibido) async {
    try {
      return await agregar(detalleRecibido, 'addDetalleproyecto');
    } catch (e) {
      return "Error al Registrar Detalles del proyecto";
    }
  }

  Future<List<DetallesModel>> consultaDetalle() async {
    try {
      List<Map<String, dynamic>> detallesMapa = await consultar('getDetalles');

      List<DetallesModel> listaDetalle =
          detallesMapa.map((map) => DetallesModel.fromJson(map)).toList();

      return listaDetalle;
    } catch (e) {
      print('Error al consultar los detalles del proyecto');
      return [];
    }
  }

  Future<String> actualizarDetalle(DetallesModel detalleRecibido) async {
  try {
    return await actualizar(detalleRecibido, 'UpdateDetalles');
  } catch (error) {
    
    
    return 'Error al actualizar los Usuarios';
  }
}

Future<String> eliminarDetalle(int id) async {
  try {
    return await eliminar(id, 'DeleteDetalle');
  } catch (error) {
    
    
    return 'Error al eliminar los detalles del proyecto';
  }
}
}