import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';

class ProyectosProvider extends CrudProvider<ProyectoModel> {
  static ProyectosProvider? _instance;
  List<ProyectoModel> _proyectosMemoria = [];
  bool _proyectosMemoriaActualizado = false;

  ProyectosProvider._(); // Constructor privado para evitar la creación directa de instancias

  static ProyectosProvider get instance {
    _instance ??= ProyectosProvider
        ._(); // Si la instancia es nula, crea una nueva instancia
    return _instance!;
  }

  Future<String> registrarProyecto(ProyectoModel proyectoRecibido) async {
    try {
      _proyectosMemoriaActualizado = false;
      return await agregar(proyectoRecibido, 'addProyecto');
    } catch (error) {
      // Manejar el error al registrar el proyecto
      print('Error al registrar el proyecto: $error');
      return 'Error al registrar el proyecto';
    }
  }

  void cambiarEstadoPorLogin() {
    _proyectosMemoriaActualizado = false;
  }

  Future<List<ProyectoModel>> consultarProyecto(int id_Usuario) async {
    try {
      if (!_proyectosMemoriaActualizado) {
        _proyectosMemoriaActualizado = true;

        List<Map<String, dynamic>> listaMapas =
            await consultar('getProyecto/$id_Usuario');

          
        _proyectosMemoria =
            listaMapas.map((map) => ProyectoModel.fromJson(map)).toList();

        if (_proyectosMemoria.isEmpty) {
          _proyectosMemoriaActualizado = false;
        }
      }

      // Convertir cada mapa a un objeto ProyectoModel usando el método fromJson

      return _proyectosMemoria;
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
      _proyectosMemoriaActualizado = false;
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
