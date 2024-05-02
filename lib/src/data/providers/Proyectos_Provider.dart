
import 'package:manager_proyect/src/data/providers/Crud_Provider.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:http/http.dart' as http;

class ProyectosProvider extends CrudProvider<ProyectoModel>{


   Future<List<ProyectoModel>> _proyectosMemoria = Future.value([]);
   bool _proyectosMemoriaActualizado=true;

  Future<String> registrarProyecto(ProyectoModel proyectoRecibido) async {

    _proyectosMemoriaActualizado=false;
    return agregar(proyectoRecibido.toJson(), 'addProyecto');
  }

  Future<List<ProyectoModel>> consultarProyecto() async {

    if(!_proyectosMemoriaActualizado){
      _proyectosMemoria= consultar('getProyecto');
      _proyectosMemoriaActualizado=true;
      return _proyectosMemoria;
    }
    else{
      return _proyectosMemoria;
    }
  }

  Future<String> actualizarProyecto(ProyectoModel proyecto) async {
    return actualizar(proyecto, 'UpdateProyecto');
  }

  Future<String> eliminarProyecto(int id) async {
    return eliminar(id, 'DeleteProyecto');
  }

 // Future<String> buscarVehiculo(VehiculoModel vehiculoRecibido) async {
   // return buscarUsuario(vehiculoRecibido, 'BuscarVehiculo');
  //}
}