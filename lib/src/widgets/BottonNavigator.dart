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
    // Lógica para ver usuario
    Get.to(Perfil_Usuario());
  }

  void _editar(BuildContext context) {
    // Lógica para editar
    Get.to(Crear_proyectos());
    print('Editar');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: kSecondaryColor,
      unselectedItemColor: kSecondaryColor,
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
          icon: Icon(Icons.manage_accounts_rounded, color: kSecondaryColor),
          label: 'Usuario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit, color: kSecondaryColor),
          label: 'Crear',
        ),
      ],
    );
  }
}
