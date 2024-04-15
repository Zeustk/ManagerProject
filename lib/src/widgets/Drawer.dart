import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manager_proyect/src/ui/Page/home/Principal.dart';
import 'package:manager_proyect/src/ui/Page/Tareas/crearTarea.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/models/Proyectos.dart';

class Draweer extends StatelessWidget {
  const Draweer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.account_box_rounded,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Perfil',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.arrow_forward_sharp,
                      color: Colors.blue, size: 30),
                  title: Text(
                    'Mis Tareas',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    Get.to(Crear_Tareas());
                  },
                ),
                ListTile(
                  leading: Icon(Icons.account_balance_wallet_rounded,
                      color: Colors.blue),
                  title: Text(
                    'Mis Proyecto',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.arrow_forward_sharp,
                      color: Colors.blue, size: 30),
                  title: Text(
                    'Crear Proyecto',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kSecondaryColor)),
              onPressed: () {
                Get.to(Principal());
              },
              child: const Text(
                'Cerrar Sesion',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
