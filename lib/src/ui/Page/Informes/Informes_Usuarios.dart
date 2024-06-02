import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';

class DetallesUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/LogoApp.png',
            width: 80,
            fit: BoxFit.cover,
          )
        ],
        foregroundColor: Colors.white,
        title: Center(
          child: Text(
            'Informe Proyecto',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(164, 83, 80, 80),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondoproyecto.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, right: 11, left: 12),
          padding: EdgeInsets.only(top: 30),
          width: double.infinity,
          height: 620,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(128, 0, 0, 0),
            border: Border.all(color: Colors.white, width: 5),
          ),
          child: Stack(children: [
            SafeArea(
              child: Stack(children: [
                Column(
                  children: [
                    DetalleUsuarioTarea(),
                  ],
                ),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }
}

class DetalleUsuarioTarea extends StatelessWidget {
  /* ProyectoModel proyecto = Get.arguments as ProyectoModel;
 */
  @override
  Widget build(BuildContext context) {
    /* DateFormat dateFormat = DateFormat('yyyy-MM-dd'); */

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5),
        width: 420,
        height: 520,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Text(
                'Tareas Completadas',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/tareasT.gif',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 115,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      /* Text(
                        '${proyecto.liderProyecto}',
                        style: TextStyle(color: Colors.black),
                      ) */
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
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                'Tareas En curso',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/tareasT2.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 115,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      /* Text(
                        '${proyecto.nombre}',
                        style: TextStyle(color: Colors.black),
                      ) */
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
              padding: const EdgeInsets.only(right: 24),
              child: Text(
                ' Tareas No Iniciadas',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/tareasT3.gif',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 115,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      /* Text(
                        '${dateFormat.format(proyecto.fechaInicio)}',
                        style: TextStyle(color: Colors.black),
                      ) */
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
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Porcentaje Completado',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 5),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/tareasT4.gif',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  height: 40,
                  width: 115,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      /* Text(
                        '${dateFormat.format(proyecto.fechaFinalizacion)}',
                        style: TextStyle(color: Colors.black),
                      ) */
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            /* SizedBox(
              height: 50,
            ),
            SizedBox(
                width: 340,
                child: Divider(
                  color: Colors.white,
                )),
            Text(
              'Integrates',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ), */
            /* Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Integrante $index',
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(Crear_proyectos());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Image.asset(
                                  'assets/eliminar-usuario.gif',
                                  width: 60,
                                  height: 60,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
