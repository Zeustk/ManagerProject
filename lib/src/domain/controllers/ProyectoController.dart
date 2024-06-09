import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Proyectos_Provider.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';

class ProyectoController extends GetxController {
  ProyectosProvider gestionProyectos = ProyectosProvider.instance;

  Future<String> registrarProyecto(ProyectoModel proyecto) async {
    try {
      
      return await gestionProyectos.registrarProyecto(proyecto);
    } catch (error) {
      // Manejar el error al registrar el proyecto
      print('Error al registrar el proyecto (Controllers): $error');
      return 'Error al registrar el proyecto';
    }
  }

  Future<List<ProyectoModel>> consultarProyectos(int id_Usuario) async {
    try {
      return await gestionProyectos.consultarProyecto(id_Usuario);
    } catch (error) {
      // Manejar el error al consultar los proyectos
      print('Error al consultar los proyectos (Controllers): $error');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<String> actualizarProyecto(ProyectoModel proyecto) async {
    try {
      return await gestionProyectos.actualizarProyecto(proyecto);
    } catch (error) {
      // Manejar el error al actualizar el proyecto
      print('Error al actualizar el proyecto(Controllers): $error');
      return 'Error al actualizar el proyecto';
    }
  }

  Future<String> eliminarProyecto(int idProyecto) async {
    try {
      return await gestionProyectos.eliminarProyecto(idProyecto);
    } catch (error) {
      
      print('Error al eliminar el proyecto(Controllers): $error');
      return 'Error al eliminar el proyecto';
    }
  }

    Future<List<ProyectoModel>> consultarProyectosPorLider(int idLiderProyecto) async {
    try {
      return await gestionProyectos.consultaProyectosByLider(idLiderProyecto);
    } catch (error) {
      // Manejar el error al consultar los proyectos
      print('Error al consultar los proyectos  by lider(Controllers): $error');
      return []; // Devuelve una lista vacía en caso de error
    }
  }


  void cambiarEstadoProyectosMemoria(){
    gestionProyectos.cambiarEstado();
  }
}
