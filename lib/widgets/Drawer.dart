import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/constante/constantes.dart';

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
                    Icons.create,
                    color: Colors.amberAccent,
                  ),
                  title: Text(
                    'Perfil',
                    style: TextStyle(color: Colors.black),
                  ),
                  onLongPress: () {},
                ),
                ListTile(
                  leading: Icon(Icons.update, color: Colors.green),
                  title: Text(
                    'Mis Tareas',
                    style: TextStyle(color: Colors.black),
                  ),
                  onLongPress: () {},
                ),
                ListTile(
                  leading:
                      Icon(Icons.delete_forever_outlined, color: Colors.red),
                  title: Text(
                    'Eliminar Proyecto',
                    style: TextStyle(color: Colors.black),
                  ),
                  onLongPress: () {},
                ),
                ListTile(
                  leading: Icon(Icons.screen_search_desktop_outlined,
                      color: Colors.pinkAccent),
                  title: Text(
                    'Buscar Proyecto',
                    style: TextStyle(color: Colors.black),
                  ),
                  onLongPress: () {},
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kSecondaryColor)),
              onPressed: () {},
              child: Text(
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
