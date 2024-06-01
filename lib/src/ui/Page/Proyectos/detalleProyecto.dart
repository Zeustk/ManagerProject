import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:manager_proyect/src/constante/constantes.dart';
import 'package:manager_proyect/src/domain/controllers/DetallesController.dart';
import 'package:manager_proyect/src/domain/controllers/UsuarioController.dart';
import 'package:manager_proyect/src/domain/models/Proyecto_model.dart';
import 'package:manager_proyect/src/domain/models/Usuario_model.dart';
import 'package:manager_proyect/src/ui/Page/Proyectos/crearProyecto.dart';
import 'package:manager_proyect/src/ui/Page/Usuarios/AdicionarUsuarios.dart';

  UsuariosController gestionUsuarios = UsuariosController();
  List<UsuarioModel> usuariosFiltrados = [];
  DetallesController gestionDetalles= DetallesController();

class DetalleProyectoPage extends StatelessWidget {


 Future<void> AdicionarUsuarios() async {

   List<UsuarioModel> usuariosSeleccionados = (await Get.to<List<UsuarioModel>?>(
                          AdicionarUsuariosPage())) ??
                      [];

   if (usuariosSeleccionados.isNotEmpty){

    // Filtrar los usuarios que no están en usuariosFiltrados
    List<UsuarioModel> nuevosUsuarios = usuariosSeleccionados.where((usuario) {
      return !usuariosFiltrados.contains(usuario);
    }).toList();

    // Añadir los nuevos usuarios a usuariosFiltrados
    usuariosFiltrados.addAll(nuevosUsuarios);

   }                   


 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        actions: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
                onPressed: ()  {
                  
                },
                icon: Image.asset(
                  'assets/agregar.gif',
                  width: 50,
                  height: 50,
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
                icon: Image.asset(
                  'assets/cargando.gif',
                  width: 50,
                  height: 50,
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
                icon: Image.asset(
                  'assets/eliminar.gif',
                  width: 50,
                  height: 50,
                )),
          )
        ],
        title: Text(
          'Información del Proyecto',
          style: TextStyle(color: Colors.white),
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
              border: Border.all(color: Colors.white, width: 5)
              /* color: Color.fromARGB(128, 0, 0, 0) contenedore alfondo  gris*/
              ),
          child: Stack(children: [
            SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Stack(children: [
                  Column(
                    children: [
                      _DetalleProyecto(),
                    ],
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _DetalleProyecto extends StatefulWidget {
  @override
  State<_DetalleProyecto> createState() => _DetalleProyectoState();
}

class _DetalleProyectoState extends State<_DetalleProyecto> {
  ProyectoModel proyecto = Get.arguments as ProyectoModel;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarUsuarios();
  }

  Future<void> cargarUsuarios() async {
    List<UsuarioModel> usuarios =
        await gestionUsuarios.consultarUsuariosPorProyecto(proyecto.idProyecto);

    setState(() {
      usuariosFiltrados = usuarios;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 5),
        width: 420,
        height: 720,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/lider.gif',
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
                        '${proyecto.liderProyecto}',
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/contrato1.gif',
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
                        '${proyecto.nombre}',
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario5.gif',
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
                        '${dateFormat.format(proyecto.fechaInicio)}',
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/calendario6.gif',
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
                        '${dateFormat.format(proyecto.fechaFinalizacion)}',
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
            ),
            Expanded(
              child: ListView.builder(
                itemCount: usuariosFiltrados.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text( usuariosFiltrados[index].email, // Mostrar el nombre del usuario,
                                style: TextStyle(color: Colors.white)),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                gestionDetalles.eliminarUsuarioDeProyecto(usuariosFiltrados[index].idUsuario);
                                cargarUsuarios();
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
            ),
          ],
        ),
      ),
    );
  }
}
