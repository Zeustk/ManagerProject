
import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:http/http.dart' as http;

class ProyectosProvider extends CrudProvider<ProyectoModel>{


   Future<List<ProyectoModel>> _proyectosMemoria = Future.value([]);
   bool _proyectosMemoriaActualizado=true;

  Future<String> registrarProyecto(ProyectoModel proyectoRecibido) async {
  try {
    _proyectosMemoriaActualizado = false;
    return await agregar(proyectoRecibido, 'addProyecto');
  } catch (error) {
    
    
    return 'Error al registrar el proyecto';
  }
}

Future<List<ProyectoModel>> consultarProyecto() async {
  try {

     List<Map<String, dynamic>> listaMapas = await consultar('getProyecto');
    
    // Convertir cada mapa a un objeto ProyectoModel usando el método fromJson
    List<ProyectoModel> listaProyectos = listaMapas.map((map) => ProyectoModel.fromJson(map)).toList();

    return listaProyectos;


  } catch (error) {
    // Manejar el error al consultar los proyectos
    print('Error al consultar los proyectos: $error');
    return [];
  }
}



Future<String> actualizarProyecto(ProyectoModel proyecto) async {
  try {
    return await actualizar(proyecto, 'UpdateProyecto');
  } catch (error) {
    // Manejar el error al actualizar el proyecto
    print('Error al actualizar el proyecto: $error');
    return 'Error al actualizar el proyecto';
  }
}

Future<String> eliminarProyecto(int id) async {
  try {
    return await eliminar(id, 'DeleteProyecto');
  } catch (error) {
    // Manejar el error al eliminar el proyecto
    print('Error al eliminar el proyecto: $error');
    return 'Error al eliminar el proyecto';
  }
}

 // Future<String> buscarVehiculo(VehiculoModel vehiculoRecibido) async {
   // return buscarUsuario(vehiculoRecibido, 'BuscarVehiculo');
  //}
}