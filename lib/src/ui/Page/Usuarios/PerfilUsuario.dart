import 'package:flutter/material.dart';
import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/widgets/BottonNavigator.dart';
import 'package:manager_proyect/src/widgets/Drawer.dart';

class Perfil_Usuario extends StatelessWidget {
  const Perfil_Usuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BotonNavi(),
      drawer: Draweer(),
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [],
        title: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Center(
              child: Text(
            'Mi Perfil',
            style: TextStyle(color: Colors.white),
          )),
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/perfil2.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                height: 40,
                width: 142,
                child: Row(
                  children: [
                    Text('Editar',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    MaterialButton(
                      onPressed: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40)),
                        child: Image.asset(
                          'assets/editarusu.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Mi Perfil',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
            Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
            Row(
              children: [
                SizedBox(width: 30),
                Text('Nombre',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(
                  width: 70,
                ),
                Text('Armando Paredes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text('Correo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(
                    width: 78,
                  ),
                  Text('ArmandoParedes141@Gmail.com',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
            Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
            Row(
              children: [
                SizedBox(width: 30),
                Text('N# Proyectos',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 35,
                ),
                Text('15',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
            Row(
              children: [
                SizedBox(width: 30),
                Text('Estado',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(
                  width: 77,
                ),
                Text(
                  'Conectado',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
            Row(
              children: [
                SizedBox(width: 30),
                Text('Pin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(
                  width: 100,
                ),
                Text(
                  '*********',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Mis Proyectos',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Divider(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Text('Proyecto',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      SizedBox(
                        width: 24,
                      ),
                      Text('Implementación de Sistemas Informáticos',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
