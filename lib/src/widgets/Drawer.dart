
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/domain/controllers/authController.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/verProyectos.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/crearTarea.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/PerfilUsuario.dart';
import 'package:manager_proyect/src/ui/Page/home/Principal.dart';
import 'package:manager_proyect/src/constante/constantes.dart';


class Draweer extends StatelessWidget {
  final List<Map<String, dynamic>> drawerItems = [
    {
      'title': 'Perfil',
      'icon': Icons.account_box_rounded,
      'onTap': () {
        Get.to(Perfil_Usuario());
      },
    },
    {
      'title': 'Tareas',
      'icon': Icons.account_balance_wallet_rounded,
      'onTap': () {
        
      },
    },
    {
      'title': 'Ver Tareas',
      'icon': Icons.arrow_forward_sharp,
      'onTap': () {
        Get.offAll(Ver_Proyectos(), arguments: 'Seleccione Un Proyecto');
   
      },
    },
    {
      'title': 'Crear Tareas',
      'icon': Icons.arrow_forward_sharp,
      'onTap': () {
        Get.to(Crear_Tareas());
      },
    },
    {
      'title': 'Proyectos',
      'icon': Icons.account_balance_wallet_rounded,
      'onTap': () {
        
      },
    },
    {
      'title': 'Crear Proyecto',
      'icon': Icons.arrow_forward_sharp,
      'onTap': () {
        Get.to(Crear_proyectos());
      },
    },
    {
      'title': 'Ver Proyectos',
      'icon': Icons.arrow_forward_sharp,
      'onTap': () {
        Get.offAll(Ver_Proyectos(), arguments: 'Mis Proyectos');
      },
    },
  ];

  @override
  Widget build(BuildContext context) {

    AuthController _controllerAuth = Get.find();
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: drawerItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    drawerItems[index]['icon'],
                    color: Colors.blue,
                  ),
                  title: Text(
                    drawerItems[index]['title'],
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: drawerItems[index]['onTap'],
                );
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor),
              ),
              onPressed: () {
                _controllerAuth.CerrarSesionStorage();
                Get.to(Principal());
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
