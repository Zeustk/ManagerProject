import 'package:flutter/material.dart';
import 'package:manager_proyect/constante/constantes.dart';

class BotonNavi extends StatelessWidget {
  void _cargarArchivo(BuildContext context) {
    // Lógica para cargar archivo
    print('Archivo cargado');
  }

  void _verUsuario(BuildContext context) {
    // Lógica para ver usuario
    print('Ver usuario');
  }

  void _editar(BuildContext context) {
    // Lógica para editar
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
            _cargarArchivo(context);
            break;
          case 1:
            _verUsuario(context);
            break;
          case 2:
            _editar(context);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.upload_file_rounded, color: kSecondaryColor),
          label: 'Cargar Archivo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts_rounded, color: kSecondaryColor),
          label: 'Usuario',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit, color: kSecondaryColor),
          label: 'Editar',
        ),
      ],
    );
  }
}
