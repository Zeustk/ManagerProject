import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';

class BotonNavi extends StatelessWidget {
  void _cargarArchivo(BuildContext context) {
    // Lógica para cargar archivo
    print('Archivo cargado');
  }

  void _verUsuario(BuildContext context) {
    Get.to(Perfil_Usuario());
  }

  void _editar(BuildContext context) {
    Get.to(Crear_proyectos());
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      onTap: (int index) {
        switch (index) {
          case 0:
            _verUsuario(context);
            break;
          case 1:
            _editar(context);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/usuario.png',
            width: 24,
            height: 24,
          ),
          label: 'Usuario',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/proyecto.png',
            width: 24,
            height: 24,
          ),
          label: 'Crear',
        ),
      ],
    );
  }
}
