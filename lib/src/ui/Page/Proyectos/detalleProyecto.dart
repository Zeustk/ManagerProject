import 'package:flutter/material.dart';
import 'package:manager_proyect/src/constante/constantes.dart';

class DetalleProyectoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.library_add,
                  color: Colors.green,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.update,
                  color: Colors.amber,
                )),
          ),
          Container(
            margin: EdgeInsets.only(left: 8, right: 7),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Colors.red,
                )),
          )
        ],
        title: Text(
          'Información del Proyecto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kSecondaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                _DetalleProyecto(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DetalleProyecto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: 390,
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromARGB(128, 0, 0, 0),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              'Lider del proyecto',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/hombre.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'jose molina carlos',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Nombre del Proyecto',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/proyecto.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        'Implementacion',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Text(
                'Fecha de Inicio',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        '24/05/2024',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Fecha de Finalizacion',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario2.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 230,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        '24/05/2024',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Integrates',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: Row(
                        children: [
                          Text('Integrante $index'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('hola')
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
