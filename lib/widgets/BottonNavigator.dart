import 'package:flutter/material.dart';
import 'package:login/constante/constantes.dart';

class BotonNavi extends StatefulWidget {
  @override
  State<BotonNavi> createState() => _nameState();
}

class _nameState extends State<BotonNavi> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: kSecondaryColor,
        unselectedItemColor: kSecondaryColor,
        onTap: (value) {
          setState(() {});
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
          )
        ]);
  }
}
