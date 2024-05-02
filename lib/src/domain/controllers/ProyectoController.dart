
import 'package:get/get.dart';
import 'package:manager_proyect/src/data/providers/Proyectos_Provider.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';

class ProyectoController extends GetxController {
// Método para registrar un nuevo proyecto

   ProyectosProvider gestionProyectos=ProyectosProvider();

  Future<String> registrarProyecto(ProyectoModel proyecto) async {

    //print(proyecto);
    // Llama al método correspondiente del proveedor de servicios
    return gestionProyectos.registrarProyecto(proyecto);
  }

  // Método para consultar todos los proyectos
  Future<List<ProyectoModel>> consultarProyectos() async {
    // Llama al método correspondiente del proveedor de servicios
    return gestionProyectos.consultarProyecto();
  }

  // Método para actualizar un proyecto existente
  Future<String> actualizarProyecto(ProyectoModel proyecto) async {
    // Llama al método correspondiente del proveedor de servicios
    return gestionProyectos.actualizarProyecto(proyecto);
  }

  // Método para eliminar un proyecto existente
  Future<String> eliminarProyecto(int idProyecto) async {
    // Llama al método correspondiente del proveedor de servicios
    return gestionProyectos.eliminarProyecto(idProyecto);
  }

}