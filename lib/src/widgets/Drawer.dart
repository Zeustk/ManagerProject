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
      'image': 'assets/perfil.gif',
      'onTap': () {
        Get.to(Perfil_Usuario());
      },
    },
    {
      'title': 'Proyectos',
      'image': 'assets/proyectos.gif',
      'children': [
        {
          'title': 'Ver Proyectos',
          'image': 'assets/verpro.gif',
          'onTap': () {
            Get.offAll(Ver_Proyectos(), arguments: 'Mis Proyectos');
          },
        },
        {
          'title': 'Crear Proyecto',
          'image': 'assets/agregarproyecto.gif',
          'onTap': () {
            Get.to(Crear_proyectos());
          },
        },
      ],
    },
    {
      'title': 'Tareas',
      'image': 'assets/lista.gif',
      'children': [
        {
          'title': 'Ver Tareas',
          'image': 'assets/vertareas.gif',
          'onTap': () {
            Get.offAll(Ver_Proyectos(), arguments: 'Seleccione Un Proyecto');
          },
        },
        {
          'title': 'Crear Tareas',
          'image': 'assets/creartareas.gif',
          'onTap': () {
            Get.to(Crear_Tareas());
          },
        },
      ],
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
                final item = drawerItems[index];
                if (item.containsKey('children')) {
                  // Si el ítem tiene hijos, usa un ExpansionTile
                  return ExpansionTile(
                    iconColor: Colors.blue,
                    collapsedIconColor: Colors.blue,
                    leading: Image.asset(
                      item['image'],
                      width: 35,
                      height: 35,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(color: Colors.black),
                    ),
                    children: List<Widget>.from(
                      item['children'].map<Widget>((child) {
                        return ListTile(
                          leading: Image.asset(
                            child['image'],
                            width: 24.0,
                            height: 24.0,
                          ),
                          title: Text(
                            child['title'],
                            style: TextStyle(color: Colors.black),
                          ),
                          onTap: child['onTap'],
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return ListTile(
                    leading: Image.asset(
                      item['image'],
                      width: 24.0,
                      height: 24.0,
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: item['onTap'],
                  );
                }
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kSecondaryColor),
              ),
              onPressed: () {
                _controllerAuth.CerrarSesionStorage();
                Get.to(Principal());
              },
              child: Row(
                children: [
                  Image.asset('assets/cerrar-sesion.png',
                      width: 30, height: 30),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Cerrar Sesión',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
